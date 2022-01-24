const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
require("dotenv/config")

const app = express();
const db_url = process.env.NODE_ENV === "production" ? process.env.LIVE_DB_URL : process.env.LOCAL_DB_URL

const userRoute = require("./routes/users");
const museumRoute = require("./routes/museums");
const exhibitionRoute = require("./routes/exhibitions");
const ticketRoute = require("./routes/tickets");

app.use(express.json());
app.use(cors());

app.use("/users", userRoute)
app.use("/museums", museumRoute)
app.use("/exhibitions", exhibitionRoute)
app.use("/tickets", ticketRoute)

mongoose.connect(db_url, { useNewUrlParser: true, useUnifiedTopology: true }, (err) => {
    if (err) console.log(err)
})

app.listen(8080, () => {
    console.log(db_url)
    console.log("Listening at port 8080")
})