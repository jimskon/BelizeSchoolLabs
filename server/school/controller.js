// source/school/controller.js

const pool = require('../db');

// =======================================
// GET /api/moe-schools
// =======================================
// Fetches all schools from `school_info`.
// Removes duplicate entries based on `code` before returning.
exports.getMoeSchools = async (req, res) => {
  // Query all school records sorted by name
  const [rows] = await pool.query(
    'SELECT code, name, district, type FROM school_info ORDER BY name'
  );

  // Deduplicate based on `code` using a Map
  const unique = Array.from(new Map(rows.map(s => [s.code, s])).values());

  res.json(unique);
};

// =======================================
// GET /api/moe-school-by-name?name=XYZ
// =======================================
// Retrieves a specific school's full record by name from `school_info`.
// If not found, returns an empty object.
exports.getMoeSchoolByName = async (req, res) => {
  const [rows] = await pool.query(
    'SELECT * FROM school_info WHERE name = ? LIMIT 1',
    [req.query.name]
  );
  res.json(rows[0] || {});
};

// =======================================
// POST /api/validate-and-create-school
// =======================================
// Validates submitted school data, then creates a new entry in:
//   1. `school` (basic login info)
//   2. `school_info` (detailed MOE data)
// Uses a transaction to ensure both inserts succeed together.
exports.validateAndCreateSchool = async (req, res) => {
  const data = req.body;
  const conn = await pool.getConnection();

  try {
    await conn.beginTransaction(); // Start transaction

    // Step 1: Insert into `school` table with name and code
    const [schoolResult] = await conn.query(`
      INSERT INTO school (name, code)
      VALUES (?, ?)`,
      [data.name, data.code]
    );
    const schoolId = schoolResult.insertId;

    // Step 2: Insert into `school_info` with full metadata
    await conn.query(`
      INSERT INTO school_info (
        school_id, moe_name, name, code, address,
        contact_person, telephone, telephone_alt1, telephone_alt2,
        moe_email, email, email_alt, website,
        year_opened, longitude, latitude,
        district, locality, type, sector, ownership,
        school_administrator_1, school_administrator_2,
        comments, admin_comments,
        verified_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())
    `, [
      schoolId,
      data.moe_name || data.name,                      // fallback if `moe_name` missing
      data.name,
      data.code,
      data.address || '',
      data.contact_person || '',
      data.telephone || '',
      data.telephone_alt1 || '',
      data.telephone_alt2 || '',
      data.moe_email || '',
      data.email || '',
      data.email_alt || '',
      data.website || '',
      data.year_opened ? parseInt(data.year_opened, 10) : null,
      data.longitude ? parseFloat(data.longitude) : null,
      data.latitude ? parseFloat(data.latitude) : null,
      data.district || '',
      data.locality || '',
      data.type || '',
      data.sector || '',
      data.ownership || '',
      data.school_administrator_1 || '',
      data.school_administrator_2 || '',
      data.comments || '',
      data.admin_comments || ''
    ]);

    await conn.commit(); // Commit transaction if both inserts succeed

    // Return success with new school ID
    res.json({ success: true, school: { id: schoolId, name: data.name } });

  } catch (err) {
    await conn.rollback(); // Roll back transaction if error occurs
    console.error('Validation error:', err);
    res.status(500).json({ success: false, error: err.message });
  } finally {
    conn.release(); // Release DB connection
  }
};

// =======================================
// GET /api/validation-prefill?name=XYZ
// =======================================
// Pulls default MOE record from `moe_school_info`
// to prefill form fields for easier validation.
exports.getValidationPrefillData = async (req, res) => {
  const schoolName = req.query.name;

  try {
    // Fetch one MOE school record by name
    const [[moeRow]] = await pool.query(
      'SELECT * FROM moe_school_info WHERE name = ?',
      [schoolName]
    );

    if (!moeRow) {
      return res.status(404).json({ error: 'MOE school not found' });
    }

    // Return a simplified prefill object, with fallbacks where necessary
    res.json({
      moe_name: moeRow.name,
      name: moeRow.name,
      code: moeRow.code,
      address: moeRow.address,
      contact_person: moeRow.contact_person || moeRow.school_Administrator_1 || '',
      telephone: moeRow.telephone || '',
      telephone_alt1: moeRow.telephone_alt1 || '',
      telephone_alt2: moeRow.telephone_alt2 || '',
      email: moeRow.email || '',
      email_alt: '',
      website: moeRow.website || '',
      year_opened: moeRow.year_opened || null,
      district: moeRow.district || '',
      locality: moeRow.locality || '',
      type: moeRow.type || '',
      sector: moeRow.sector || '',
      ownership: moeRow.ownership || '',
      school_administrator_1: moeRow.school_Administrator_1 || '',
      school_administrator_2: moeRow.school_Administrator_2 || '',
    });

  } catch (err) {
    console.error('Prefill fetch error:', err);
    res.status(500).json({ error: 'Failed to load prefill data' });
  }
};
