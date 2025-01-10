const express = require('express')
const Animal = require('../models/animal');
const router = express.Router()
const GoogleGenerativeAI = require('@google/generative-ai')
const authenticate = require('../middleware/auth_middleware')
const axios = require('axios'); // For API requests
const User = require('../models/user');
const dotenv = require('dotenv')
const multer = require('multer');
const sharp = require('sharp');
const path = require('path');
dotenv.config();
const PORT = process.env.PORT || 5000;
const GEMINI_API_KEY = process.env.GEMINI_KEY;
const googleAI = new GoogleGenerativeAI.GoogleGenerativeAI(GEMINI_API_KEY);

const storage = multer.memoryStorage();
const upload = multer({ storage });
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
router.post('/identify', authenticate,upload.single('image'), async(req,res)=>{
    try{
        const {buffer} = req.file;

        processedImage = await sharp(buffer).toFormat('png').toBuffer();  
        const imageName = `${Date.now()}-animal.png`;
        const imagePath = path.join(__dirname,'uploads',imageName);
        require('fs').writeFileSync(imagePath,processedImage);

        const base64Image = processedImage.toString('base64');
        const promptConfig = [
            { text: "Analyze this image and provide the following details about the animal: name, habitat, Where it's commonly found as 'found', and diet.I need you to answer me as only 'name,habitat,found,diet' so that it easy to crack" },
            {
                inlineData: {
                    mimeType: "image/png", // Update if using a different image format
                    data: base64Image,
                },
            },
        ];

        const result = await geminiModel.generateContent({
            contents: [{ role: "User", parts: promptConfig }],
        });
        console.log("RESPONSE====>",result.response.text());
        
            // Call the `text()` function to extract the text content
    const responseText = await result.response.text();

    // Parse the responseText if it’s in JSON format
    const match = responseText.replace(/\\n|\\t|\\r/g, '').trim().split(',')
    // const responseData = JSON.parse(jsonMatch);
        

    // const { name, habitat, found, diet } = responseData;
    const animalData = {
        name:match[0],
        habitat:match[1],
        found:match[2],
        diet:match[3],
        imageUrl: `http://localhost:${PORT}/routes/uploads/${imageName}`,
    };

        const animal = new Animal(animalData);
        await animal.save();

        res.status(200).json(animal);



    }catch (error) {
        console.error('Error:', error);
        res.status(500).json({ error: 'Failed to process the image' });
    }
    
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

