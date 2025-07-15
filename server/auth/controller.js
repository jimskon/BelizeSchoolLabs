
// Database connection
const db = require('../db');
// Utility for sending emails
const { sendEmail } = require('../utils/email');
// Library for password hashing
const bcrypt = require('bcrypt');


// ==============================
// Send One-Time Login PIN (Valid for 10 Minutes)
// Handles sending a login PIN to the school's email for authentication
// ==============================
exports.sendLoginPin = async (req, res) => {
  const { school_name } = req.body;
  try {
    let emailTo = null;
    let codeTo = null;

    // First, try to get the email and code from school_info
    const [[moeRow]] = await db.query(
      'SELECT email, code FROM school_info WHERE name = ?',
      [school_name]
    );

    if (moeRow && moeRow.email) {
      emailTo = moeRow.email;
      codeTo = moeRow.code;
    } else {
      // Fallback: attempt to retrieve from the same table again
      const [[infoRow]] = await db.query(
        'SELECT email, code FROM school_info WHERE name = ?',
        [school_name]
      );
      if (infoRow && infoRow.email) {
        emailTo = infoRow.email;
        codeTo = infoRow.code;
      }
    }

    // If no email was found, return an error
    if (!emailTo) {
      return res.json({ success: false, error: 'Missing email for this school' });
    }

    // Generate a 6-digit random PIN and expiration time (24 hours from now)
    const pin = Math.floor(100000 + Math.random() * 900000).toString();
    const expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000); // 24 hours

    // Check if the school is already in the login tracking table
    let [[schoolRow]] = await db.query(
      'SELECT code FROM school WHERE code = ?',
      [codeTo]
    );

    // If not, insert a new entry into the `school` table
    if (!schoolRow || !schoolRow.code) {
      await db.query(
        'INSERT INTO school (name, code) VALUES (?, ?)',
        [school_name, codeTo]
      );
      [[schoolRow]] = await db.query(
        'SELECT code FROM school WHERE code = ?',
        [codeTo]
      );
    }

    const schoolCode = schoolRow.code;

    // Save the PIN and expiration in the school login table
    await db.query(
      'UPDATE school SET password = ?, password_expires_at = ? WHERE code = ?',
      [pin, expiresAt, schoolCode]
    );

    // Send PIN to the school via email
    await sendEmail({
      to: emailTo,
      subject: 'Your Login PIN',
      text: `Your login PIN is ${pin}. It expires in 24 hours.`
    });

    res.json({ success: true });

  } catch (err) {
    console.error('sendLoginPin error:', err);
    res.status(500).json({ success: false, error: 'Failed to send login PIN' });
  }
};

// ==============================
// Login Using PIN (One-time login flow)
// ==============================
exports.login = async (req, res) => {
  const { name, pin } = req.body;
  try {
    // Get the school's login credentials
    const [rows] = await db.query(
      'SELECT code, password, password_expires_at FROM school WHERE name = ?',
      [name]
    );
    const school = rows[0];

    // If school does not exist or credentials are invalid
    if (!school) {
      return res.json({ success: false, error: 'Invalid credentials' });
    }

    // If password does not match the pin
    if (!school.password || school.password !== pin) {
      return res.json({ success: false, error: 'Invalid PIN' });
    }

    // If the PIN is expired
    if (!school.password_expires_at || new Date(school.password_expires_at) < new Date()) {
      return res.json({ success: false, error: 'PIN expired' });
    }

    // Login successful — you may want to invalidate the PIN here
    // await db.query('UPDATE school SET password = NULL, password_expires_at = NULL WHERE code = ?', [school.code]);

    // Check if the school still needs to validate its data
    const [infoRows] = await db.query(
      'SELECT code FROM school_info WHERE code = ?',
      [school.code]
    );
    const needsValidation = infoRows.length === 0;

    res.json({ success: true, code: school.code, needsValidation });
  } catch (err) {
    console.error('login error:', err);
    res.status(500).json({ success: false, error: 'Server error' });
  }
};

// ==============================
// Request a New Account (Manual)
// ==============================
exports.requestAccount = async (req, res) => {
  const { school_name, district, school_email, school_phone, school_address } = req.body;
  try {
    await db.query(
      `INSERT INTO account_requests (school_name, district, school_email, school_phone, school_address, status)
       VALUES (?, ?, ?, ?, ?, 'pending')`,
      [school_name, district, school_email, school_phone, school_address]
    );
    res.json({ success: true });
  } catch (err) {
    console.error('requestAccount error:', err);
    res.status(500).json({ success: false, error: 'Failed to request account' });
  }
};

// ==============================
// Submit Contact Correction Request
// ==============================
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

// ==============================
// Deprecated: Send Password (Old Flow)
// ==============================
// This block is left commented for reference but is no longer in use.
/*
exports.sendPasswordEmail = async (req, res) => {
  const { school_name } = req.body;
  try {
    let emailToSend = null;
    let schoolCode = null;

    const [[moeRow]] = await db.query(
      'SELECT email, code FROM school_info WHERE name = ?',
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

    const [[existing]] = await db.query('SELECT code FROM school WHERE name = ?', [school_name]);
    if (existing && existing.code) {
      await db.query(
        'UPDATE school SET code = ?, password = ? WHERE code = ?',
        [schoolCode, hashedPassword, existing.code]
      );
    } else {
      await db.query(
        'INSERT INTO school (name, code, password) VALUES (?, ?, ?)',
        [school_name, schoolCode, hashedPassword]
      );
    }

    await sendEmail({
      to: emailToSend,
      subject: 'Your Password',
      text: `Your password is ${generatedPassword}`
    });

    res.json({ success: true });

  } catch (err) {
    console.error('sendPasswordEmail error:', err);
    res.status(500).json({ success: false, error: 'Failed to send code' });
  }
};
*/

// ==============================
// Other Admin Handlers (commented)
// ==============================
// Uncomment and use only if admin interfaces are needed:
/*
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
  if (!school_id || !newPassword)
    return res.status(400).json({ success: false, error: 'Missing school_id or password' });

  try {
    const hashed = await bcrypt.hash(newPassword, 10);
    await db.query('UPDATE school SET password = ?, is_temp_password = FALSE WHERE code = ?', [hashed, school_id]);
    res.json({ success: true });
  } catch (err) {
    console.error('resetPassword error:', err);
    res.status(500).json({ success: false, error: 'Reset failed' });
  }
};
*/

