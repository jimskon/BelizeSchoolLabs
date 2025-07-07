const express = require('express');
const multer = require('multer');
const path = require('path');
const pool = require('../db');
const router = express.Router();

const storage = multer.diskStorage({
  destination: 'uploads/',
  filename: (req, file, cb) => {
    const uniqueName = `${Date.now()}-${file.originalname}`;
    cb(null, uniqueName);
  }
});

const upload = multer({ storage });

// Upload a picture associated with a school code
router.post('/upload-picture', upload.single('image'), async (req, res) => {
  const { code, description } = req.body;
  if (!code) return res.status(400).json({ success: false, error: 'Missing school code' });
  const image_url = `/uploads/${req.file.filename}`;

  try {
    await pool.query(
      'INSERT INTO pictures (code, file_url, description) VALUES (?, ?, ?)',
      [code, image_url, description]
    );
    res.json({ success: true, image_url });
  } catch (error) {
    console.error('Upload error:', error);
    res.status(500).json({ success: false, error: 'Database error' });
  }
});

// Get all pictures for a given school code
router.get('/pictures/:code', async (req, res) => {
  const { code } = req.params;
  try {
    const [rows] = await pool.query(
      'SELECT * FROM pictures WHERE code = ?',
      [code]
    );
    res.json({ success: true, pictures: rows });
  } catch (err) {
    console.error('Fetch pictures error:', err);
    res.status(500).json({ success: false, error: err.message });
  }
});

module.exports = router;
