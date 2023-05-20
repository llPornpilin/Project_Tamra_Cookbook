const express = require("express");
const path = require("path");
const pool = require("../config");
const multer = require("multer");

const router = express.Router();

const { isLoggedIn } = require("../middlewares"); //+
const { count } = require("console");

router.post("/addLike/:menu_id", isLoggedIn, async function (req, res, next) {

    const menu_id = req.params.menu_id;
    const user_id = req.user.user_id;
    // let statusLike = 0;

    console.log("addLike", user_id, menu_id);

    // Begin transaction
    const conn = await pool.getConnection();
    await conn.beginTransaction();

    const [checkLike] = await conn.query("SELECT * FROM likes WHERE menu_id = ? AND user_id = ?", [menu_id, user_id])

    try {
        if(checkLike.length == 0){
            const [like] = await conn.query("INSERT INTO `likes` (user_id, menu_id) VALUES (?,?)", [user_id, menu_id]);
            console.log("addLike in like.js :", like,user_id, menu_id)
            // statusLike = 1;
        }else{
            const [deleteLike] = await conn.query("DELETE FROM `likes` WHERE user_id =? AND menu_id =?", [user_id, menu_id])
            console.log("delete like", user_id, menu_id)
            // statusLike = 0;
        }
        await conn.commit();

        return res.json(checkLike)

    } catch (err) {
        await conn.rollback();
        return res.status(400).json(err);
    } finally {
        conn.release();
    }
}
);

exports.router = router;