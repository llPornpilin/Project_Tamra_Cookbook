const express = require("express");
const router = express.Router()

// const pool = require("../config");

// router.get('/', function(req, res, next) {
//     res.render('HomePage') // ------------------แก้ path /home + แก้จาก Home เป็น HomePage------------------------
// })

// router.get('/addmenu', function(req, res, next) {
//     res.render('Addmenu')
// })

// router.get('/allmenu', function(req, res, next) {
//     res.render('Allmenu')
// })

router.get('/favorite', function(req, res, next) {
    res.render('Favorite')
})

// router.get('/mymenu', function(req, res, next) {
//     res.render('MyMENU')
// })

router.get('/signup', function(req, res, next) {
    res.render('SignUp')
})

router.get('/signin', function(req, res, next) {
    res.render('SignIn')
})

exports.router = router;