const db = require('../db');
const { sendEmail } = require('../utils/email');
const bcrypt = require('bcrypt');
const { generateReadablePassword } = require('../utils/password');

// Generate and send a one-time login PIN (valid 10 minutes)
exports.sendLoginPin = async (req, res) => {
  const { school_name } = req.body;
  try {
    let emailTo = null;
    let codeTo = null;
    const [[moeRow]] = await db.query(
      'SELECT email, code FROM moe_school_info WHERE name = ?',
      [school_name]
    );
    if (moeRow && moeRow.email) {
      emailTo = moeRow.email;
      codeTo = moeRow.code;
    } else {
      const [[infoRow]] = await db.query(
        'SELECT email, code FROM school_info WHERE name = ?',
        [school_name]
      );
      if (infoRow && infoRow.email) {
      emailTo = infoRow.email;
      codeTo = infoRow.code;
      }
    }
    if (!emailTo) {
      return res.json({ success: false, error: 'Missing email for this school' });
    }
    const pin = Math.floor(100000 + Math.random() * 900000).toString();
    const expiresAt = new Date(Date.now() + 10 * 60 * 1000);
    let [[schoolRow]] = await db.query(
      'SELECT id FROM school WHERE name = ?',
      [school_name]
    );
    if (!schoolRow || !schoolRow.id) {
      await db.query(
        'INSERT INTO school (name, code) VALUES (?, ?)',
        [school_name, codeTo]
      );
      [[schoolRow]] = await db.query(
        'SELECT id FROM school WHERE name = ?',
        [school_name]
      );
    }
    const school = schoolRow;
    await db.query(
      'UPDATE school SET login_pin = ?, pin_expires_at = ? WHERE id = ?',
      [pin, expiresAt, school.id]
    );
    await sendEmail({
      to: emailTo,
      subject: 'Your Login PIN',
      text: `Your login PIN is ${pin}. It expires in 10 minutes.`
    });
    res.json({ success: true });
  } catch (err) {
    console.error('sendLoginPin error:', err);
    res.status(500).json({ success: false, error: 'Failed to send login PIN' });
  }
};

// Authenticate with PIN
exports.login = async (req, res) => {
  const { name, pin } = req.body;
  try {
    const [rows] = await db.query(
      'SELECT id, login_pin, pin_expires_at FROM school WHERE name = ?',
      [name]
    );
    const school = rows[0];
    if (!school) {
      return res.json({ success: false, error: 'Invalid credentials' });
    }
    if (!school.login_pin || school.login_pin !== pin) {
      return res.json({ success: false, error: 'Invalid or expired PIN' });
    }
    if (!school.pin_expires_at || new Date(school.pin_expires_at) < new Date()) {
      return res.json({ success: false, error: 'PIN expired' });
    }
    await db.query('UPDATE school SET login_pin = NULL, pin_expires_at = NULL WHERE id = ?', [school.id]);
    const [infoRows] = await db.query(
      'SELECT id FROM school_info WHERE school_id = ?',
      [school.id]
    );
    const needsValidation = infoRows.length === 0;
    res.json({ success: true, schoolId: school.id, needsValidation });
  } catch (err) {
    console.error('login error:', err);
    res.status(500).json({ success: false, error: 'Server error' });
  }
};

// Request account manually

// Submit contact correction request
exports.submitCorrection = async (req, res) => {
  const { schoolName, contactEmail, contactName, contactPhone } = req.body;
  try {
    await db.query(
      `INSERT INTO contact_corrections
       (school_name, contact_email, contact_name, contact_phone)
       VALUES (?, ?, ?, ?)`,
      [schoolName, contactEmail, contactName, contactPhone]
    );
    res.json({ success: true });
  } catch (err) {
    console.error('submitCorrection error:', err);
    res.status(500).json({ success: false, error: 'Failed to submit correction' });
  }
};
exports.requestAccount = async (req, res) => {
  const { schoolName, district, email, phone, address, manager, managerEmail, managerPhone } = req.body;
  try {
    await db.query(
      `INSERT INTO account_requests
       (school_name, district, school_email, school_phone, school_address, manager_name, manager_email, manager_phone, status)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'pending')`,
      [schoolName, district, email, phone, address, manager, managerEmail, managerPhone]
    );
    res.json({ success: true });
  } catch (err) {
    console.error('requestAccount error:', err);
    res.status(500).json({ success: false, error: 'Database error' });
  }
};

