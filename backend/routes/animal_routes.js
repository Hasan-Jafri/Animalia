const express = require('express')
const Animal = require('../models/animal');
const router = express.Router()
const GoogleGenerativeAI = require('@google/generative-ai')
const authenticate = require('../middleware/auth_middleware')
const axios = require('axios'); // For API requests
const User = require('../models/user');
const dotenv = require('dotenv')
dotenv.config();

const GEMINI_API_KEY = process.env.GEMINI_KEY;
const googleAI = new GoogleGenerativeAI.GoogleGenerativeAI(GEMINI_API_KEY);
const geminiconfig = {
        temperature: 1,
        topP: 0.95,
        topK: 64,
        maxOutputTokens: 4096,
        response_mime_type: "application/json",
    }
const geminiModel = googleAI.getGenerativeModel({
    model:"gemini-1.5-flash",
    geminiconfig,
})

const generate = async () => {
    const filePath = "https://www.allaboutbirds.org/news/wp-content/uploads/2024/05/549985061-Rufous_Hummingbird-Nathan_Wall-1280x734.jpg";
    const promptConfig = [
        {text: "Identify the animal in this image, just give me a one word answer"},
        {
            inlineData:{
                mimeType: "image/jpg",
                data: filePath
            }
        }
    ];
    try {
      const prompt = "Tell me about google.";
      const result = await geminiModel.generateContent({contents:[{role:"User", parts: promptConfig}]});
      const response = result.response;
      console.log(response.text());
    } catch (error) {
      console.log("response error", error);
    }
  };
router.post('/identify', authenticate, async(req,res)=>{
    generate();
    // const GEMINI_KEY = process.env.GEMINI_KEY;
    // const googleAI = GoogleGenerativeAI(GEMINI_KEY);
    // const geminiconfig = {
    //     temperature: 1,
    //     topP: 0.95,
    //     topK: 64,
    //     maxOutputTokens: 4096,
    //     response_mime_type: "application/json",
    // }
    // const geminiModel = googleAI.getGenerativeModel({
    //     model:"gemini-1.5-flash",
    //     geminiconfig
    // })


    // try{

    //     // const prompt = "Tell me about yourself.";
    //     // const result = await geminiModel.generateContent(prompt);
    //     // const response = result.response;
    //     // console.log(response.text());
    //     // const {imageUrl} = req.body; // Picture by the user.

    //     // // Gemini API connection for information.
    //     // const geminiResponse = await axios.post(`https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=${GEMINI_KEY}`,body= {prompt:"FOR ALL THE IMAGES I PROVIDEI WANT YOU TO IDENTIFY WHAT ANIMAL IS THIS AND GIVE YOUR RESPONSE IN A FORMAT name: xxxx, habitat: xxx, found: xxxx, diet:xxx"},{timeout: 60000});
    //     // const geminiResponse2 = await axios.post(body = {imageUrl: imageUrl},{timeout: 60000});
    //     // console.log(geminiResponse)
    //     // console.log(geminiResponse2)
    //     // const {name, habitat, found, diet} = geminiResponse.data;
        
    //     // // Animal Object creation
    //     // const animal = new Animal({name,habitat,found,diet,imageUrl});
    //     // await animal.save();

    //     // const user = await User.findById(req.user.id);
    //     // user.history.push(animal._id);
    //     // await user.save();

    //     // res.status(201).json({message: "Animal Identiied and saved to history", animal});

    // }catch(error){
    //     res.status(400).json({message: "Error identifying animal", error});
    // }
});

router.get('/history', authenticate,async (req,res)=>{
    try{
        const user = await User.findById(req.user.id).populate('history');
        res.status(200).json({history: user.history})
    }catch(error){
        res.status(500).json({message: "Error retrieving data", error});
    }
})

router.get('/:name',authenticate, async (req,res)=>{
    try{
        const animalName = req.params.name;

        // Search animal in db
        const animal = await Animal.findOne({name: animalName});
        if(!animal) return res.status(404).json({message:"Animal not found"});

        res.status(200).json(animal);
    } catch(error){
        res.status(500).json({message:'Error retrieving animal data', error})
    }
})

module.exports = router;

