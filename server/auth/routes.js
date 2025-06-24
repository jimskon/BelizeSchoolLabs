const express = require('express');
const router = express.Router();
const controller = require('./controller');

router.post('/login', controller.login);
router.post('/request', controller.requestAccount);
router.post('/send-password-email', controller.sendPasswordEmail);
router.get('/requests', controller.getPendingRequests);
router.post('/approve-request', controller.approveRequest);
router.post('/reset-password', controller.resetPassword);


module.exports = router;
