// server/index.js - core API and React front-end only
const express = require('express');
// const cors = require('cors');
const path = require('path');
const multer = require('multer');


require('dotenv').config();

const app = express();
require('./cors')(app);
app.use(express.json());

// Mount school and auth APIs
app.use('/api/school', require('./school/routes'));
app.use('/api/auth', require('./auth/routes'));
app.use('/api/request', require('./request/routes'));

// Dashboard routes for school data status
app.use('/api/school', require('./dashboard/routes'));

// Form configuration
app.use('/api/form-config', require('./utils/formConfigRouter'));

// Pictures routes
app.use('/api/pictures', require('./pictures/routes'));

// Generic table router for CRUD
app.use('/api', require('./utils/genericTableRouter'));

// Test DB connectivity
app.get('/api/test-db', async (req, res) => {
  const pool = require('./db');
  try {
    const [rows] = await pool.query('SELECT name FROM moe_school_info LIMIT 5');
    res.json({ success: true, data: rows });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
});

// Serve static React build

// Setup file storage for uploads
const upload = multer({ dest: path.join(__dirname, 'uploads') });

// Serve uploads directory
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Picture upload endpoint
app.post('/api/pictures/upload', upload.single('file'), async (req, res) => {
  try {
    const { code, category, description } = req.body;
    const fileUrl = `/uploads/${req.file.filename}`;
    const fileType = req.file.mimetype;

    const [result] = await require('./db').query(
      'INSERT INTO pictures (code, category, description, file_url, file_type) VALUES (?, ?, ?, ?, ?)',
      [code, category, description, fileUrl, fileType]
    );

    res.json({
      success: true,
      picture: { id: result.insertId, code, category, description, file_url: fileUrl, file_type: fileType }
    });
  } catch (err) {
    console.error('Error uploading picture:', err);
    res.status(500).json({ success: false, error: err.message });
  }
});


app.use(express.static(path.join(__dirname, '../client/dist')));
// Fallback to React app for unknown routes
const indexPath = path.join(__dirname, '../client/dist/index.html');
app.get(/.*/, (req, res) => {
  res.sendFile(indexPath, err => {
    if (err) {
      console.error('Error serving index.html:', err);
      res.status(500).send('Failed to load app.');
    }
  });
});

const PORT = process.env.PORT || 5000;
const HOST = '0.0.0.0';
app.listen(PORT, HOST, () => {
  console.log(`Server running at http://${process.env.SERVER_HOST || 'server: '}:${PORT}`);
});