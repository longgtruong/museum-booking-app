const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const MuseumSchema = Schema({
    name: { type: String, required: true },
    city: { type: String, required: true },
    image_url : { type: String, default: "/museum/default.png"}, 
    latitude: { type: Number, required: true },
    longitude: { type: Number, required: true }
})

module.exports = mongoose.model("Museum", MuseumSchema)