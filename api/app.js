const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
require("dotenv/config")

const app = express();

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



mongoose.connect(process.env.DB_CONNECTION_URL, { useNewUrlParser: true, useUnifiedTopology: true }, (err) => {
    if (err) console.log(err)
})

app.listen(3000, () => {
    console.log("Listening at port 3000")
})