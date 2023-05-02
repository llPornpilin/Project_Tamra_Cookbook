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


// // เพิ่มเมนูอาหาร > redirect ไปแสดงหน้า mymenu
// router.post("/mymenu", multer().none(), async function (req, res, next) {
//     // const file = req.file;
//     // if (!file) {
//     //   const error = new Error("Please upload a file");
//     //   error.httpStatusCode = 400;
//     //   return next(error);
//     // }

//     const menuName = req.body.menuName;
//     const menuIngrediant = req.body.menuIngrediant;
//     const menuMethod = req.body.menuMethod;
//     const image = req.body.image;
//     const menuCategory = req.body.menuCategory;
//     const menuTypeCook = req.body.menuTypeCook;
//     const menuTypeMeat = req.body.menuTypeMeat;
//     const menuDay = req.body.menuDay;
//     const menuHour = req.body.menuHour;
//     const menuMinute = req.body.menuMinute;

//     const conn = await  pool.getConnection();
//     // await conn.beginTransaction(); // เป็นการเริ่มให้ database เริ่มจำ

//     try {
//       //insert เข้าตาราง menu
//       const menu = await conn.query(
//         "INSERT INTO menu(user_id, category_id, menu_name, menu_ingredient, menu_method, menu_duration, menu_image) VALUES(?, ?, ?, ?, ?, ?, ?);",
//         [1, 1, menuName, menuIngrediant, menuMethod, ]
//       )
//       // ถ้าทุก transaction เสร็จแล้ว ให้ทำการ ส่ง/เสร็จเลย
//       await conn.commit()
//       // res.send("success!");
//       res.redirect('/mymenu') //กลับไปที่หน้า myMenu
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


// แสดงเมนูใน category นั้น
router.get("/allmenu/:category_type/:category_id", async function (req, res, next) {
  const conn = await pool.getConnection();
  await conn.beginTransaction(); // เป็นการเริ่มให้ database เริ่มจำ

  try {
    if (req.params.category_type == 'category_nation') {
      const [rows, fields] = await conn.query( // **** JOIN table menus category_nation category_cooking category_meat
        "SELECT * FROM menus WHERE category_nation=?", [req.params.category_id]
      );
      return (res.json(rows))
    }


    // ถ้าทุก transaction เสร็จแล้ว ให้ทำการ ส่ง/เสร็จเลย
    await conn.commit();

  } catch (err) {
    //ถ้ามี query ใด query หนึ่งมีปัญหา/พัง ให้สถานะ database กลับไป
    await conn.rollback();
    next(err);
  } finally {
    console.log("finally");
    conn.release(); //ปิด transaction
  }
});


// แสดงเมนูที่เลือกมาแสดงรายละเอียด

router.get("/showmenu/:id", async function (req, res, next) {
  const conn = await pool.getConnection();
  await conn.beginTransaction(); // เป็นการเริ่มให้ database เริ่มจำ

  try {
    console.log(req.params.id);

    const [rows, fields] = await conn.query(
      "SELECT * FROM menus WHERE menu_id=?", [req.params.id]
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



router.get("/categorys", async function (req, res, next) {
  const conn = await pool.getConnection();
  // await conn.beginTransaction(); // เป็นการเริ่มให้ database เริ่มจำ

  try {
    //select category ออกมา ในหน้า home
    const [c_nation, cols] = await conn.query("SELECT nation_id,nation_name FROM category_nation;")
    const [c_cooking, cols2] = await conn.query("SELECT cooking_id,cooking_name FROM category_cooking;")
    const [c_meat, cols3] = await conn.query("SELECT meat_id,meat_name FROM category_meat;")

    return res.json([c_nation, c_cooking, c_meat]);

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


router.post("/addMenu", upload.single("images"), async function (req, res, next) {

  if (req.method == "POST") {
    const file = req.file;
    console.log(file)

    if (!file) {
      console.log(file)
      return res.status(400).json({ message: "Please upload a file" });
    }

    const menuName = req.body.menuName;
    const menuIngredient = req.body.menuIngredient.replaceAll('"', '');
    const menuHowTo = req.body.menuHowTo.replaceAll('"', '');
    console.log("name:", menuName, ", ing :", menuIngredient, ", howto :", menuHowTo);
    // time cooking
    const days = req.body.days;
    const hours = req.body.hours;
    const minutes = req.body.minutes;

    // userId
    const userId = req.body.userId;
    // v-model
    const nation = req.body.nation;
    const method = req.body.method;
    const meat = req.body.meat;


    const filename = req.file.filename;
    // Begin transaction
    const conn = await pool.getConnection();
    await conn.beginTransaction();

    try {
      let results = await conn.query(
        "INSERT INTO menus(menu_name, menu_ingredients, menu_methods, menu_duration, menu_image, user_id, category_nation, category_meat, category_cooking) " +
        "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);",
        [menuName, menuIngredient, menuHowTo, (days * 24 * 60) + (hours * 60) + (minutes * 1), filename, userId, nation, meat, method]
      );

      console.log("results :", results)

      await conn.commit();
      res.send("success!");
    } catch (err) {
      await conn.rollback();
      return res.status(400).json(err);
    } finally {
      conn.release();
    }
  }
}
);

exports.router = router;
