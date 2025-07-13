const express = require('express');
const router = express.Router();
const db = require('../db');

// Editable tables
const ALLOWED_TABLES = [
  'school_info',
  'demographics',
  'curriculum',
  'computerRoom',
  'resources',
  'pictures',
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

// GET: fetch or build empty record by code
router.get('/:table', async (req, res) => {
  const { table } = req.params;
  const code = req.query.code;
  if (!code) {
    return res.status(400).json({ error: 'Invalid or missing code' });
  }
  try {
    const [rows] = await db.query(
      `SELECT * FROM ?? WHERE code = ? LIMIT 1`,
      [table, code]
    );
    if (rows.length > 0) {
      const result = rows[0];
      if (table === 'school_info') delete result.admin_comments;
      return res.json(result);
    }
    // For 'pictures', do NOT auto-insert an empty row
    if (table === 'pictures') {
      return res.json({});
    }
    // Build empty based on columns for other tables
    const [cols] = await db.query(`SHOW COLUMNS FROM ??`, [table]);
    const emptyRow = {};
    cols.forEach(col => {
      const f = col.Field;
      if (f === 'code') {
        emptyRow[f] = code;
      } else if ([
        'code', 'created_at', 'updated_at', 'verified_at', 'admin_comments'
      ].includes(f)) {
        // skip auto or admin fields
      } else {
        emptyRow[f] = null;
      }
    });
    // Insert an empty record to mark progress
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

// POST: insert or update record by code
router.post('/:table', async (req, res) => {
  const { table } = req.params;
  const data = req.body;
  // Remove id and school_id to prevent updating unintended columns
  delete data.id;
  delete data.school_id;

  // Normalize boolean values
  Object.keys(data).forEach(key => {
    if (data[key] === 'Yes') data[key] = 1;
    else if (data[key] === 'No') data[key] = 0;
  });
  // Convert empty strings to null
  Object.keys(data).forEach((key) => {
    if (data[key] === '') {
      data[key] = null;
    }
  });


  const code = data.code;
  if (!code) {
    return res.status(400).json({ success: false, error: 'Invalid or missing code' });
  }

  // Exclude read-only and admin_comments
  const excluded = ['school_id', 'id', 'code', 'created_at', 'updated_at', 'verified_at', 'admin_comments'];
  const [colsResult] = await db.query(`SHOW COLUMNS FROM ??`, [table]);
  const validColumns = colsResult.map(col => col.Field);
  const fields = Object.keys(data).filter(key => validColumns.includes(key) && !excluded.includes(key));
  const values = fields.map(k => data[k]);

  try {
    const [[existing]] = await db.query(
      `SELECT code FROM ?? WHERE code = ? LIMIT 1`,
      [table, code]
    );
    const setClause = fields.map(f => `\`${f}\` = ?`).join(', ');
    if (existing && existing.code) {
      await db.query(
        `UPDATE ?? SET ${setClause} WHERE code = ?`,
        [table, ...values, code]
      );
    } else {
      const cols = ['code', ...fields].map(f => `\`${f}\``).join(', ');
      const placeholders = Array(fields.length + 1).fill('?').join(', ');
      await db.query(
        `INSERT INTO ?? (${cols}) VALUES (${placeholders})`,
        [table, code, ...values]
      );
    }
    res.json({ success: true });
  } catch (err) {
    console.error(`Error saving data for table ${table}:`, err);
    res.status(500).json({ success: false, error: 'Save failed' });
  }
});

module.exports = router;
