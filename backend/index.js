const express = require('express')
const app = express() // เรียกใช้งาน express เก็บลงตัวแปร app
const path = require('path')

// set up ให้แสดง page ที่อยู่ในโฟลเดอร์ views
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, '../frontend/views'))

// set up static path
app.use(express.static(path.join(__dirname, '../frontend/public')))

const indexRouter = require('./route/index')
const userRouter = require('./route/user')
// app.use('/', indexRouter)

app.use(indexRouter.router)
app.use(userRouter.router)

app.listen(8080, () => {
  console.log('Start server at port 8080.')
})