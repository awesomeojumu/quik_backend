const express = require ('express')
const cors = require('cors')
const fileUpload = require('express-fileupload');
require("dotenv").config()

const bodyParser= require('body-parser')

const app = express()

//Parse requset of content type application/json
app.use(bodyParser.json());

//Parse content type application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({extended:true}))
app.use(cors())
app.use(fileUpload({
    useTempFiles: true
}))

require("./routes/product.route.js")(app);

const PORT = process.env.PORT || 9000
app.listen(PORT, () => {
    console.log(`App running on port: ${PORT}`)
})