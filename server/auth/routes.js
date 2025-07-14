// server/auth/router.js

// ================================
// Import dependencies
// ================================
const express = require('express');
const router = express.Router();

// Import controller functions to handle route logic
const controller = require('./controller');

// ================================
// Authentication & Account Routes
// ================================
// This router handles school login, account requests, login PINs, and contact corrections.

// ----------------------------------------
// POST /login
// ----------------------------------------
// Authenticates a school using a one-time PIN.
// PIN must match and be unexpired in the `school` table.
router.post('/login', controller.login);

// ----------------------------------------
// POST /request
// ----------------------------------------
// Allows a school to request an account manually by submitting their details.
// The backend may store this in a `account_requests` table for admin approval.
router.post('/request', controller.requestAccount);

// ----------------------------------------
// POST /send-login-pin
// ----------------------------------------
// Generates a one-time 6-digit PIN, stores it temporarily in the DB,
// and emails it to the school to enable login.
router.post('/send-login-pin', controller.sendLoginPin);

// ----------------------------------------
// POST /correct-contact
// ----------------------------------------
// Allows a school to submit updated contact information.
// Typically used to correct email, phone, or contact person name.
router.post('/correct-contact', controller.submitCorrection);

// ================================
// Export router to be used in the main app
// ================================
module.exports = router;
