const jwt = require('jsonwebtoken');

const authMiddleware = (req,res, next) =>{

    const authHeader = req.header("Authorization");
    if(!authHeader) return res.status(401).json({message: "No token Provided"});

    const token = authHeader.split(' ')[1];

    if(!token){
        res.status(401).json({message:"No token provided"});
    }

    try{
        
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded.id;
        next();
    }catch(error){
        console.error("Token verification error: ",error.message);
        if(error.name === "TokenExpiredError"){
            return res.status(401).json({message:"Token expired"});
        }
       
        return res.status(401).json({message: 'Invalid token'});
    }
};


module.exports = authMiddleware;