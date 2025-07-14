
// Main Express server entry point for API and React front-end
const express = require('express');
// const cors = require('cors'); // Uncomment if using CORS directly
const path = require('path');
const multer = require('multer'); // For handling file uploads


require('dotenv').config();


const app = express();
// Apply CORS middleware
require('./cors')(app);
// Parse JSON request bodies
app.use(express.json());


// Mount all API routes
app.use('/api/school', require('./school/routes'));
app.use('/api/auth', require('./auth/routes'));
app.use('/api/request', require('./request/routes'));
app.use('/api/school', require('./dashboard/routes'));
app.use('/api/form-config', require('./utils/formConfigRouter'));
app.use('/api/pictures', require('./pictures/routes'));
app.use('/api', require('./utils/genericTableRouter'));

// Endpoint to test DB connectivity
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

// Serve uploaded files statically
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Picture upload endpoint
// Handles file upload and inserts picture metadata into the database
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