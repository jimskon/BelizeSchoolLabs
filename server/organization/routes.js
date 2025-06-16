const express = require('express');
const router = express.Router();
const orgController = require('./controller');

router.post('/', orgController.createOrganization);

module.exports = router;
