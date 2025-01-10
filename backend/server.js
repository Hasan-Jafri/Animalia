const express = require('express');
const dotenv = require('dotenv');
const userRoutes = require('./routes/auth_routes')
const animalRoutes = require('./routes/animal_routes')
const cors = require("cors")
dotenv.config();
require("./database/connection")
const path = require('path');

// Initializing env variables


const app = express();

// If port declared in .env then that one or 5000 by default.
const PORT = process.env.PORT || 5000;

// Middle ware
app.use(cors());
app.use(express.json()); // For parsing application/json
app.use('/uploads', express.static(path.join(__dirname,'routes', 'uploads')));

// Basic route
app.get('/',(req,res)=>{
  res.send("Project Animalia Backend is running")
})



// Routers
app.use('/api/users', userRoutes)

app.use('/api/animals', animalRoutes)

app.listen(PORT, ()=>{
  console.log(`Sever is running on port ${PORT}`)
})
