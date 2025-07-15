// server/status/router.js

// Import Dependencies

const express = require('express');
const router = express.Router();
const { getTableStatus } = require('../utils/getTableStatus'); // Utility to calculate table completion status
const db = require('../db');



// List of Tables to Check for Progress
// These are the core form sections that schools are expected to complete.
// Each table represents a logical part of a school’s profile.
const TABLES_TO_CHECK = [
  'school_info',
  'demographics',
  'curriculum',
  'computerRoom',
  'resources',
  'future_computerRoom',
];


// GET /status/:code
// Returns a progress status report for each relevant table tied to a given school `code`.
// Also includes the most recent `updated_at` timestamp for each section.
// This endpoint powers a dashboard or school progress tracker.
router.get('/status/:code', async (req, res) => {
  const code = req.params.code;

  // Validate that a school code is provided
  if (!code) {
    return res.status(400).json({
      success: false,
      error: 'Invalid or missing code'
    });
  }

  try {
    const statusList = [];

    // Loop through each tracked table and calculate its status
    for (const tableName of TABLES_TO_CHECK) {
      // Step 1: Get the form completion status using custom logic
      const status = await getTableStatus(tableName, code);

      // Step 2: Get the last time this table was updated for the given school
      const [updatedRows] = await db.query(
        `SELECT updated_at FROM ?? WHERE code = ? ORDER BY updated_at DESC LIMIT 1`,
        [tableName, code]
      );

      // Determine last updated timestamp if available
      const lastUpdated = updatedRows.length > 0 ? updatedRows[0].updated_at : null;

      // Step 3: Push the result to the status list
      statusList.push({
        table: tableName, // raw table name
        displayName: tableName                     // human-readable name (e.g., "Computer Room")
          .replace(/([A-Z])/g, ' $1')              // insert space before capital letters
          .replace(/^./, str => str.toUpperCase()), // capitalize the first letter
        status,         // "Not started", "In progress", or "Complete"
        lastUpdated     // timestamp or null
      });
    }

    // Return a structured list of table statuses
    res.json({ success: true, tables: statusList });

  } catch (err) {
    console.error('Error fetching table statuses:', err);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch table statuses'
    });
  }
});

// =====================================
// Export the Router to Be Used in Main App
// =====================================
module.exports = router;
