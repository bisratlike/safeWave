const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  username: { type: String, required: true, unique: true },
  email: { type: String, required: true, unique: true },
  phone: { type: String, required: true },
  password: { type: String, required: true },
  
  preferences: {
    checkInFrequency: { type: Number, default: 5 },  
    alertMethods: { type: [String], enum: ['sms', 'email', 'push_notification'], default: ['sms'] },
    voiceRecognitionSensitivity: { type: Number, default: 0.5 }
  },

  created_at: { type: Date, default: Date.now }
});

module.exports = mongoose.model('User', userSchema);
