const express = require("express");
const router = express.Router();
const { getTickets, getTicketById, createTicket, cancelTicket } = require("../controllers/Ticket");
const { authenticateRequired } = require("../controllers/User");

router.use(authenticateRequired)

router.get("/", getTickets)
router.get("/:id", getTicketById)
router.post("/", createTicket)
router.post("/:id/cancel", cancelTicket);

module.exports = router;