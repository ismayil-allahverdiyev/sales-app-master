const express = require("express");
const Poster = require("../models/poster_model.js");
const User = require("../models/user.js");
const mongoose = require("mongoose")
const upload = require("../middlewares/upload")
const uploadGfs = require("../middlewares/gfsUpload")

const posterRouter = express.Router();

const url = "http://192.168.57.26:3000/api/files/"

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

posterRouter.post("/api/addPoster", upload.single("image"), async (req, res)=>{
    const{userId, categorie, price, title} = req.body;
    console.log(userId);
    const objId = mongoose.Types.ObjectId(userId)
    const user = await User.findById(userId);
    console.log("objId " + user);
    if(!user){
        res.status(404).json({
            msg: "The current user does not exist!"
        });
    }else{
        console.log(user);
        let poster = Poster({
            userId,
            categorie, 
            price, 
            title,
            "image": ""
        })
        console.log(req.body.image);
        console.log("file " +  req.file)
        if(req.file){
            poster.image = req.file.path
        }
        poster = await poster.save();
        console.log("Poster is " + poster);
        res.json(poster);
    }
})

posterRouter.post("/api/addVideoPoster", uploadGfs.single("video"), async (req, res)=>{
    const{userId, categorie, price, title} = req.body;
    console.log(userId);
    const objId = mongoose.Types.ObjectId(userId)
    const user = await User.findById(userId);
    console.log(objId);
    if(1==0){
        res.status(404).json({
            msg: "The current user does not exist!"
        });
    }else{
        console.log(user);
        let poster = Poster({
            userId,
            categorie, 
            price, 
            title,
            "image": ""
        })
        console.log(req.body.video);
        console.log(url+req.file.filename)
        if(req.file){
            poster.image = url+req.file.filename
        }
        poster = await poster.save();
        console.log("Poster is " + poster);
        res.json(poster);
    }
})

module.exports = posterRouter;