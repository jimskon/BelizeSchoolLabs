// server/routes/genericFormRouter.js

const express = require('express');
const router = express.Router();
const db = require('../db');

// ==========================
// Allowed Tables
// ==========================
// Only the following tables can be accessed via this router.
// This prevents SQL injection and limits scope of data access.
const ALLOWED_TABLES = [
  'school_info',
  'demographics',
  'curriculum',
  'computerRoom',
  'resources',
  'pictures',
];

// ==========================
// Middleware: Table Validator
// ==========================
// Ensures the route parameter :table is one of the allowed tables.
// If not, returns a 404 error and halts execution.
router.use('/:table', (req, res, next) => {
  const { table } = req.params;
  if (!ALLOWED_TABLES.includes(table)) {
    return res.status(404).json({ error: 'Table not found' });
  }
  next();
});

// ==========================
// GET /:table/list
// ==========================
// Fetches all rows in the specified table.
// This is used primarily for admin views or overviews.
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

// ==========================
// GET /:table?code=XYZ
// ==========================
// Retrieves a specific record by `code`. If it doesn't exist:
//   - For tables other than `pictures`, creates and returns a new empty row.
//   - For `pictures`, returns an empty object without inserting anything.
// This allows for smooth "first-time" form entry flows.
router.get('/:table', async (req, res) => {
  const { table } = req.params;
  const code = req.query.code;

  if (!code) {
    return res.status(400).json({ error: 'Invalid or missing code' });
  }

  try {
    // Attempt to find the existing record
    const [rows] = await db.query(
      `SELECT * FROM ?? WHERE code = ? LIMIT 1`,
      [table, code]
    );

    if (rows.length > 0) {
      const result = rows[0];
      // Hide internal admin comments from users (for UI purposes)
      if (table === 'school_info') delete result.admin_comments;
      return res.json(result);
    }

    // If no record exists:
    if (table === 'pictures') {
      // Special case: do not auto-insert pictures
      return res.json({});
    }

    // Build an empty row structure for other tables
    const [cols] = await db.query(`SHOW COLUMNS FROM ??`, [table]);
    const emptyRow = {};

    cols.forEach(col => {
      const f = col.Field;
      if (f === 'code') {
        emptyRow[f] = code;
      } else if ([
        'code', 'created_at', 'updated_at', 'verified_at', 'admin_comments'
      ].includes(f)) {
        // Skip internal/system-managed fields
      } else {
        emptyRow[f] = null;
      }
    });

    // Insert the empty row into the database to mark "form started"
    const insertFields = Object.keys(emptyRow);
    const placeholders = insertFields.map(() => '?').join(', ');
    await db.query(
      `INSERT INTO ?? (${insertFields.map(f => `\`${f}\``).join(', ')}) VALUES (${placeholders})`,
      [table, ...insertFields.map(f => emptyRow[f])]
    );

    // Return the empty row structure
    return res.json(emptyRow);

  } catch (err) {
    console.error(`Error fetching data for table ${table}:`, err);
    res.status(500).json({ error: 'Failed to fetch data' });
  }
});

// ==========================
// POST /:table
// ==========================
// Inserts a new record or updates an existing one in the table.
// - Removes unsafe or system-managed fields from input
// - Normalizes boolean values and empty strings
router.post('/:table', async (req, res) => {
  const { table } = req.params;
  const data = req.body;

  // Prevent accidentally overwriting internal identifiers
  delete data.id;
  delete data.school_id;

  // Normalize "Yes"/"No" strings to boolean 1/0 values
  Object.keys(data).forEach(key => {
    if (data[key] === 'Yes') data[key] = 1;
    else if (data[key] === 'No') data[key] = 0;
  });

  // Convert empty strings to null to maintain data consistency
  Object.keys(data).forEach(key => {
    if (data[key] === '') data[key] = null;
  });

  const code = data.code;
  if (!code) {
    return res.status(400).json({ success: false, error: 'Invalid or missing code' });
  }

  // Define fields to exclude from update/insert operations
  const excluded = [
    'school_id', 'id', 'code', 'created_at',
    'updated_at', 'verified_at', 'admin_comments'
  ];

  // Retrieve valid column names from the table schema
  const [colsResult] = await db.query(`SHOW COLUMNS FROM ??`, [table]);
  const validColumns = colsResult.map(col => col.Field);

  // Determine which fields in the data are valid and editable
  const fields = Object.keys(data).filter(
    key => validColumns.includes(key) && !excluded.includes(key)
  );
  const values = fields.map(k => data[k]);

  try {
    // Check if the record already exists
    const [[existing]] = await db.query(
      `SELECT code FROM ?? WHERE code = ? LIMIT 1`,
      [table, code]
    );

    if (existing && existing.code) {
      // If it exists, perform an update
      const setClause = fields.map(f => `\`${f}\` = ?`).join(', ');
      await db.query(
        `UPDATE ?? SET ${setClause} WHERE code = ?`,
        [table, ...values, code]
      );
    } else {
      // If not, insert a new record
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

// ==========================
// Export the router for use in the main server
// ==========================
module.exports = router;
