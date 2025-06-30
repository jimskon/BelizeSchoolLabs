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

router.post('/upload-picture', upload.single('image'), async (req, res) => {
  const { school_id, description } = req.body;
  const image_url = `/uploads/${req.file.filename}`;

  try {
    await pool.query(
      'INSERT INTO pictures (school_id, image_url, description) VALUES (?, ?, ?)',
      [school_id, image_url, description]
    );
    res.json({ success: true, image_url });
  } catch (error) {
    console.error('Upload error:', error);
    res.status(500).json({ success: false, error: 'Database error' });
  }
});

router.get('/pictures/:school_id', async (req, res) => {
  const { school_id } = req.params;
  try {
    const [rows] = await pool.query('SELECT * FROM pictures WHERE school_id = ?', [school_id]);
    res.json({ success: true, pictures: rows });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
});

module.exports = router;
