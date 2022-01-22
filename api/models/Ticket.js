const mongoose = require("mongoose");
const Schema = mongoose.Schema

const TicketSchema = Schema({
    user_id: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    exhibition_id: { type: Schema.Types.ObjectId, ref: 'Exhibition', required: true },
    quantity: {type: Number, default: 1},
    status: { type: String, enum: ["ACTIVE", "COMPLETED", "CANCELLED"], default: "ACTIVE" },
    created_at: { type: Date, default: Date.now },
})

module.exports = mongoose.model("Ticket", TicketSchema)