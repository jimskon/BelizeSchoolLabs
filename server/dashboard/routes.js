const express = require('express');
const router = express.Router();
const { getTableStatus } = require('../utils/getTableStatus');
const db = require('../db');

const TABLES_TO_CHECK = ['school_info', 'demographics', 'curriculum', 'computerRoom', 'resources'];

// GET status for a school by code
router.get('/status/:code', async (req, res) => {
  const code = req.params.code;
  if (!code) {
    return res.status(400).json({ success: false, error: 'Invalid or missing code' });
  }

  try {
    const statusList = [];

    for (const tableName of TABLES_TO_CHECK) {
      // Determine progress status
      const status = await getTableStatus(tableName, code);
      // Get latest updated_at timestamp
      const [updatedRows] = await db.query(
        `SELECT updated_at FROM ?? WHERE code = ? ORDER BY updated_at DESC LIMIT 1`,
        [tableName, code]
      );
      const lastUpdated = updatedRows.length > 0 ? updatedRows[0].updated_at : null;

      statusList.push({
        table: tableName,
        displayName: tableName.replace(/([A-Z])/g, ' $1').replace(/^./, str => str.toUpperCase()),
        status,
        lastUpdated
      });
    }

    res.json({ success: true, tables: statusList });
  } catch (err) {
    console.error('Error fetching table statuses:', err);
    res.status(500).json({ success: false, error: 'Failed to fetch table statuses' });
  }
});

module.exports = router;
