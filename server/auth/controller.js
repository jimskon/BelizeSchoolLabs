// server/auth/controller.js
const db = require('../db'); // Adjust path as needed
const { sendEmail } = require('../utils/email'); // Utility to send email
const bcrypt = require('bcrypt');
const { generateReadablePassword } = require('../utils/password');


// Login
exports.login = async (req, res) => {
  const { name, password } = req.body;

  try {
    console.log('Login attempt - School name:', name);
    console.log('Login attempt - password:', password);

    const [[schoolRow]] = await db.query(
      'SELECT * FROM school WHERE name = ?',
      [name]
    );

    if (!schoolRow) {
      return res.json({ success: false, error: 'Invalid credentials' });
    }

    const needsPasswordReset = !!schoolRow.is_temp_password;


    // Compare input password with hashed password
    const passwordMatches = await bcrypt.compare(password, schoolRow.password);

    if (!passwordMatches) {
      return res.json({ success: false, error: 'Invalid credentials' });
    }

    if (!schoolRow) {
      console.log('Login failed: No match');
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
      name: schoolRow.name,
      schoolId: schoolRow.id,  // ← Added this line
      needsValidation,
      //needsPasswordReset
    });


    console.log('Login successful');
  } catch (err) {
    console.error('Login error:', err);
    res.status(500).json({ success: false, error: 'Server error' });
  }
};


// Send password to MOE email
exports.sendPasswordEmail = async (req, res) => {
  const { school_name } = req.body;

  try {
    let emailToSend = null;
    let schoolCode = null;

    // Step 1: Try moe_school_info
    const [[moeRow]] = await db.query(
      'SELECT email, code FROM moe_school_info WHERE name = ?',
      [school_name]
    );

    if (moeRow) {
      emailToSend = moeRow.email;
      schoolCode = moeRow.code;
      console.log(`Using email from moe_school_info: ${emailToSend}`);
    }

    // Step 2: Fallback to school_info
    if (!emailToSend || !schoolCode) {
      const [[infoRow]] = await db.query(
        'SELECT email, code FROM school_info WHERE name = ?',
        [school_name]
      );

      if (infoRow) {
        emailToSend = emailToSend || infoRow.email;
        schoolCode = schoolCode || infoRow.code;
        console.log(`Using fallback email/code from school_info: ${emailToSend}, ${schoolCode}`);
      }
    }

    // Step 3: Fail if no email or code
    if (!emailToSend || !schoolCode) {
      return res.json({ success: false, error: 'Missing email or code for this school' });
    }

    // Step 4: Generate password
    const generatedPassword = generateReadablePassword();
    const hashedPassword = await bcrypt.hash(generatedPassword, 10);  // 10 = salt rounds

    // Step 5: Insert or update school record
    const [[existingSchool]] = await db.query(
      'SELECT id FROM school WHERE name = ?',
      [school_name]
    );

    if (existingSchool) {
      await db.query(
        'UPDATE school SET code = ?, password = ? WHERE id = ?',
        [schoolCode, hashedPassword, existingSchool.id]
      );
      console.log(`Updated password for school ID ${existingSchool.id}`);
    } else {
      await db.query(
        'INSERT INTO school (name, code, password) VALUES (?, ?, ?)',
        [school_name, schoolCode, hashedPassword]
      );
      console.log(`Inserted new school '${school_name}' with code and password`);
    }

    // Step 6: Send email
    await sendEmail({
      to: emailToSend,
      subject: 'Your Belize School Labs Login Password',
      text: `Here is your login password: ${generatedPassword}\n\nYou can use it to log in at belizeschoollabs.org`
    });

    res.json({ success: true, message: 'Password sent and stored successfully' });

  } catch (err) {
    console.error('Send password error:', err);
    res.status(500).json({ success: false, error: 'Failed to send password' });
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

exports.resetPassword = async (req, res) => {
  const { school_id, newPassword } = req.body;

  if (!school_id || !newPassword) {
    return res.status(400).json({ success: false, error: 'Missing school ID or password.' });
  }

  try {
    const hashedPassword = await bcrypt.hash(newPassword, 10); // secure hash

    await db.query(
      'UPDATE school SET password = ?, is_temp_password = FALSE WHERE id = ?',
      [hashedPassword, school_id]
    );

    res.json({ success: true });
  } catch (err) {
    console.error('Password reset error:', err);
    res.status(500).json({ success: false, error: 'Server error during password reset.' });
  }
};



