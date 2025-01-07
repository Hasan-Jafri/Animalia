const express = require("express")
const User = require('../models/user')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt')

const router = express.Router();

router.post('/register', async (req,res)=>{
    try{
        const {username,email,password} = req.body;
        const user = new User({username,email,password});
        await user.save();
        res.status(201).json({message: "User registered successfully!"});
    }catch(error){
        res.status(400).json({message: "Error registering user", error});
    }
});

router.post('/login',async (req,res)=>{

    try{
        console.log("Body",req.body);
        const {email,password} = req.body;
        console.log("Here we are",email,password);
        const user = await User.findOne({email});
        console.log("USERS----",user);
        
        if(!user) return res.status(404).json({message:'User not found'});
        const isMatch = await user.comparePassword(password);
        console.log("IS MATCH",isMatch);
        if(!isMatch) return res.status(400).json({message: 'Invalid Credentials'});
        const token  = jwt.sign({id: user._id}, process.env.JWT_SECRET,{expiresIn: '30d'});
        res.status(200).json({token,userId: user._id,email: user.email,username: user.username});
    } catch(error){
        res.status(500).json({message: 'Login error',error});
    }
})

router.post('/logout', (req,res)=>{
    res.status(200).json({message: "Logged out successfully"});
})

module.exports = router;