// server/request/controller.js

const pool = require('../db');
const { sendEmail } = require('../utils/email');
const crypto = require('crypto');

// ============================================
// POST /submit-request
// ============================================
// Accepts a request from a school to be contacted or registered in the system.
// Stores the information in the `account_requests` table for admin review.
// This might be used when a school is requesting onboarding manually.
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
    // Insert the request details into the `account_requests` table
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

    // Send success response
    res.json({ success: true });
  } catch (err) {
    console.error("Error submitting account request:", err);
    res.status(500).json({ success: false, error: err.message });
  }
};

// ============================================
// GET /requests
// ============================================
// Returns a list of all account requests stored in the `account_requests` table.
// Used by admins to review incoming school requests, optionally approve or reject them.
exports.getRequests = async (req, res) => {
  try {
    // Fetch all requests ordered by most recent first
    const [rows] = await pool.query(`SELECT * FROM account_requests ORDER BY requested_at DESC`);
    res.json(rows);
  } catch (err) {
    console.error("Error retrieving account requests:", err);
    res.status(500).json({ success: false, error: err.message });
  }
};

// ============================================
// POST /request-account
// ============================================
// Automatically registers a new school account in the system:
//  1. Inserts the school into the `school` table
//  2. Tracks the request in `account_requests` with status 'approved'
//  3. Emails the auto-generated password to the school's email
exports.requestAccount = async (req, res) => {
  const {
    schoolName, district, email, phone, address,
    manager, managerEmail, managerPhone
  } = req.body;

  // STEP 1: Generate a random password (8-character hex string)
  const generatedPassword = crypto.randomBytes(4).toString('hex'); // e.g., 'a7b9c2d3'

  try {
    // STEP 2: Create the school account in the main `school` table
    await db.query(
      `INSERT INTO school (name, district, email, phone, address, password)
       VALUES (?, ?, ?, ?, ?, ?)`,
      [schoolName, district, email, phone, address, generatedPassword]
    );

    // STEP 3: Optionally log the request in `account_requests` with status 'approved'
    await db.query(
      `INSERT INTO account_requests
      (school_name, district, school_email, school_phone, school_address,
       manager_name, manager_email, manager_phone, status)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'approved')`,
      [schoolName, district, email, phone, address, manager, managerEmail, managerPhone]
    );

    // STEP 4: Send the generated password to the school's email address
    await sendEmail({
      to: email,
      subject: 'Your Belize School Labs Account Password',
      text: `Thank you for registering. Your login password is: ${generatedPassword}`
    });

    // STEP 5: Respond with success
    res.json({ success: true });
  } catch (err) {
    console.error('Request account error:', err);
    res.status(500).json({ success: false, error: 'Server error creating account.' });
  }
};
