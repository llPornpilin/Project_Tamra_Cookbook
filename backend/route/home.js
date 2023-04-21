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


// get all category
router.get("/", async function (req, res, next) {
  const conn = await pool.getConnection();
  // await conn.beginTransaction(); // เป็นการเริ่มให้ database เริ่มจำ

  try {
    //select category ออกมา ในหน้า home
    const [rows, cols] = await conn.query("SELECT * FROM category_nation;")
    const [rows2, cols2] = await conn.query("SELECT * FROM category_cooking;")
    const [rows3, cols3] = await conn.query("SELECT * FROM category_meat;")

    return res.json([rows, rows2, rows3]);

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

//nations
// router.get("/nations", async function (req, res, next) {
//     const conn = await pool.getConnection();
//     // await conn.beginTransaction(); // เป็นการเริ่มให้ database เริ่มจำ

//     try {
//       //select category ออกมา ในหน้า home
//       const [rows, cols] = await conn.query("SELECT * FROM category_nation;")
//       return res.json(rows);

//     } catch (err) {
//       //ถ้ามี query ใด query หนึ่งมีปัญหา/พัง ให้สถานะ database กลับไป
//       await conn.rollback();
//       next(err);
//     } finally {
//       console.log('finally')
//       conn.release();
//     }
//   }
// )
// //cooking
// router.get("/cooking", async function (req, res, next) {
//   const conn = await pool.getConnection();
//   // await conn.beginTransaction(); // เป็นการเริ่มให้ database เริ่มจำ

//   try {
//     //select category ออกมา ในหน้า home
//     const [rows, cols] = await conn.query("SELECT * FROM category_cooking;")
//     return res.json(rows);

//   } catch (err) {
//     //ถ้ามี query ใด query หนึ่งมีปัญหา/พัง ให้สถานะ database กลับไป
//     await conn.rollback();
//     next(err);
//   } finally {
//     console.log('finally')
//     conn.release();
//   }
// }
// )

// //meat
// router.get("/meats", async function (req, res, next) {
//   const conn = await pool.getConnection();
//   // await conn.beginTransaction(); // เป็นการเริ่มให้ database เริ่มจำ

//   try {
//     //select category ออกมา ในหน้า home
//     const [rows, cols] = await conn.query("SELECT * FROM category_meat;")
//     return res.json(rows);

//   } catch (err) {
//     //ถ้ามี query ใด query หนึ่งมีปัญหา/พัง ให้สถานะ database กลับไป
//     await conn.rollback();
//     next(err);
//   } finally {
//     console.log('finally')
//     conn.release();
//   }
// }
// )
exports.router = router;
