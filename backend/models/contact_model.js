const mongoose = require('mongoose');

const emergencyContactSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  name: { type: String, required: true },
  phone: { type: String, required: true },
  email: { type: String, required: true },
  relationship: { type: String, required: false },
  priorityLevel: { type: Number, default: 1 } 
});

module.exports = mongoose.model('EmergencyContact', emergencyContactSchema);
