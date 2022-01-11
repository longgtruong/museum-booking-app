const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
require("dotenv/config")

const app = express();

const userRoute = require("./routes/users");
const exhibitionRoute = require("./routes/exhibitions");

app.use(express.json());
app.use(cors());

app.use("/users", userRoute)
app.use("/exhibitions", exhibitionRoute)

mongoose.connect(process.env.DB_CONNECTION_URL, { useNewUrlParser: true, useUnifiedTopology: true }, (data) => {
    console.log(data)
})

app.listen(3000, () => {
    console.log("Listening at port 3000")
})