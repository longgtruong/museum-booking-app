const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const User = require("../models/User");

module.exports.authenticateRequired = function (req, rsp, next) {
    if (req.headers.authorization && req.headers.authorization.split(' ')[0] === "Bearer") {
        next();
    } else {
        rsp.status(401).send({ errors: { message: "Unauthorized" } })
    }
}

module.exports.login = async function (req, rsp, next) {
    var user = await User.findOne({ username: req.body.username })
    if (!user) {
        rsp.status(404).send({
            errors: {
                message: "User does not exist."
            }
        })
    } else {
        bcrypt.compare(req.body.password, user.password, function (err, isMatch) {
            if (isMatch) {
                const { username, id, first_name, last_name } = user
                const token = jwt.sign({ username, id, first_name, last_name }, process.env.SECRET_JWT, { expiresIn: '1h' })
                rsp.status(200).send({
                    message: "Logged in",
                    token

                })
            } else {
                rsp.status(403).send({
                    message: "Wrong password"
                })
            }
        })
    }
}

module.exports.signup = async (req, rsp) => {
    const { username, password, first_name, last_name } = req.body;
    if (!username || !password) {
        rsp.json({
            errors: {
                message: "Username & password required"
            }
        })
    } else {
        var encryptedPassword = bcrypt.hashSync(password, 10);
        var user = User({
            username, password: encryptedPassword, first_name, last_name
        })
        try {
            const newUser = await user.save()
            rsp.json(newUser)
        } catch (err) {
            rsp.json({
                errors: {
                    message: err.message
                }
            })
        }

    }
}

module.exports.getProfile = (req, rsp) => {
    var token = req.headers.authorization.split(' ')[1]
    var user = jwt.decode(token, process.env.SECRET_JWT)
    if (user) {
        rsp.json(user)
    } else {
        rsp.status(403).send({
            errors: {
                message: "User does not exist."
            }
        })
    }
}