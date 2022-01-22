const mongoose = require("mongoose");
const Schema = mongoose.Schema

const UserFavoriteSchema = Schema({
    user_id: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    exhibition_id: { type: Schema.Types.ObjectId, ref: 'Exhibition', required: true },
})

module.exports = mongoose.model("UserFavorite", UserFavoriteSchema)