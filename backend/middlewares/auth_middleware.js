const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
dotenv.config();
const User = require("../models/user_model")
exports.authenticate =async(req, res, next) => {
    try {
        // Get the token from the header
        const token = req.header('Authorization')?.split(' ')[1];
        if (!token) {
            const error = new Error("Access denied. No token provided.");
            error.statusCode = 401;
            return next(error);
        }

        // Verify the token
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const admin = await User.findById(decoded.user_id);

        if (!admin) {
          return res.status(401).json({ message: 'Unauthorized: user not found' });
        }
        req.user = { userId: decoded.user_id };  // Attach user ID to req.user

        next();
    } catch (error) {
        error.statusCode = 403;
        error.message = "Invalid token";
        next(error);
    }
};

