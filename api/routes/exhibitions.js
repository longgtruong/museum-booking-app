const express = require("express");
const Exhibition = require("../models/Exhibition");
const router = express.Router();

router.get("/", async (req, rsp) => {
    try {
        const exhibitions = await Exhibition.find();
        rsp.json(posts);
    } catch (err) {
        rsp.json(err)
    }
})

router.get("/:id", async (req, rsp) => {
    try {
        const exhibition = await Exhibition.findById(req.params.id)
        if (exhibition) {
            rsp.json(exhibition)
        } else {
            rsp.status(404).send("Not found.")
        }
    } catch (err) {
        rsp.json(err)
    }
})

router.post("/", async (req, rsp) => {
    const { title, description, author, length, location } = req.body
    const exhibition = new Exhibition({
        title, description, author, length, location
    })
    try {
        const createdExhibition = await exhibition.save()
        rsp.json(createdExhibition)
    } catch (err) {
        rsp.send(err)
    }
})

router.delete("/:id", async (req, rsp) => {
    try {
        const deletedExhibition = await Exhibition.findByIdAndRemove(req.params.id)
        rsp.send(`Successfully deleted exhibition with id ${deletedExhibition.id}`)
    } catch (err) {
        rsp.json(err)
    }
})

module.exports = router;