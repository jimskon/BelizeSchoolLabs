// server/request/routes.js
const express = require('express');
const router = express.Router();
const controller = require('./controller');

// Submit a new account request
router.post('/', controller.submitRequest);

// Get all submitted requests (for admin viewing)
router.get('/', controller.getRequests);

module.exports = router;
