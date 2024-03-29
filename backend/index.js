const express = require('express')
const app = express() // เรียกใช้งาน express เก็บลงตัวแปร app
const path = require('path')
const bodyParser = require('body-parser')
var cors = require('cors')

//สั่งใช้งาน Logger Middleware ของเราในระดับ Application-Level
const { logger } = require('./middlewares') //+
app.use(logger) //+ 

app.use(cors())

app.use(express.json()) // for parsing application/json
app.use(express.urlencoded({ extended: true })) // for parsing application/x-www-form-urlencoded

app.use(express.static('static'))//+
// set up ให้แสดง page ที่อยู่ในโฟลเดอร์ views
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, '../frontend/views'))

// set up static path
app.use(express.static(path.join(__dirname, '../frontend/public')))

app.use(bodyParser.urlencoded({ extended: false}));

const homeRouter = require('./route/home')
const userRouter = require('./route/user')
const menuRouter = require('./route/menu')
const commentRouter = require('./route/comment')
const likeRouter = require('./route/like')

app.use(homeRouter.router)
app.use(userRouter.router)
app.use(menuRouter.router)
app.use(commentRouter.router)
app.use(likeRouter.router)

app.listen(3000 , () => {
  console.log('Start server at port 3000.')
})