// Send password to MOE email (deprecated)
exports.sendPasswordEmail = async (req, res) => {
  const { school_name } = req.body;
  try {
    let emailToSend = null;
    let schoolCode = null;
    const [[moeRow]] = await db.query(
      'SELECT email, code FROM moe_school_info WHERE name = ?',
      [school_name]
    );
    if (moeRow) {
      emailToSend = moeRow.email;
      schoolCode = moeRow.code;
    }
    if (!emailToSend || !schoolCode) {
      const [[infoRow]] = await db.query(
        'SELECT email, code FROM school_info WHERE name = ?',
        [school_name]
      );
      if (infoRow) {
        emailToSend = emailToSend || infoRow.email;
        schoolCode = schoolCode || infoRow.code;
      }
    }
    if (!emailToSend || !schoolCode) {
      return res.json({ success: false, error: 'Missing email or code for this school' });
    }
    const generatedPassword = generateReadablePassword();
    const hashedPassword = await bcrypt.hash(generatedPassword, 10);
    const [[existing]] = await db.query('SELECT id FROM school WHERE name = ?', [school_name]);
    if (existing && existing.id) {
      await db.query('UPDATE school SET code = ?, password = ? WHERE id = ?', [schoolCode, hashedPassword, existing.id]);
    } else {
      await db.query('INSERT INTO school (name, code, password) VALUES (?, ?, ?)', [school_name, schoolCode, hashedPassword]);
    }
    await sendEmail({ to: emailToSend, subject: 'Your Password', text: `Your password is ${generatedPassword}` });
    res.json({ success: true });
  } catch (err) {
    console.error('sendPasswordEmail error:', err);
    res.status(500).json({ success: false, error: 'Failed to send code' });
  }
};

// Other admin handlers
exports.getPendingRequests = async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM account_requests WHERE status = "pending"');
    res.json({ success: true, requests: rows });
  } catch (err) {
    console.error('getPendingRequests error:', err);
    res.status(500).json({ success: false, error: 'Failed to fetch requests' });
  }
};

exports.approveRequest = async (req, res) => {
  const { requestId, generatedPassword } = req.body;
  try {
    const [[request]] = await db.query('SELECT * FROM account_requests WHERE id = ?', [requestId]);
    if (!request) return res.json({ success: false, error: 'Request not found' });
    await db.query(
      `INSERT INTO school (name, district, email, phone, address, password)
       VALUES (?, ?, ?, ?, ?, ?)`,
      [request.school_name, request.district, request.school_email, request.school_phone, request.school_address, generatedPassword]
    );
    await db.query('UPDATE account_requests SET status = "approved" WHERE id = ?', [requestId]);
    res.json({ success: true });
  } catch (err) {
    console.error('approveRequest error:', err);
    res.status(500).json({ success: false, error: 'Approval failed' });
  }
};

exports.resetPassword = async (req, res) => {
  const { school_id, newPassword } = req.body;
  if (!school_id || !newPassword) return res.status(400).json({ success: false, error: 'Missing school_id or password' });
  try {
    const hashed = await bcrypt.hash(newPassword, 10);
    await db.query('UPDATE school SET password = ?, is_temp_password = FALSE WHERE id = ?', [hashed, school_id]);
    res.json({ success: true });
  } catch (err) {
    console.error('resetPassword error:', err);
    res.status(500).json({ success: false, error: 'Reset failed' });
  }
};