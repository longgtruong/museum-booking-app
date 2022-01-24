const Exhibition = require("../models/Exhibition");

module.exports.getExhibitions = async (req, rsp) => {
    try {
        const exhibitions = await Exhibition.find();
        rsp.status(200).json(exhibitions);
    } catch (err) {
        rsp.status(500).json(err)
    }
}

module.exports.getExhibitionById = async (req, rsp) => {
    try {
        const exhibition = await Exhibition.findById(req.params.id)
        if (exhibition) {
            rsp.status(200).json(exhibition)
        } else {
            rsp.status(404).send({
                errors: {
                    message: "Not Found."
                }
            })
        }
    } catch (err) {
        rsp.json({
            errors: {
                message: "Internal server error"
            }
        })
    }
}

module.exports.createExhibiton = async (req, rsp) => {
    const { title, description, author, length, museum_id, price } = req.body
    const exhibition = new Exhibition({
        title, description, author, length, price, museum_id,
    })
    try {
        const createdExhibition = await exhibition.save()
        rsp.status(200).json(createdExhibition)
    } catch (err) {
        rsp.json({
            errors: {
                message: "Internal server error"
            }
        })
    }
}

module.exports.deleteExhibition = async (req, rsp) => {
    try {
        const deletedExhibition = await Exhibition.findByIdAndRemove(req.params.id)
        rsp.status(200).send(`Successfully deleted exhibition with id ${deletedExhibition.id}`)
    } catch (err) {
        rsp.status(500).json({
            errors: {
                message: "Internal server error"
            }
        })
    }
}