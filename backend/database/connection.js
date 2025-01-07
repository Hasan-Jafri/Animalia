const mongoose = require('mongoose')
const DB = process.env.MONGO_URI

if (!DB){
    console.error("MongoDB URL is not defined. Set URL environment variable");
}

mongoose.connect(DB)
.then(()=>{
    console.log("Connections Successful...");
})
.catch((error)=>{
    console.error("Error connecting to MongoDB",error);
    process.exit(1);
})