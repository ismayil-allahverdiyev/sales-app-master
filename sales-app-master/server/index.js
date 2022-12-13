
const PORT = 3000;
const DB = "mongodb+srv://isi:1124816%40isi2003@clusteraisha.fgl4fve.mongodb.net/test";

const express = require("express");
const mongoose = require("mongoose");
const User = require("./models/user.js");
const authRouter = require("./routes/auth.js");
const posterRouter = require("./routes/poster.js");
const app = express();

mongoose.connect(DB).then(()=>{
    console.log("Connection successful");
}).catch((e)=>{
    console.log("1");
    console.log(e);
})

app.use(express.json());
app.use(authRouter);
app.use(posterRouter);

app.get("/hi", (req, res) => {
    console.log("SSS");
    res.send("aaa")
})

app.listen(PORT, "192.168.130.26", function (){
    console.log(`Connected to ${PORT}`);
});