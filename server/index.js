const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

// All routes prefixed with /api/
app.use('/api/school', require('./school/routes'));
app.use('/api/organization', require('./organization/routes'));
app.use('/api/user', require('./user/routes'));

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

const PORT = process.env.PORT || 5000;
const HOST = '0.0.0.0';
app.listen(PORT, HOST, () => {
  console.log(`Server running at http://${process.env.SERVER_HOST || 'localhost'}:${PORT}`);
});
