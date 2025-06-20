// source/school/controller.js
const pool = require('../db');



exports.getMoeSchools = async (req, res) => {
  const [rows] = await pool.query('SELECT name, district FROM moe_school_info ORDER BY name');
  //console.log("SCHOOLS:",rows);
  res.json(rows);
};

exports.getMoeSchoolByName = async (req, res) => {
  const [rows] = await pool.query(
    'SELECT * FROM moe_school_info WHERE name = ? LIMIT 1',
    [req.query.name]
  );
  res.json(rows[0] || {});
};

exports.validateAndCreateSchool = async (req, res) => {
  const data = req.body;
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();

    // Step 1: Create school
    const [schoolResult] = await conn.query(`
      INSERT INTO school (name, code)
      VALUES (?, ?)`,
      [data.name, data.code]
    );

    const schoolId = schoolResult.insertId;

    // Step 2: Create school_info
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
      data.moe_name || data.name,
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
      (data.year_opened ? parseInt(data.year_opened, 10) : null),
      (data.longitude ? parseFloat(data.longitude) : null),
      (data.latitude ? parseFloat(data.latitude) : null),
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

    await conn.commit();
    res.json({ success: true, school: { id: schoolId, name: data.name } });
  } catch (err) {
    await conn.rollback();
    console.error('Validation error:', err);
    res.status(500).json({ success: false, error: err.message });
  } finally {
    conn.release();
  }
};

exports.getValidationPrefillData = async (req, res) => {
  const schoolName = req.query.name;

  try {
    const [[moeRow]] = await pool.query(
      'SELECT * FROM moe_school_info WHERE name = ?',
      [schoolName]
    );

    if (!moeRow) {
      return res.status(404).json({ error: 'MOE school not found' });
    }

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
