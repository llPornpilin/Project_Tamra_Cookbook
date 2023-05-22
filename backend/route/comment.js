const express = require("express");
const path = require("path");
const pool = require("../config");
const multer = require("multer");

const router = express.Router();

const { isLoggedIn } = require("../middlewares"); //+

router.get('/comment/:menu_id', async (req, res) => {
    const menu_id = req.params.menu_id
    console.log("GET : /comment/:menu_id in comment.js --> ", menu_id)

    const [comment] = await pool.query("SELECT *, DATE_FORMAT(comment_date, '%d-%m-%y  (%H:%i)') as comment_date FROM comments " +
        "join users on (comments.comment_by_id = users.user_id) " +
        "WHERE menu_id =?", [menu_id])
    console.log(comment);
    return res.json(comment)
})

router.post("/addComment", isLoggedIn, async function (req, res, next) {

    const detail = req.body.detail;
    const menu_id = req.body.menu_id;
    const user_id = req.user.user_id;

    console.log("addComment", detail, user_id, menu_id);

    // Begin transaction
    const conn = await pool.getConnection();
    await conn.beginTransaction();

    try {
        const [comment] = await conn.query("INSERT INTO comments (detail, comment_by_id, menu_id) VALUES (?,?,?)", [detail, user_id, menu_id]);

        console.log("addComment in comment.js :", comment)
        await conn.commit();

    } catch (err) {
        await conn.rollback();
        return res.status(400).json(err);
    } finally {
        conn.release();
    }

    const [comment_all] = await pool.query("SELECT *, DATE_FORMAT(comment_date, '%d-%m-%y  (%H:%i)') as comment_date FROM comments " +
        "join users on (comments.comment_by_id = users.user_id) " +
        "WHERE menu_id =?", [menu_id])
    console.log(comment_all);
    return res.json(comment_all)
}
);

router.delete('/comment/:comment_id/:menu_id',isLoggedIn, async (req, res) => {
    const comment_id = req.params.comment_id
    const menu_id = req.params.menu_id
    console.log("DELETE : /comment/:menu_id in comment.js --> ", comment_id)

    const [comment] = await pool.query("DELETE FROM comments WHERE comment_id =?", [comment_id])
    console.log(comment);

    const [comment_all] = await pool.query("SELECT *, DATE_FORMAT(comment_date, '%d-%m-%y  (%H:%i)') as comment_date FROM comments " +
        "join users on (comments.comment_by_id = users.user_id) " +
        "WHERE menu_id =?", [menu_id])
    console.log(comment_all);
    return res.json(comment_all)

})


exports.router = router;
