const db = require('../db');

// Utility to check if a table is complete based on requiredfields definition
async function getTableStatus(tablename, schoolId) {
  try {
    // 1. Get required fields from `requiredfields` table
    const [[requiredRow]] = await db.query(
      'SELECT required FROM requiredfields WHERE tablename = ?',
      [tablename]
    );

    // If no requiredfields entry or empty required: default to Not Started
    if (!requiredRow || !requiredRow.required) {
      console.warn(`No required fields defined for table '${tablename}', defaulting to 'Not Started'`);
      return 'Not Started';
    }

    const requiredFields = requiredRow.required.split(',').map(f => f.trim());

    // 2. Query the first matching row for the school from the target table
    const [rows] = await db.query(
      `SELECT ${requiredFields.join(', ')} FROM ?? WHERE school_id = ? LIMIT 1`,
      [tablename, schoolId]
    );

    if (rows.length === 0) return 'Not Started';

    const row = rows[0];
    const nullFields = requiredFields.filter(field => row[field] === null || row[field] === '');

    if (nullFields.length === 0) {
      return 'Complete';
    } else {
      return 'In Progress';
    }
  } catch (err) {
    console.error(`Error checking status for table '${tablename}':`, err);
    return 'Error';
  }
}

module.exports = { getTableStatus };