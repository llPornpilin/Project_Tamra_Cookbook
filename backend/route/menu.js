const express = require("express");
const path = require("path");
const pool = require("../config");
const multer = require("multer");

const router = express.Router();

const { isLoggedIn } = require("../middlewares"); //+

// ---------------------------------------ตั้งค่า multer-----------------------------------------
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


// ----------------------------------All Menu Page----------------------------------------------
// รับ path /allmenu มา แล้วแสดง หน้า all menu
router.get("/allmenu", async function (req, res, next) {
  try {
    const [rows, fields] = await pool.query("SELECT * FROM menus");
    console.log(rows)
    return res.json(rows);
  } catch (err) {
    return next(err);
  }
});

// แสดงเมนูใน category ที่เลือก
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

// แสดงรายละเอียด(หน้าฝั่งขวา)ของเมนูที่คลิกเลือก
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


// Delete menu
router.delete("/showmenu/:id", async function (req, res, next) {
  // Your code here
  const conn = await pool.getConnection();
  // Begin transaction
  await conn.beginTransaction();

  console.log("out", req.params.id)

  try {
    const [rows2, fields2] = await conn.query("DELETE FROM `menus` WHERE `menu_id` = ?", [
      req.params.id,
    ]);

    if (rows2.affectedRows === 1) {
      await conn.commit();
      res.status(204).send();
    } else {
      throw "Cannot delete the selected menu";
    }

  } catch (err) {
    console.log(err)
    await conn.rollback();
    return res.status(500).json(err);
  } finally {
    conn.release();
  }
});

// Update Menu
router.put("/showmenu/:id", async function (req, res, next) {
  // Your code here
  const conn = await pool.getConnection();
  // Begin transaction
  await conn.beginTransaction();

  try {
    // Delete menu
    const [rows2, fields2] = await conn.query("UPDATE `menus` SET menu_name=?, WHERE `menu_id` = ?", [
      req.body.menus.menu_name, req.params.id,
    ]);

    if (rows2.affectedRows === 1) {
      await conn.commit();
      res.status(204).send();
    } else {
      throw "Cannot update the selected menu";
    }

  } catch (err) {
    console.log(err)
    await conn.rollback();
    return res.status(500).json(err);
  } finally {
    conn.release();
  }
});

// search menu
router.get('/search_menu', async (req, res) => {
  const menu_name = req.query.search
  // console.log("search1 : ", menu_name)

  const [filtered] = await pool.query('SELECT * FROM menus WHERE menu_name LIKE ?', [`%${menu_name}%`])
  // console.log(filtered)
  return res.status(200).send(filtered)
})


// --------------------------------------Home Page------------------------------------------------
// แสดงรายการ catgory ทั้งหมด หน้า Home Page
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

// ------------------------------------Add My Menu Page---------------------------------------------
// เพิ่มเมนูของตัวเอง หน้า Add My Meny
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


// ---------------------------------------My Menu Page-----------------------------------------------
// แก้ไขเมนูตัวเอง หน้า My Menu
router.put('/updates', upload.single("image"), async function (req, res, next) {
  const conn = await pool.getConnection()
  await conn.beginTransaction();

  const file = req.file;
  console.log("file", file)

  const name = req.body.name;
  const id = req.body.id;
  const nation = req.body.nation;
  const cooking = req.body.cooking;
  const meat = req.body.meat;
  const duration = req.body.duration;
  const ingredients = req.body.ingredients;
  const methods = req.body.methods;

  if (file == null) {
    console.log("ไม่มีการเปลี่ยนflie")
    image = "not_change";
  } else if (!file) {
    console.log("ไม่ได้เป็นไฟล์")
    return res.status(400).json({ message: "Please upload a file" });
  } else {
    console.log("มีไฟล์ใหม่เข้ามา", req.file.filename)
    image = req.file.filename;
  }

  console.log(" body เข้ามาแล้ว ", name, id, image, nation, cooking, meat, duration, ingredients, methods)


  try {
    if (image == "not_change") {
      [row, fields1] = await conn.query(
        'UPDATE menus SET menu_name=?, category_nation=?, category_cooking=?, category_meat=?, menu_duration=?, menu_ingredients=?, menu_methods=? WHERE menu_id=?',
        [name, nation, cooking, meat, duration, ingredients, methods, id]
      )
      await conn.commit()
      console.log("PUT updates1", row)
    } else {
      [row, fields1] = await conn.query(
        'UPDATE menus SET menu_name=?,menu_image=? WHERE menu_id=?', [name, image, id]
      )
      await conn.commit()
      console.log("PUT updates2", row)
    }

    const [send, fields] = await conn.query('SELECT * FROM menus WHERE menu_id=?',[id])

    res.json({ data: send })
    // res.json(send)
    console.log("send",send)
  } catch (error) {
    await conn.rollback();
    res.status(500).json(error)
    console.log(error)
  } finally {
    console.log('finally')
    conn.release();
  }

})

// เรียกหน้า My Menu
router.get('/mymenu', isLoggedIn, async function (req, res, next) {
  const conn = await pool.getConnection()
  await conn.beginTransaction();

  console.log("mymenu req.user",req.user.user_id);

  const user = req.user.user_id;

  try {
    const [row, fields1] = await conn.query(
      'SELECT * FROM menus  WHERE user_id=?', [user]
    )

    await conn.commit()
    console.log("GET mymenu", row)
    res.json(row)
  } catch (error){
    await conn.rollback();
    res.status(500).json(error)
  } finally {
    console.log('finally')
    conn.release();
  }

})

// แสดงหน้า My Menu >> ซ้ำข้างบน
// router.get("/mymenu", multer().none(), async function (req, res, next) { // *********เพิ่ม params user_id*********
//   const conn = await pool.getConnection();
//   await conn.beginTransaction(); // เป็นการเริ่มให้ database เริ่มจำ

//   try {
//     console.log(req.params.id);

//     const [rows, fields] = await conn.query(
//       "SELECT * FROM menus"
//     );

//     // ถ้าทุก transaction เสร็จแล้ว ให้ทำการ ส่ง/เสร็จเลย
//     await conn.commit();

//     return (res.json(rows))
//   } catch (err) {
//     //ถ้ามี query ใด query หนึ่งมีปัญหา/พัง ให้สถานะ database กลับไป
//     await conn.rollback();
//     next(err);
//   } finally {
//     console.log("finally");
//     conn.release(); //ปิด transaction
//   }
// }
// )


exports.router = router;
