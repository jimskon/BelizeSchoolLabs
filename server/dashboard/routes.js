const express = require('express');
const router = express.Router();
const { getTableStatus } = require('../utils/getTableStatus');
const db = require('../db');

const TABLES_TO_CHECK = ['school_info','demographics', 'curriculum', 'computerRoom', 'resources'];

router.get('/status/:id', async (req, res) => {
  const schoolId = req.params.id;

  if (!schoolId || isNaN(Number(schoolId))) {
    return res.status(400).json({ success: false, error: 'Invalid or missing school ID' });
  }

  try {
    const statusList = [];

    for (const tablename of TABLES_TO_CHECK) {
      const status = await getTableStatus(tablename, schoolId);

      const [updatedRows] = await db.query(
        `SELECT updated_at FROM ?? WHERE school_id = ? ORDER BY updated_at DESC LIMIT 1`,
        [tablename, schoolId]
      );

      const lastUpdated = updatedRows.length > 0 ? updatedRows[0].updated_at : null;

      statusList.push({
        table: tablename,
        displayName: tablename.replace(/([A-Z])/g, ' $1').replace(/^./, str => str.toUpperCase()),
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
