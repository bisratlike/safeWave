const axios = require('axios');
const User = require('../models/user_model');
const EmergencyContact = require('../models/contact_model');

const sendAlertWithLocation = async (req, res) => {
    const { userId, lat, lng } = req.body;

    try {
        // Fetch user and emergency contacts
        const user = await User.findById(userId).populate('emergencyContacts');
        if (!user) return res.status(404).json({ message: 'User not found' });

        // Google Maps URL for location
        const googleMapsUrl = `https://www.google.com/maps/search/?api=1&query=${lat},${lng}`;

        // Send alert to each emergency contact
        user.emergencyContacts.forEach(async (contact) => {
            // Here, implement the actual messaging, e.g., SMS, email (not detailed here)
            console.log(`Sending alert to ${contact.phoneNumber}: ${googleMapsUrl}`);
        });

        res.status(200).json({ message: 'Alert sent successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Failed to send alert' });
    }
};

const updateLocation = async (req, res) => {
    const { userId, lat, lng } = req.body;

    try {
        const user = await User.findByIdAndUpdate(userId, { currentLocation: { lat, lng } }, { new: true });
        if (!user) return res.status(404).json({ message: 'User not found' });

        res.status(200).json({ message: 'Location updated', location: user.currentLocation });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Failed to update location' });
    }
};

module.exports = { sendAlertWithLocation, updateLocation };
