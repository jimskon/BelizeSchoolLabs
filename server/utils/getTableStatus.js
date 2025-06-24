const db = require('../db');

async function getTableStatus(table, schoolId) {
  // Fetch required and visible fields from form_fields
  const [requiredRows] = await db.query(
    `SELECT field_name FROM form_fields WHERE table_name = ? AND required = TRUE`,
    [table]
  );
  const [visibleRows] = await db.query(
    `SELECT field_name FROM form_fields WHERE table_name = ? AND visible = TRUE`,
    [table]
  );
  let requiredFields = requiredRows.map(r => r.field_name);
  let visibleFields = visibleRows.map(r => r.field_name);

  // Ensure field lists match actual table columns
  const [cols] = await db.query(`SHOW COLUMNS FROM ??`, [table]);
  const actualCols = cols.map(c => c.Field);
  requiredFields = requiredFields.filter(f => actualCols.includes(f));
  visibleFields = visibleFields.filter(f => actualCols.includes(f));

  // If no visible fields configured, nothing to do
  if (visibleFields.length === 0) {
    return 'Not started';
  }

  // Fetch current data for those fields
  const [dataRows] = await db.query(
    `SELECT ?? FROM ?? WHERE school_id = ? LIMIT 1`,
    [visibleFields, table, schoolId]
  );
  if (dataRows.length === 0) {
    return 'Not started';
  }

  const row = dataRows[0];
  // Count filled required fields
  const filledRequired = requiredFields.filter(f => {
    const val = row[f];
    return val !== null && val !== undefined && val !== '';
  });
  // Count filled visible fields
  const filledVisible = visibleFields.filter(f => {
    const val = row[f];
    return val !== null && val !== undefined && val !== '';
  });

  // Determine status
  if (filledRequired.length === 0) {
    return 'Not started';
  }
  if (filledRequired.length === requiredFields.length && filledVisible.length < visibleFields.length) {
    return 'Required fields complete';
  }
  if (filledVisible.length === visibleFields.length) {
    return 'Input complete';
  }
  return 'In progress';
}

module.exports = { getTableStatus };