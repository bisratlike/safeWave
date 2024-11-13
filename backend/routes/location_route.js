const express = require('express');
const { sendAlertWithLocation, updateLocation } = require('../controllers/location_controller');
const {authenticate} = require('../middlewares/auth_middleware');
const router = express.Router();

router.post('/send-alert',authenticate, sendAlertWithLocation);
router.post('/update-location',authenticate, updateLocation);

module.exports = router;
