const express = require('express');
const router = express.Router();
const controller = require('./controller');

router.post('/login', controller.login);
router.post('/request', controller.requestAccount);
router.post('/send-login-pin', controller.sendLoginPin);
router.post('/correct-contact', controller.submitCorrection);


module.exports = router;
