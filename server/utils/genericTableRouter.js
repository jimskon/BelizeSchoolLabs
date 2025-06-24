const express = require('express');
const router = express.Router();
const db = require('../db');

// Editable tables
const ALLOWED_TABLES = [
  'school_info',
  'demographics',
  'curriculum',
  'computerRoom',
  'resources'
];

// Validate table parameter
router.use('/:table', (req, res, next) => {
  const { table } = req.params;
  if (!ALLOWED_TABLES.includes(table)) {
    return res.status(404).json({ error: 'Table not found' });
  }
  next();
});

// GET ALL: list all records for table
router.get('/:table/list', async (req, res) => {
  const { table } = req.params;
  try {
    const [rows] = await db.query('SELECT * FROM ??', [table]);
    res.json(rows);
  } catch (err) {
    console.error(`Error listing data for table ${table}:`, err);
    res.status(500).json({ error: 'Failed to list data' });
  }
});

// GET: fetch or build empty record
router.get('/:table', async (req, res) => {
  const { table } = req.params;
  const schoolId = req.query.school_id;
  if (!schoolId || isNaN(Number(schoolId))) {
    return res.status(400).json({ error: 'Invalid or missing school_id' });
  }
  try {
    const [rows] = await db.query(
      `SELECT * FROM ?? WHERE school_id = ? LIMIT 1`,
      [table, schoolId]
    );
    if (rows.length > 0) {
      const result = rows[0];
      if (table === 'school_info') delete result.admin_comments;
      return res.json(result);
    }
    // Build empty based on columns
    const [cols] = await db.query(`SHOW COLUMNS FROM ??`, [table]);
    const emptyRow = {};
    cols.forEach(col => {
      const f = col.Field;
      if (['id'].includes(f)) return;
      if (f === 'school_id') emptyRow[f] = Number(schoolId);
      else emptyRow[f] = null;
    });
    // Insert an empty record to mark progress as soon as accessed
    const insertFields = Object.keys(emptyRow);
    const placeholders = insertFields.map(() => '?').join(', ');
    await db.query(
      `INSERT INTO ?? (${insertFields.map(f => `\`${f}\``).join(', ')}) VALUES (${placeholders})`,
      [table, ...insertFields.map(f => emptyRow[f])]
    );
    return res.json(emptyRow);
  } catch (err) {
    console.error(`Error fetching data for table ${table}:`, err);
    res.status(500).json({ error: 'Failed to fetch data' });
  }
});

// POST: insert or update record
router.post('/:table', async (req, res) => {
  const { table } = req.params;
  const data = req.body;

  // Normalize boolean and numeric string values
  Object.keys(data).forEach(key => {
    if (data[key] === 'Yes') data[key] = 1;
    else if (data[key] === 'No') data[key] = 0;
    else if (typeof data[key] === 'string' && /^[0-9]+$/.test(data[key])) data[key] = Number(data[key]);
  });
  const schoolId = data.school_id;
  if (!schoolId || isNaN(Number(schoolId))) {
    return res.status(400).json({ success: false, error: 'Invalid or missing school_id' });
  }
  // Exclude read-only and admin_comments
  const fields = Object.keys(data).filter(
    key => !['id','school_id','created_at','updated_at','verified_at','admin_comments'].includes(key)
  );
  const values = fields.map(k => data[k]);
  try {
    const [[existing]] = await db.query(
      `SELECT id FROM ?? WHERE school_id = ? LIMIT 1`,
      [table, schoolId]
    );
    if (existing && existing.id) {
      const setClause = fields.map(f => `\`${f}\` = ?`).join(', ');
      await db.query(
        `UPDATE ?? SET ${setClause} WHERE school_id = ?`,
        [table, ...values, schoolId]
      );
    } else {
      const cols = ['school_id', ...fields].map(f => `\`${f}\``).join(', ');
      const placeholders = Array(fields.length + 1).fill('?').join(', ');
      await db.query(
        `INSERT INTO ?? (${cols}) VALUES (${placeholders})`,
        [table, schoolId, ...values]
      );
    }
    res.json({ success: true });
  } catch (err) {
    console.error(`Error saving data for table ${table}:`, err);
    res.status(500).json({ success: false, error: 'Save failed' });
  }
});

module.exports = router;
