const express = require('express');
const router = express.Router();
const contactController = require('../controllers/contact_controller');
const {authenticate} = require('../middlewares/auth_middleware');

router.post('/add',authenticate, contactController.addEmergencyContact);
router.get('/all', authenticate, contactController.getEmergencyContacts);

module.exports = router;
