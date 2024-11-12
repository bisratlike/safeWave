const mongoose = require('mongoose');


const alertSchema = new mongoose.Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    alertType: { type: String, enum: ['voice_triggered', 'button_pressed', 'missed_check_in'], required: true },
    location: { type: mongoose.Schema.Types.ObjectId, ref: 'Location' },
    status: { type: String, enum: ['active', 'resolved'], default: 'active' },
    isRealTimeShared: { type: Boolean, default: false },
    timestamp: { type: Date, default: Date.now }
  });
  

module.exports = mongoose.model('Alert', alertSchema);
