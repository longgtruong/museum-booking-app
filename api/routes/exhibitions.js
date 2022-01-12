const express = require("express");
const router = express.Router();
const { getExhibitions, getExhibitionById, createExhibiton, deleteExhibition } = require("../controllers/Exhibition");

router.get("/", getExhibitions)
router.get("/:id", getExhibitionById)
router.post("/", createExhibiton)
router.delete("/:id", deleteExhibition)

module.exports = router;