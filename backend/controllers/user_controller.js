const axios = require('axios');
const User = require('../models/user_model');
const dotenv = require("dotenv");


const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

dotenv.config()
exports.login = async (req, res, next) => {
    const { email, password } = req.body;
  
    try {
      
      const user = await User.findOne({ email });
      if (!user) {
        const error = new Error("Invalid email or password");
        error.statusCode = 400;
        return next(error);
      }
  
     
      const isPasswordValid = await bcrypt.compare(password, user.password);
      if (!isPasswordValid) {
        const error = new Error("Invalid email or password");
        error.statusCode = 400;
        return next(error);
      }
     
  


   
      const access_token = jwt.sign({ user_id: user._id, email: user.email }, process.env.JWT_SECRET, {
        expiresIn: "1h"
      });






      const refreshToken = jwt.sign(
        {
            user_id: user._id, email: user.email
        },
        process.env.REFRESH_TOKEN_SECRET,
        { expiresIn: "1d" }
      );
  
      res.cookie('jwt', access_token, {
        httpOnly: true,
        secure: process.env.NODE_ENV == 'development',
        sameSite: 'None',
        maxAge: 24 * 60 * 60 * 1000,
      });
  


    
  
      res.status(200).json({
        message: "Login successful",
        user: {
          id: user._id,
          email: user.email,
          name: user.name
       
        },
        token:access_token,
        role:"admin"
      });
    } catch (error) {
      error.statusCode = 500;
      next(error);
    }
  };




exports.signup = async (req, res, next) => {
    const { username, email, phone, password } = req.body;

    try {
        // Check if user already exists
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            const error = new Error("User already exists");
            error.statusCode = 400;
            return next(error);
        }

        // Hash the password
        const hashedPassword = await bcrypt.hash(password, 10);

        // Create new user
        const user = new User({
            username,
            email,
            phone,
            password: hashedPassword,
        });
        await user.save();

        // Generate JWT tokens
        const access_token = jwt.sign({ user_id: user._id, email: user.email }, process.env.JWT_SECRET, {
            expiresIn: "1h"
        });
        const refreshToken = jwt.sign({ user_id: user._id, email: user.email }, process.env.REFRESH_TOKEN_SECRET, {
            expiresIn: "1d"
        });

        res.cookie('jwt', access_token, {
            httpOnly: true,
            secure: process.env.NODE_ENV === 'development',
            sameSite: 'None',
            maxAge: 24 * 60 * 60 * 1000,
        });

        res.status(201).json({
            message: "Signup successful",
            user: {
                id: user._id,
                username: user.username,
                email: user.email,
                phone: user.phone
            },
            token: access_token,
            refreshToken: refreshToken
        });
    } catch (error) {
        error.statusCode = 500;
        next(error);
    }
};
