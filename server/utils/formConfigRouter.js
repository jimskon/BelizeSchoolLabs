// server/utils/formConfigRouter.js

// Import dependencies
const express = require('express');
const db = require('../db');

// Create a new Express router instance
const router = express.Router();

/**
 * GET /:tableName
 * 
 * Fetch dynamic form configuration (fields + metadata) for a given table name.
 * - Looks up field definitions from `form_fields`
 * - Looks up metadata (title, subtitle, instructions, footer) from `titles`
 */
router.get('/:tableName', async (req, res) => {
  const { tableName } = req.params;

  try {
    // Query form field configurations for the specified table
    const [fields] = await db.query(
      `SELECT field_name, prompt, type, valuelist, field_width, required, visible
       FROM form_fields
       WHERE table_name = ?`,
      [tableName]
    );

    // Query metadata (page structure info) for the same table
    const [metaRows] = await db.query(
      `SELECT title, subtitle, instructions, footer
       FROM titles
       WHERE table_name = ?`,
      [tableName]
    );

    // Use default empty strings if no metadata is found
    const meta = metaRows[0] || {
      title: '',
      subtitle: '',
      instructions: '',
      footer: ''
    };

    // Return field configuration and metadata in a structured JSON response
    res.json({
      success: true,
      fields,
      title: meta.title,
      subtitle: meta.subtitle,
      instructions: meta.instructions,
      footer: meta.footer
    });

  } catch (err) {
    // Log error to the server console and return a 500 response
    console.error('Error fetching form config:', err);
    res.status(500).json({
      success: false,
      error: 'Failed to load form config'
    });
  }
});

// Export the router to be mounted in the main app
module.exports = router;
