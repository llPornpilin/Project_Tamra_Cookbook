const express = require("express");
const path = require("path");
const pool = require("../config");
const multer = require("multer");

const router = express.Router();

//ตั้งค่า multer
//destination เก็บรูป
// var storage = multer.diskStorage({
//   destination: function (req, file, callback) {
//     callback(null, "./static/uploads"); // path to save file
//   },
//   filename: function (req, file, callback) {
//     // set file name
//     callback(
//       null,
//       file.fieldname + "-" + Date.now() + path.extname(file.originalname)
//     );
//   },
// });
//กำหนดตัวแปรสำหรับเรียกใช้งาน
// const upload = multer({ storage: storage });

//Insert code here
router.post("/mymenu",async function (req, res, next) {
    // const file = req.file;
    // if (!file) {
    //   const error = new Error("Please upload a file");
    //   error.httpStatusCode = 400;
    //   return next(error);
    // }

    const menuName = req.body.menuName;

    const conn = await  pool.getConnection()
    await conn.beginTransaction(); // เป็นการเริ่มให้ database เริ่มจำ

    try {
      //insert เข้าตาราง menu
      let menu = await conn.query(
        "INSERT INTO menu(user_id, category_id, menu_name, menu_ingredient, menu_method, menu_duration, menu_image) VALUES(?, ?, ?, ?, ?, ?, ?);",
        [1, 1, 'menuName', 'ingredient', 'method', 23, 'image']
      )

      console.log(menu)
      // ถ้าทุก transaction เสร็จแล้ว ให้ทำการ ส่ง/เสร็จเลย
      await conn.commit()
      // res.send("success!");
      res.redirect('/mymenu') //กลับไปที่หน้า myMenu
    } catch (err) {
      //ถ้ามี query ใด query หนึ่งมีปัญหา/พัง ให้สถานะ database กลับไป
      await conn.rollback();
      next(err);
    } finally {
      console.log('finally')
      conn.release();
    }
  }
)
exports.router = router;
