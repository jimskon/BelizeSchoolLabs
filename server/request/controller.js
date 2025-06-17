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
