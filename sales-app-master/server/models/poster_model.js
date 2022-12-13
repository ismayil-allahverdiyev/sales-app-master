const mongoose = require("mongoose");

const posterSchema = mongoose.Schema({
    categorie:{
        type: String,
        required: false,
        trim: true,
        default: "all"
    },
    userId:{
        type: Number,
        required: true,
        trim: true
    },
    price:{
        type: Number,
        required: true,
    },
    title:{
        type: String,
        default: "This title is automatically generated"
    },
});

const Poster = mongoose.model("Poster", posterSchema);
module.exports = Poster;
