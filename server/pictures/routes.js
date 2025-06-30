const express = require('express');
const fs = require('fs');
const path = require('path');
const db = require('../db');

const router = express.Router();

// List all pictures
router.get('/list', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM pictures');
    res.json({ success: true, pictures: rows });
  } catch (err) {
    console.error('Error fetching pictures:', err);
    res.status(500).json({ success: false, error: err.message });
  }
});

// Update picture metadata (category, description)
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { category, description } = req.body;
  try {
    await db.query(
      'UPDATE pictures SET category = ?, description = ? WHERE id = ?',
      [category, description, id]
    );
    res.json({ success: true });
  } catch (err) {
    console.error('Error updating picture:', err);
    res.status(500).json({ success: false, error: err.message });
  }
});

// Delete picture and its file
router.delete('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [[pic]] = await db.query('SELECT file_url FROM pictures WHERE id = ?', [id]);
    if (pic) {
      const filePath = path.join(__dirname, '..', pic.file_url);
      fs.unlink(filePath, err => {
        if (err) console.warn('Failed to delete file:', err);
      });
    }
    await db.query('DELETE FROM pictures WHERE id = ?', [id]);
    res.json({ success: true });
  } catch (err) {
    console.error('Error deleting picture:', err);
    res.status(500).json({ success: false, error: err.message });
  }
});

// Get pictures by category
router.get('/category/:category', async (req, res) => {
  const { category } = req.params;
  try {
    const [rows] = await db.query(
      'SELECT * FROM pictures WHERE category = ? ORDER BY uploaded_at DESC',
      [category]
    );
    res.json({ success: true, pictures: rows });
  } catch (err) {
    console.error('Error fetching pictures by category:', err);
    res.status(500).json({ success: false, error: err.message });
  }
});


module.exports = router;
