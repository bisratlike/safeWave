const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
dotenv.config();
const app = express();
app.use(express.json());

app.use(express.urlencoded({ extended: true }));
const url = process.env.url
const port = process.env.port
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