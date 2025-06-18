const express = require('express');
const router = express.Router();
const controller = require('./controller');

router.get('/moe-schools', controller.getMoeSchools);
router.get('/moe-school', controller.getMoeSchoolByName);
router.get('/validate-needed', controller.getValidationPrefillData);
router.post('/validate', controller.validateAndCreateSchool);

module.exports = router;
