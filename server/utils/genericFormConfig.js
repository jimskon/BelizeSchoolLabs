// server/utils/genericFormConfig.js
const db = require('../db');

exports.getFormConfig = async (req, res) => {
  const tableName = req.params.tableName;

  try {
    const [rows] = await db.query(
      'SELECT * FROM form_config WHERE name = ? ORDER BY id',
      [tableName]
    );

    if (rows.length === 0) {
      return res.status(404).json({ success: false, error: 'No config found for this table' });
    }

    res.json({ success: true, fields: rows });
  } catch (err) {
    console.error('Form config error:', err);
    res.status(500).json({ success: false, error: 'Failed to fetch form configuration' });
  }
};
