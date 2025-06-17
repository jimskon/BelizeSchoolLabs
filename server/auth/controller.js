const db = require('../db'); // Adjust path as needed
const { sendEmail } = require('../utils/email'); // Utility to send email

// Login
exports.login = async (req, res) => {
  const { school, password } = req.body;

  try {
    const [[schoolRow]] = await db.query(
      'SELECT * FROM school WHERE name = ? AND password = ?',
      [school, password]
    );

    if (!schoolRow) {
      return res.json({ success: false, error: 'Invalid credentials' });
    }

    // Check if school_info entry exists
    const [infoRows] = await db.query(
      'SELECT id FROM school_info WHERE school_id = ?',
      [schoolRow.id]
    );

    const needsValidation = infoRows.length === 0;

    res.json({
      success: true,
      school: schoolRow,
      needsValidation
    });
  } catch (err) {
    console.error('Login error:', err);
    res.status(500).json({ success: false, error: 'Server error' });
  }
};


// Send password to MOE email
exports.sendPasswordEmail = async (req, res) => {
  const { school_name } = req.body;

  try {
    const [rows] = await db.query(
      'SELECT password, moe_email FROM moe_school_info WHERE name = ?',
      [school_name]
    );

    if (rows.length === 0 || !rows[0].moe_email) {
      return res.json({ success: false, error: 'Email not found for this school' });
    }

    const { password, moe_email } = rows[0];
    await sendEmail({
      to: moe_email,
      subject: 'Your Belize School Labs Account Password',
      text: `Your login password is: ${password}`
    });

    res.json({ success: true });
  } catch (err) {
    console.error('Send email error:', err);
    res.status(500).json({ success: false, error: 'Failed to send email' });
  }
};

// Request account manually
exports.requestAccount = async (req, res) => {
  const {
    schoolName, district, email, phone, address,
    manager, managerEmail, managerPhone
  } = req.body;

  try {
    await db.query(
      `INSERT INTO account_requests
      (school_name, district, school_email, school_phone, school_address,
       manager_name, manager_email, manager_phone, status)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'pending')`,
      [schoolName, district, email, phone, address, manager, managerEmail, managerPhone]
    );

    res.json({ success: true });
  } catch (err) {
    console.error('Request account error:', err);
    res.status(500).json({ success: false, error: 'Database error' });
  }
};

// Admin: Get pending requests
exports.getPendingRequests = async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT * FROM account_requests WHERE status = "pending"'
    );
    res.json({ success: true, requests: rows });
  } catch (err) {
    console.error('Get requests error:', err);
    res.status(500).json({ success: false, error: 'Failed to fetch requests' });
  }
};

// Admin: Approve request
exports.approveRequest = async (req, res) => {
  const { requestId, generatedPassword } = req.body;

  try {
    const [[request]] = await db.query(
      'SELECT * FROM account_requests WHERE id = ?',
      [requestId]
    );

    if (!request) {
      return res.json({ success: false, error: 'Request not found' });
    }

    // Create school + organization (simplified, adjust as needed)
    await db.query(
      `INSERT INTO school (name, district, email, phone, address, password)
       VALUES (?, ?, ?, ?, ?, ?)`,
      [
        request.school_name, request.district, request.school_email,
        request.school_phone, request.school_address, generatedPassword
      ]
    );

    await db.query(
      'UPDATE account_requests SET status = "approved" WHERE id = ?',
      [requestId]
    );

    res.json({ success: true });
  } catch (err) {
    console.error('Approve request error:', err);
    res.status(500).json({ success: false, error: 'Approval failed' });
  }
};
