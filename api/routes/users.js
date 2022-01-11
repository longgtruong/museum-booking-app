const express = require("express");
const router = express.Router();


router.get("/login", (req, rsp) => {
    rsp.send("logged in");
})

router.get("/", (req, rsp) => {
    rsp.send("Users")
})

module.exports = router;