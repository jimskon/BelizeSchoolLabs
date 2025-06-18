// server/request/controller.js
const pool = require('../db');

exports.submitRequest = async (req, res) => {
  const {
    school_name,
    code,
    district,
    school_address,
    contact_name,
    contact_email,
    contact_phone,
    school_phone,
    school_email
  } = req.body;

  try {
    await pool.query(
      `INSERT INTO account_requests (
        school_name, code, district, school_address,
        contact_name, contact_email, contact_phone,
        school_phone, school_email
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        school_name,
        code,
        district,
        school_address,
        contact_name,
        contact_email,
        contact_phone,
        school_phone,
        school_email
      ]
    );
    res.json({ success: true });
  } catch (err) {
    console.error("Error submitting account request:", err);
    res.status(500).json({ success: false, error: err.message });
  }
};

exports.getRequests = async (req, res) => {
  try {
    const [rows] = await pool.query(`SELECT * FROM account_requests ORDER BY requested_at DESC`);
    res.json(rows);
  } catch (err) {
    console.error("Error retrieving account requests:", err);
    res.status(500).json({ success: false, error: err.message });
  }
};

const { sendEmail } = require('../utils/email');
const crypto = require('crypto');

exports.requestAccount = async (req, res) => {
  const {
    schoolName, district, email, phone, address,
    manager, managerEmail, managerPhone
  } = req.body;

  // Step 1: Generate a random password
  const generatedPassword = crypto.randomBytes(4).toString('hex'); // e.g., 'a7b9c2d3'

  try {
    // Step 2: Insert into school table (this is the official account)
    await db.query(
      `INSERT INTO school (name, district, email, phone, address, password)
       VALUES (?, ?, ?, ?, ?, ?)`,
      [schoolName, district, email, phone, address, generatedPassword]
    );

    // Optional: track this in account_requests too
    await db.query(
      `INSERT INTO account_requests
      (school_name, district, school_email, school_phone, school_address,
       manager_name, manager_email, manager_phone, status)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'approved')`,
      [schoolName, district, email, phone, address, manager, managerEmail, managerPhone]
    );

    // Step 3: Send email to school
    await sendEmail({
      to: email,
      subject: 'Your Belize School Labs Account Password',
      text: `Thank you for registering. Your login password is: ${generatedPassword}`
    });

    res.json({ success: true });
  } catch (err) {
    console.error('Request account error:', err);
    res.status(500).json({ success: false, error: 'Server error creating account.' });
  }
};

