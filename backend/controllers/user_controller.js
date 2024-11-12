const axios = require('axios');
const User = require('../models/user_model');
const dotenv = require("dotenv");
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
        process.env.refreshtoken,
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