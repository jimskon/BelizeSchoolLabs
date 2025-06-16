const pool = require('../db');
const { generateMnemonicPassword } = require('../utils/password');

exports.getMoeSchools = async (req, res) => {
    const [rows] = await pool.query('SELECT name FROM moe_school_info ORDER BY name');
    console.log("SCHOOLS:",rows);
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

    // Step 1: Create mnemonic password
    const password = generateMnemonicPassword();

    // Step 2: Create organization
    const [orgResult] = await conn.query(`
      INSERT INTO organization (type, name, address, person, phone, email, password)
      VALUES (?, ?, ?, ?, ?, ?, ?)`,
      ['school', data.name, data.address, data.contact_person, data.telephone, data.email, password]
    );

    const orgId = orgResult.insertId;

    // Step 3: Create school
    const [schoolResult] = await conn.query(`
      INSERT INTO school (organization_id)
      VALUES (?)`, [orgId]
    );

    const schoolId = schoolResult.insertId;

    // Step 4: Create school_info
    await conn.query(`
      INSERT INTO school_info (school_id, moe_name, name, code, address, contact_person, telephone, email,
        district, locality, type, sector, ownership, verified_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())`,
      [schoolId, data.name, data.name, data.code, data.address, data.contact_person, data.telephone,
        data.email, data.district, data.locality, data.type, data.sector, data.ownership]
    );

    await conn.commit();
    res.json({ success: true, password });
  } catch (err) {
    await conn.rollback();
    console.error(err);
    res.status(500).json({ success: false, error: err.message });
  } finally {
    conn.release();
  }
};
