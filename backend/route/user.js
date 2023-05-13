const express = require("express")
const pool = require("../config")
const Joi = require('joi')
const bcrypt = require('bcrypt');
// -------add---------------------------------------------
// /utils/token เป็นโมดูลที่ถูกสร้างขึ้นเพื่อจัดการเกี่ยวกับการสร้างและการใช้งาน Token ex. ตรวจสอบสิทธิ์ของผู้ใช้งาน
const { generateToken } = require("../utils/token");

// นำ IsLoggedIn Middleware มาใช้งาน
const { isLoggedIn } = require('../middlewares')

router = express.Router();

// -----add---------------------------------------------------
const loginSchema = Joi.object({
    username: Joi.string().required(),
    password: Joi.string().required()
})

router.post('/user/login', async (req, res, next) => {
    try {
        await loginSchema.validateAsync(req.body, { abortEarly: false })
        // console.log('loginnn')
    } catch (err) {
        return res.status(400).send(err)
    }
    const username = req.body.username
    const password = req.body.password

    const conn = await pool.getConnection()
    await conn.beginTransaction()

    try {
        // Check if username is correct
        const [users] = await conn.query(
            'SELECT * FROM users WHERE username=?', 
            [username]
        )
        const user = users[0]
        if (!user) {
            throw new Error('Incorrect username or password')
        }

        // Check if password is correct
        if (!(await bcrypt.compare(password, user.password))) { // password decodeed
            throw new Error('Incorrect username or password')
        }

        // Check if token already existed เช็คว่ามี token แล้วยัง (เคย log in รึยัง)
        const [tokens] = await conn.query(
            'SELECT * FROM tokens WHERE user_id=?',
            [user.id]
        )
        let token = tokens[0]?.token
        if (!token) {
            // Generate and save token into database
            token = generateToken()
            await conn.query(
                'INSERT INTO tokens(user_id, token) VALUES (?, ?)', 
                [user.id, token]
            )
        }

        conn.commit()
        res.status(200).json({'token': token})
    } catch (error) {
        conn.rollback()
        res.status(400).json(error.toString())
    } finally {
        conn.release()
    }
})

// นำ IsLoggedIn Middleware มาใช้งาน
router.get('/user/me', isLoggedIn, async (req, res, next) => {
        // req.user ถูก save ข้อมูล user จาก database ใน middleware function "isLoggedIn"
        res.json(req.user)
    })
// ----------------------------------------------------------------------------------------


const passwordValidator = (value, helpers) => {
    if (value.length < 8) {
        throw new Joi.ValidationError('Password must contain at least 8 characters')
    }
    if (!(value.match(/[a-z]/) && value.match(/[A-Z]/) && value.match(/[0-9]/))) {
        throw new Joi.ValidationError('Password must be harder')
    }
    return value
}

const usernameValidator = async (value, helpers) => {
    const [rows, _] = await pool.query("SELECT username FROM users WHERE username = ?", [value])
    if (rows.length > 0) {
        const message = 'This username is already taken'
        throw new Joi.ValidationError(message, { message })
    }
    return value
}

const signupSchema = Joi.object({
    email: Joi.string().required().email(),
    password: Joi.string().required().custom(passwordValidator),
    confirm_password: Joi.string().required().valid(Joi.ref('password')),
    username: Joi.string().required().min(5).max(20).external(usernameValidator),
})

router.post('/user/signup', async (req, res, next) => {
    try {
        await signupSchema.validateAsync(req.body, { abortEarly: false })
    } catch (err) {
        return res.status(400).send(err)
    }

    const conn = await pool.getConnection()
    await conn.beginTransaction()

    const username = req.body.username
    const email = req.body.email
    const password = await bcrypt.hash(req.body.password, 5)

    try {
        await conn.query(
            'INSERT INTO users(email, username, password) VALUES (?, ?, ?)',
            [email, username, password]
        )
        conn.commit()
        res.status(201).send()
    } catch (err) {
        conn.rollback()
        res.status(400).json(err.toString());
    } finally {
        conn.release()
    }
})

exports.router = router