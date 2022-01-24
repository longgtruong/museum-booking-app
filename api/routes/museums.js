const express = require("express");
const router = express.Router();
const { getMuseums, getMuseumById, createMuseum, removeMuseum } = require("../controllers/Museum");

router.get("/", getMuseums)
router.get("/:id", getMuseumById)
router.post("/", createMuseum)

module.exports = router;