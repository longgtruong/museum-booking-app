const mongoose = require("mongoose");
const Schema = mongoose.Schema;


const ExhibitionSchema = Schema({
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    author: {
        type: String,
        required: true
    },
    length: {
        type: Number,
        required: true
    },
    image_url : { type: String, default: "/museum/default.png"},
    museum_id: { type: Schema.Types.ObjectId, ref: 'Museum', required: true },
    date: {
        type: Date,
        default: Date.now()
    }
})

module.exports = mongoose.model("Exhibition", ExhibitionSchema)