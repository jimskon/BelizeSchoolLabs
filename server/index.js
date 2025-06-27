// server/index.js - core API and React front-end only
const express = require('express');
const cors = require('cors');
const path = require('path');

require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

// Mount school and auth APIs
app.use('/api/school', require('./school/routes'));
app.use('/api/auth', require('./auth/routes'));
app.use('/api/request', require('./request/routes'));

// Dashboard routes for school data status
app.use('/api/school', require('./dashboard/routes'));

// Form configuration
app.use('/api/form-config', require('./utils/formConfigRouter'));

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
  console.log(`Server running at http://${process.env.SERVER_HOST || 'localhost'}:${PORT}`);
});