const Ticket = require("../models/Ticket")
const jwt = require("jsonwebtoken");

module.exports.getTickets =  async (req, rsp) => {
    const user_id = jwt.decode(req.headers.authorization.split(' ')[1]).id
    try {
        const tickets = await Ticket.find({ user_id })
        rsp.status(200).json(tickets)
    } catch (error) {
        rsp.json({
            errors: {
                message: error.message
            }
        })
    }
}

module.exports.getTicketById = async (req, rsp) => {
    const user_id = jwt.decode(req.headers.authorization.split(' ')[1]).id
    const ticket_id = req.params.id
    try {
        const ticket = await Ticket.find({ _id: ticket_id, user_id })
        rsp.status(200).json(ticket)
    } catch (error) {
        rsp.json({
            errors: {
                message: error.message
            }
        })
    }
}

module.exports.createTicket = async (req, rsp) => {
    const { exhibition_id, quantity } = req.body
    const user_id = jwt.decode(req.headers.authorization.split(' ')[1]).id
    try {
        const ticket = await Ticket({
            exhibition_id, user_id, quantity
        }).save()
        rsp.status(200).json(ticket)
    } catch (error) {
        rsp.json({
            errors: {
                message: error.message
            }
        })
    }
}

module.exports.cancelTicket = async (req,rsp) => {
    const { id } = req.params;
    const user_id = jwt.decode(req.headers.authorization.split(' ')[1]).id
    try {
        const ticket = await Ticket.findOne({user_id, id}).update({
            status: "CANCELLED"
        });
        rsp.status(200).json({status: "SUCCESS", message: "Successfully cancelled this ticket."})
    } catch(err) {
        rsp.json({
            errors: {
                message: error.message
            }
        })
    }
}