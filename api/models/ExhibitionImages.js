const mongoose = require("mongoose");
const Schema = mongoose.Schema

const ExhibitionImagesSchema = Schema({
    exhibition_id: { type: Schema.Types.ObjectId, ref: 'Exhibition', required: true },
    image_url: { type: String, required: true}
})

module.exports = mongoose.model("ExhibitionImages", ExhibitionImagesSchema)