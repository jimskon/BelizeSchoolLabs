const express = require('express');
const router = express.Router();
const schoolController = require('./controller');

router.get('/', schoolController.getSchools);

module.exports = router;
