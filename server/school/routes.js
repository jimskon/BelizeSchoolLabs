// source/school/router.js

// ==============================
// Import Dependencies
// ==============================

const express = require('express');
const router = express.Router();

// Import controller functions for handling each route
const controller = require('./controller');

// ==============================
// School API Routes
// ==============================
// This router handles API endpoints related to school validation,
// fetching Ministry of Education (MOE) data, and creating school entries.

// ----------------------------------------
// GET /moe-schools
// ----------------------------------------
// Returns a deduplicated list of all schools from the `school_info` table.
// Useful for selecting a school from a dropdown list.
router.get('/moe-schools', controller.getMoeSchools);

// ----------------------------------------
// GET /moe-school?name=School+Name
// ----------------------------------------
// Returns a single school's full record from `school_info` based on the provided name.
// Used to fetch all stored data for an individual school.
router.get('/moe-school', controller.getMoeSchoolByName);

// ----------------------------------------
// GET /validate-needed?name=School+Name
// ----------------------------------------
// Pulls school data from `moe_school_info` (original source data)
// to prefill a validation form. Returns 404 if school not found.
router.get('/validate-needed', controller.getValidationPrefillData);

// ----------------------------------------
// POST /validate
// ----------------------------------------
// Accepts submitted school data, validates it, and then inserts it into:
//   - `school`: for account and authentication
//   - `school_info`: for full profile metadata
// Wrapped in a DB transaction to ensure atomicity.
// Returns success with the newly created school ID.
router.post('/validate', controller.validateAndCreateSchool);

// ==============================
// Export the router to be mounted in the main app
// ==============================
module.exports = router;
