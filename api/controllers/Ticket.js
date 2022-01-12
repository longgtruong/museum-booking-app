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
    const { exhibition_id } = req.body
    const user_id = jwt.decode(req.headers.authorization.split(' ')[1]).id
    try {
        const ticket = await Ticket({
            exhibition_id, user_id
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