const express = require('express');
const { sendAlertWithLocation, updateLocation } = require('../controllers/location_controller');
const router = express.Router();

router.post('/send-alert', sendAlertWithLocation);
router.post('/update-location', updateLocation);

module.exports = router;
