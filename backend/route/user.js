const express = require("express");
const router = express.Router()
const Joi = require('joi');

const pool = require("../config");

// schema = Joi.object({
//     // email: Joi.string().email().required().max(100)
//     // username :  Joi.string().min(5).max(50).required(),
//     // password: Joi.string().pattern(new RegExp('^[a-zA-Z0-9]{3,30}$'))
//     username: Joi.string().alphanum().min(3).max(30).required()
// })

const schema = Joi.object({
    username: Joi.string().alphanum().min(3).max(30).required(),
    })

router.post('/signup',async function(req, res, next) {

    // try {
    //     console.log("เข้า1")
    //     await schema.validateAsync(req.body , { abortEarly : false })
    //     console.log("เข้า2")
    //     // abortEarly(object) : true [validate 1 field/col ถ้าเจอปัญหาจะ res กลับไป], false  [validate field/col ทั้งหมด ถ้าเจอปัญหาจะ res กลับไป]
    // }
    // catch (err) { 
    //     // ถ้า validate แล้วไม่ผ่าน
    //     console.log(err)
    //     return res.status(400).json(error)
    // }


    try {
        const value = await schema.validateAsync(req.body, { abortEarly: false })
        console.log("try",value)
        
    }
    catch (err) { 
        console.log("error", err)
        return res.status(400).json(err)
    }
    res.send('okไหม')
})

exports.router = router;