const express = require("express");
const { authenticateRequired, login, signup, getProfile } = require("../controllers/User");
const router = express.Router();
require("dotenv/config")

router.get("/me", authenticateRequired, getProfile)
router.post("/signup", signup)
router.post("/login", login)


module.exports = router;
// module.exports = authenticateRequired;