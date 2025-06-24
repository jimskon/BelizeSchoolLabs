// server/index.js
const express = require('express');
const cors = require('cors');
const path = require('path');
const dashboardRoutes = require('./dashboard/routes'); // adjust path
const genericTableRouter = require('./utils/genericTableRouter');
const formConfigRouter = require('./utils/formConfigRouter');

require('dotenv').config();


const app = express();
app.use(cors());
app.use(express.json());

// All routes prefixed with /api/
app.use('/api/school', require('./school/routes'));
app.use('/api/auth', require('./auth/routes'));
app.use('/api/request', require('./request/routes'));
app.use('/api/school', dashboardRoutes);
// Serve form-config API before generic table routes to avoid conflicts
app.use('/api/form-config', require('./utils/formConfigRouter'));
app.use('/api', genericTableRouter); // Generic table data routes



// Optional test route
app.get('/api/test-db', async (req, res) => {
  const pool = require('./db');
  try {
    const [rows] = await pool.query('SELECT name FROM moe_school_info LIMIT 5');
    res.json({ success: true, data: rows });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
});


// Serve static files from the client/dist directory
app.use(express.static(path.join(__dirname, '../client/dist')));

// Fallback route for React Router
const indexPath = path.join(__dirname, '../client/dist/index.html');
/*app.get('*', (req, res) => {
  res.sendFile(indexPath, function (err) {
    if (err) {
      console.error('Error sending index.html:', err);
      res.status(500).send('Failed to load frontend.');
    }
  });
});*/

const PORT = process.env.PORT || 5000;
const HOST = '0.0.0.0';
app.listen(PORT, HOST, () => {
  console.log(`Server running at http://${process.env.SERVER_HOST || 'localhost'}:${PORT}`);
});
