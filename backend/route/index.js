const express = require("express");
const router = express.Router()

// const pool = require("../config");

router.get('/home', function(req, res, next) {
    res.render('Home')
})

router.get('/addmenu', function(req, res, next) {
    res.render('Addmenu')
})

router.get('/allmenu', function(req, res, next) {
    res.render('Allmenu')
})

router.get('/favorite', function(req, res, next) {
    res.render('Favorite')
})

router.get('/mymenu', function(req, res, next) {
    res.render('MyMENU')
})

router.get('/signup', function(req, res, next) {
    res.render('SignUp')
})

router.get('/signin', function(req, res, next) {
    res.render('SignIn')
})

exports.router = router;