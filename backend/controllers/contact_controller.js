const EmergencyContact = require('../models/contact_model');
const User = require('../models/user_model');

exports.addEmergencyContact = async (req, res, next) => {
    const { userId } = req.user;  
    const { name, phone, email, relationship, priorityLevel } = req.body;

    try {
        // Check if emergency contact already exists for this user
        const existingContact = await EmergencyContact.findOne({ userId, phone });
        if (existingContact) {
            const error = new Error("Emergency contact with this phone number already exists for this user");
            error.statusCode = 400;
            return next(error);
        }

        // Create new emergency contact
        const contact = new EmergencyContact({
            userId,
            name,
            phone,
            email,
            relationship,
            priorityLevel
        });
        await contact.save();

        res.status(201).json({
            message: "Emergency contact added successfully",
            contact: {
                id: contact._id,
                name: contact.name,
                phone: contact.phone,
                email: contact.email,
                relationship: contact.relationship,
                priorityLevel: contact.priorityLevel
            }
        });
    } catch (error) {
        error.statusCode = 500;
        next(error);
    }
};

exports.getEmergencyContacts = async (req, res, next) => {
    const { userId } = req.user;  
    try{
        const contacts = await EmergencyContact.find({ userId });
        res.status(200).json({
            message: "Emergency contacts retrieved successfully",
            contacts: contacts.map(contact => ({
                id: contact._id,
                name: contact.name,
                phone: contact.phone,
                email: contact.email,
                relationship: contact.relationship,
                priorityLevel: contact.priorityLevel
            }))
        });  
    }
      
     catch (error) {
        error.statusCode = 500;
        next(error);
    }
};
