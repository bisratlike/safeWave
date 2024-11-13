const axios = require('axios');
const User = require('../models/user_model');
const EmergencyContact = require('../models/contact_model');
const nodemailer = require("nodemailer");
const dotenv = require("dotenv");
dotenv.config()

const sendAlertWithLocation = async (req, res) => {
    const { lat, lng, alertType, alertStatus } = req.body;
    const { userId } = req.user;

    try {
        // Fetch the user to access the username
        const user = await User.findById(userId);
        if (!user) return res.status(404).json({ message: 'User not found' });

        // Google Maps URL for location
        const googleMapsUrl = `https://www.google.com/maps/search/?api=1&query=${lat},${lng}`;

        // Fetch emergency contacts associated with the user
        const contacts = await EmergencyContact.find({ userId });
        if (!contacts.length) {
            console.log("No emergency contacts found for the user.");
            return res.status(404).json({ message: 'No emergency contacts found' });
        }

        // Create an array of promises for sending emails
        const emailPromises = contacts.map(async (contact) => {
            console.log(`Preparing to send email to: ${contact.email}`);

            const transporter = nodemailer.createTransport({
                service: 'gmail',
                auth: {
                    user: process.env.node_email, // Ensure this is set in environment variables
                    pass: process.env.pass, // Ensure this is set in environment variables
                },
            });

            const mailOptions = {
                from: process.env.node_email,
                to: contact.email,
                subject: `Emergency Alert from ${user.username}`,
                html: `
                    <p><strong>Emergency Alert:</strong> ${user.username} has triggered an emergency alert.</p>
                    <p><strong>Location:</strong> <a href="${googleMapsUrl}" target="_blank">View on Google Maps</a></p>
                    <p><strong>Timestamp:</strong> ${new Date().toLocaleString()}</p>
                    <p><strong>Status:</strong> ${alertStatus}</p>
                    <table style="border-collapse: collapse; width: 100%; margin-bottom: 20px;">
                        <tr style="background-color: #f2f2f2;">
                            <th style="border: 1px solid #ddd; padding: 8px; text-align: left;">Requirement</th>
                            <th style="border: 1px solid #ddd; padding: 8px; text-align: left;">Location</th>
                            <th style="border: 1px solid #ddd; padding: 8px; text-align: left;">Alert Date</th>
                        </tr>
                        <tr>
                            <td style="border: 1px solid #ddd; padding: 8px;">Immediate Action Required</td>
                            <td style="border: 1px solid #ddd; padding: 8px;">${googleMapsUrl}</td>
                            <td style="border: 1px solid #ddd; padding: 8px;">${new Date().toLocaleString()}</td>
                        </tr>
                    </table>
                    <p>Please check the location immediately and take necessary actions.</p>
                `,
            };

            try {
                await transporter.sendMail(mailOptions);
                console.log(`Email successfully sent to ${contact.email}`);
            } catch (error) {
                console.error(`Error sending email to ${contact.email}:`, error);
            }
        });

        // Wait for all email sending tasks to complete
        await Promise.all(emailPromises);
        console.log("All emails sent.");

        res.status(200).json({ message: 'Alert sent successfully' });
    } catch (error) {
        console.error("Error in sendAlertWithLocation:", error);
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
