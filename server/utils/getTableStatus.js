// server/utils/getTableStatus.js
const db = require('../db');

/**
 * getTableStatus
 * 
 * Computes a progress status ("Not started", "In progress", or "Complete")
 * for a specific record in a given table based on visible and required fields.
 * 
 * @param {string} table - Name of the table (e.g., "demographics", "curriculum")
 * @param {string} code - Unique school code used to identify the row
 * @returns {Promise<string>} Status of the form section for the given table and school
 */
async function getTableStatus(table, code) {
  // ===========================
  // STEP 1: Load field metadata
  // ===========================

  // Get all required fields for the table from form_fields config
  const [requiredRows] = await db.query(
    `SELECT field_name FROM form_fields WHERE table_name = ? AND required = TRUE`,
    [table]
  );

  // Get all visible fields for the table (we only care about visible fields)
  const [visibleRows] = await db.query(
    `SELECT field_name FROM form_fields WHERE table_name = ? AND visible = TRUE`,
    [table]
  );

  // Extract field names from query results
  let requiredFields = requiredRows.map(r => r.field_name);
  let visibleFields = visibleRows.map(r => r.field_name);

  // ==============================================
  // STEP 2: Sanity check against actual table columns
  // ==============================================

  // Fetch the actual column names from the table schema
  const [cols] = await db.query(`SHOW COLUMNS FROM ??`, [table]);
  const actualCols = cols.map(c => c.Field);

  // Remove any required/visible fields that don't exist in the table
  requiredFields = requiredFields.filter(f => actualCols.includes(f));
  visibleFields = visibleFields.filter(f => actualCols.includes(f));

  // ========================================================
  // STEP 3: Handle case where no visible fields are defined
  // ========================================================

  // If no visible fields are configured, consider the form "Not started"
  if (visibleFields.length === 0) {
    return 'Not started';
  }

  // =================================
  // STEP 4: Fetch record for the school
  // =================================

  // Pull the row for the given code, selecting only visible fields
  const [dataRows] = await db.query(
    `SELECT ?? FROM ?? WHERE code = ? LIMIT 1`,
    [visibleFields, table, code]
  );

  // If the record does not exist, treat it as "Not started"
  if (dataRows.length === 0) {
    return 'Not started';
  }

  const row = dataRows[0];

  // ============================================
  // STEP 5: Count how many fields are filled out
  // ============================================

  // A field is considered "filled" if it's not null, undefined, or empty string
  const filledRequired = requiredFields.filter(f => {
    const val = row[f];
    return val !== null && val !== undefined && val !== '';
  });

  const filledVisible = visibleFields.filter(f => {
    const val = row[f];
    return val !== null && val !== undefined && val !== '';
  });

  // ===========================
  // STEP 6: Return final status
  // ===========================

  // If no required fields are filled, but some visible ones are → "In progress"
  if (filledRequired.length === 0) {
    return filledVisible.length > 0 ? 'In progress' : 'Not started';
  }

  // If all required fields are filled → "Complete"
  if (filledRequired.length === requiredFields.length) {
    return 'Complete';
  }

  // Otherwise → "In progress"
  return 'In progress';
}

// Export the function for use in other parts of the app
module.exports = { getTableStatus };
