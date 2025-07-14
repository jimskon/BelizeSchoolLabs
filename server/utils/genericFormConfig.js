// server/utils/genericFormConfig.js

// Import the database connection
const db = require('../db');

/**
 * Controller: getFormConfig
 * 
 * Fetches the generic form configuration for a specified table name.
 * - Pulls field definitions from the `form_config` table
 * - Returns an ordered list of fields for dynamic form generation
 */
exports.getFormConfig = async (req, res) => {
  // Extract the target table name from the request parameters
  const tableName = req.params.tableName;

  try {
    // Query the form configuration for the given table name, ordered by ID
    const [rows] = await db.query(
      'SELECT * FROM form_config WHERE name = ? ORDER BY id',
      [tableName]
    );

    // If no configuration found, return 404 Not Found
    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'No config found for this table'
      });
    }

    // Return the form configuration fields
    res.json({
      success: true,
      fields: rows
    });

  } catch (err) {
    // Log and handle database or server errors
    console.error('Form config error:', err);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch form configuration'
    });
  }
};
