const express = require("express");
const Poster = require("../models/poster_model.js");
const User = require("../models/user.js");

const posterRouter = express.Router();

posterRouter.get("/api/getAllPostersByTitle", async (req, res)=>{
    const{categorie} = req.body;
    console.log(categorie);
    const poster = await Poster.find({categorie});
    console.log(poster);
    if(!poster){
        res.status(404).json({
            msg: "List is empty!"
        });
    }
    res.json(
        poster
    )
})

posterRouter.get("/api/getAllPosters", async (req, res)=>{
    const poster = await Poster.find({});
    console.log(poster);
    if(!poster){
        res.status(404).json({
            msg: "List is empty!"
        });
    }
    res.json(
        poster
    )
})

posterRouter.post("/api/addPoster", async (req, res)=>{
    const{userId, categorie, price, title} = req.body;
    const user = await User.findById(userId);
    if(!user){
        res.status(404).json({
            msg: "The current user does not exist!"
        });
    }
    console.log(user);
    let poster = Poster({
        userId,
        categorie, 
        price, 
        title
    })
    poster = await poster.save();
    res.json(poster);
})

module.exports = posterRouter;