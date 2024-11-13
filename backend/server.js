const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const errorHandler = require('./middlewares/error_handler');
const locationRoutes = require('./routes/location_route');
const userRoutes = require("./routes/user_route")
const contactRoutes = require("./routes/contact_route")
dotenv.config();
const app = express();
app.use(express.json());

app.use(express.urlencoded({ extended: true }));
const url = process.env.url
const port = process.env.port

const apiRouter = express.Router()
app.use("/api/v1", apiRouter);
apiRouter.use('/location', locationRoutes);
apiRouter.use('/user', userRoutes);
apiRouter.use('/contact', contactRoutes);
app.use(errorHandler);


mongoose.connect(url,{}).then(()=>{
console.log('connected to database')
}).catch(err=>{
    console.log("error while connecting to database",err)
});





const start =(port)=>{
    try{
        app.listen(port,()=>{
            console.log(`server is running on port ${port}`)
        });
    }
    catch(err){
        console.log("error while starting server",err)
        process.exit() 
    }
}
start(port)