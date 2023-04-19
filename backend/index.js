const express = require('express')
const app = express() // เรียกใช้งาน express เก็บลงตัวแปร app
const path = require('path')
const bodyParser = require('body-parser')
var cors = require('cors')

app.use(cors())

// set up ให้แสดง page ที่อยู่ในโฟลเดอร์ views
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, '../frontend/views'))

// set up static path
app.use(express.static(path.join(__dirname, '../frontend/public')))

app.use(bodyParser.urlencoded({ extended: false}));

const homeRouter = require('./route/home')
const indexRouter = require('./route/index')
const userRouter = require('./route/user')
const menuRouter = require('./route/menu')
// app.use('/', indexRouter)

app.use(homeRouter.router)
app.use(indexRouter.router)
app.use(userRouter.router)
app.use(menuRouter.router)

app.listen(3000, () => {
  console.log('Start server at port 3000.')
})