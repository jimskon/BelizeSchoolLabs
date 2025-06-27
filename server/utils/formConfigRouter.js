// server/utils/formConfigRouter.js
const express = require('express');
const db = require('../db');

const router = express.Router();

router.get('/:tableName', async (req, res) => {
  const { tableName } = req.params;

  try {
    const [fields] = await db.query(
      'SELECT field_name, prompt, type, valuelist, field_width, required, visible FROM form_fields WHERE table_name = ?',
      [tableName]
    );

    const [metaRows] = await db.query(
      'SELECT title, subtitle, instructions, footer FROM titles WHERE table_name = ?',
      [tableName]
    );
    const meta = metaRows[0] || { title: '', subtitle: '', instructions: '', footer: '' };
    res.json({ success: true, fields, title: meta.title, subtitle: meta.subtitle, instructions: meta.instructions, footer: meta.footer });
  } catch (err) {
    console.error('Error fetching form config:', err);
    res.status(500).json({ success: false, error: 'Failed to load form config' });
  }
});

module.exports = router;