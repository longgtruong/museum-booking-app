const Museum = require("../models/Museum");

module.exports.getMuseums = async (req, rsp) => {
    try {
        const museums = await Museum.find();
        rsp.json(museums);
    } catch (err) {
        rsp.status(500).json({
            errors: {
                message: "Internal server error"
            }
        })
    }
}

module.exports.getMuseumById = async (req, rsp) => {
    try {
        const museum = await Museum.findById(req.params.id)
        if (museum) {
            rsp.json(museum)
        } else {
            rsp.status(404).send({
                errors: {
                    message: "Not Found."
                }
            })
        }
    } catch (err) {
        rsp.status(500).json({
            errors: {
                message: "Internal server error"
            }
        })
    }
}

module.exports.createMuseum = async (req, rsp) => {
    const { name, city, latitude, longitude } = req.body
    const museum = new Museum({
        name, city, latitude, longitude
    })
    try {
        const newMuseum = await museum.save()
        rsp.status(200).json(newMuseum)
    } catch (err) {
        rsp.status(500).json({
            errors: {
                message: "Internal server error"
            }
        })
    }
}
