const express = require("express");
const path = require("path");
const pool = require("../config");
const multer = require("multer");

const router = express.Router();

// ตั้งค่า multer
// destination เก็บรูป
var storage = multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, "./static/uploads"); // path to save file *******************
  },
  filename: function (req, file, callback) {
    // set file name
    callback(
      null,
      file.fieldname + "-" + Date.now() + path.extname(file.originalname)
    );
  },
});
// กำหนดตัวแปรสำหรับเรียกใช้งาน
const upload = multer({ storage: storage });


// เพิ่มเมนูอาหาร > redirect ไปแสดงหน้า mymenu
router.post("/mymenu", multer().none(), async function (req, res, next) {
    // const file = req.file;
    // if (!file) {
    //   const error = new Error("Please upload a file");
    //   error.httpStatusCode = 400;
    //   return next(error);
    // }

    const menuName = req.body.menuName;
    const menuIngrediant = req.body.menuIngrediant;
    const menuMethod = req.body.menuMethod;
    const image = req.body.image;
    const menuCategory = req.body.menuCategory;
    const menuTypeCook = req.body.menuTypeCook;
    const menuTypeMeat = req.body.menuTypeMeat;
    const menuDay = req.body.menuDay;
    const menuHour = req.body.menuHour;
    const menuMinute = req.body.menuMinute;

    const conn = await  pool.getConnection();
    // await conn.beginTransaction(); // เป็นการเริ่มให้ database เริ่มจำ

    try {
      //insert เข้าตาราง menu
      const menu = await conn.query(
        "INSERT INTO menu(user_id, category_id, menu_name, menu_ingredient, menu_method, menu_duration, menu_image) VALUES(?, ?, ?, ?, ?, ?, ?);",
        [1, 1, menuName, menuIngrediant, menuMethod, ]
      )
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


// รับ path /allmenu มา แล้วแสดงหน้า allmenu
router.get("/allmenu", async function (req, res, next) {
  try {
    const [rows, fields] = await pool.query("SELECT * FROM menus");
    console.log(rows)
    return res.json(rows);
  } catch (err) {
    return next(err);
  }
});

router.get("/allmenu/:id", async function (req, res, next) {
  const conn = await pool.getConnection();
  await conn.beginTransaction(); // เป็นการเริ่มให้ database เริ่มจำ

  try {
    console.log(req.params.id);

    //insert เข้าตาราง image
    const [rows, fields] = await conn.query(
      "SELECT * FROM menus WHERE menu_id=?",[req.params.id]
    );

    // ถ้าทุก transaction เสร็จแล้ว ให้ทำการ ส่ง/เสร็จเลย
    await conn.commit();
    
    return (res.json(rows))
  } catch (err) {
    //ถ้ามี query ใด query หนึ่งมีปัญหา/พัง ให้สถานะ database กลับไป
    await conn.rollback();
    next(err);
  } finally {
    console.log("finally");
    conn.release(); //ปิด transaction
  }
});
exports.router = router;
