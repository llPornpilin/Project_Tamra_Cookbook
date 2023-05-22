-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: tamra_cookbook
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category_cooking`
--

DROP TABLE IF EXISTS `category_cooking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_cooking` (
  `cooking_id` varchar(10) NOT NULL,
  `cooking_name` varchar(255) NOT NULL,
  `cooking_image` text NOT NULL,
  PRIMARY KEY (`cooking_id`),
  UNIQUE KEY `cooking_id_UNIQUE` (`cooking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_cooking`
--

LOCK TABLES `category_cooking` WRITE;
/*!40000 ALTER TABLE `category_cooking` DISABLE KEYS */;
INSERT INTO `category_cooking` VALUES ('BK','Baked Food','/img/baked_food.png'),('BO','Boiled Food','/img/boiled_food.jpg'),('FR','Fried Food','/img/fried_food.jpg'),('GR','Grilled Food','/img/grilled_food.jpg'),('ST','Steamed Food','/img/streamed_food.jpg'),('STR','Stirred Food','/img/stirred_food.jpg');
/*!40000 ALTER TABLE `category_cooking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_meat`
--

DROP TABLE IF EXISTS `category_meat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_meat` (
  `meat_id` varchar(10) NOT NULL,
  `meat_name` varchar(255) NOT NULL,
  `meat_image` text NOT NULL,
  PRIMARY KEY (`meat_id`),
  UNIQUE KEY `meat_id_UNIQUE` (`meat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_meat`
--

LOCK TABLES `category_meat` WRITE;
/*!40000 ALTER TABLE `category_meat` DISABLE KEYS */;
INSERT INTO `category_meat` VALUES ('BF','Beef','/img/beef.jpg'),('CB','Crab','/img/crabb.jpg'),('CK','Chicken','/img/chicken.jpg'),('DK','Duck','/img/duck.jpg'),('FH','Fish','/img/fish.jpeg'),('MT','Mutton','/img/mutton.jpg'),('OM','Other Meat','/img/other_meat.jpg'),('PK','Pork','/img/pork.jpg'),('SF','Shellfish','/img/shellfish.jpg'),('SP','Shrimp','/img/shrimp.jpg'),('SQ','Squid','/img/squid.jpg');
/*!40000 ALTER TABLE `category_meat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_nation`
--

DROP TABLE IF EXISTS `category_nation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_nation` (
  `nation_id` varchar(10) NOT NULL,
  `nation_name` varchar(255) NOT NULL,
  `nation_image` text NOT NULL,
  `nation_flag` text,
  PRIMARY KEY (`nation_id`),
  UNIQUE KEY `category_id_UNIQUE` (`nation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_nation`
--

LOCK TABLES `category_nation` WRITE;
/*!40000 ALTER TABLE `category_nation` DISABLE KEYS */;
INSERT INTO `category_nation` VALUES ('CH','Chinese','/img/chinese_food.jpg','/img/china_flag.png'),('IN','Indian','/img/indian_food.jpg','/img/india_flag.jpg'),('IT','Italian','/img/italian_food.jpg','/img/italy_flag.png'),('JP','Japanese','/img/japanese_food.jpg','/img/japan_flag.jpg'),('KR','Korean','/img/korean_food.jpg','/img/korea_flag.jpg'),('OI','Others Inter','/img/other_inter_food.jpg','/img/global_flag.png'),('OT','Others','/img/other.jpg',''),('TH','Thai','/img/thai_food.jpg','/img/thailand_flag.jpg');
/*!40000 ALTER TABLE `category_nation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `detail` varchar(255) NOT NULL,
  `menu_id` int NOT NULL,
  `comment_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment_by_id` int NOT NULL,
  PRIMARY KEY (`comment_id`),
  UNIQUE KEY `comment_id_UNIQUE` (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'อร่อยมาก',38,'2023-05-18 07:56:45',14),(4,'อร่อยสุด',37,'2023-05-18 08:08:56',11),(5,'อร่อยจริงๆ',37,'2023-05-18 08:08:56',14),(7,'อร่อย',37,'2023-05-18 08:23:43',11),(8,'อร้อน',37,'2023-05-18 08:23:43',12),(9,'อร่อย',37,'2023-05-18 08:23:43',13),(10,'อร่อย',37,'2023-05-18 08:23:43',14),(20,'ทำตามได้เลย',44,'2023-05-20 01:58:39',14),(21,'ง่ายมาก',46,'2023-05-20 01:58:55',14),(22,'ทำตามแล้วหอมมาก',41,'2023-05-20 01:59:12',14),(23,'ชอบกันทั้งครอบครัวเลย',41,'2023-05-20 01:59:32',14),(26,'ลาวาล้นมาก',38,'2023-05-20 02:19:45',15),(27,'ทำง่ายมาก',40,'2023-05-20 02:23:50',15),(40,'666',37,'2023-05-20 04:30:57',15),(41,'111',37,'2023-05-20 04:31:07',15),(42,'ทำตามแล้ว อร่อยมาก',39,'2023-05-20 04:32:08',15),(43,'555',39,'2023-05-20 04:32:56',15),(44,'5556666',39,'2023-05-20 04:33:21',15),(45,'ทำง่ายสุดๆ',40,'2023-05-20 04:35:44',15),(46,'ง่ายอ่ะ',37,'2023-05-20 04:36:00',15),(49,'อร่อยๆ',39,'2023-05-20 04:51:36',11),(52,'5555',41,'2023-05-20 04:53:05',11),(55,'ไม่ยากอย่างที่คิด',38,'2023-05-20 04:53:54',15),(57,'555',42,'2023-05-20 05:00:07',14),(58,'monkeyyyyyy',46,'2023-05-20 05:03:02',14),(59,'บอกละเอียดมาก',42,'2023-05-20 05:06:52',15),(60,'grrggdfd',38,'2023-05-20 06:15:17',15),(61,'dadfdd',37,'2023-05-20 06:15:58',15),(62,'good',42,'2023-05-20 07:03:42',15),(63,'ok',51,'2023-05-20 07:10:07',15),(65,'5555',47,'2023-05-20 13:11:59',15),(66,'5555',46,'2023-05-20 13:31:40',15),(67,'ทำไก่ได้หน้ากินมาก',43,'2023-05-20 13:31:59',15),(68,'หน้าทานมากค่ะ',51,'2023-05-20 16:18:45',16),(69,'หนังไก่สีสวยมากกก',47,'2023-05-20 16:19:01',17),(70,'หมูสับเน้นๆๆเลย',45,'2023-05-20 16:19:16',16),(71,'น่าทานมากคับ',37,'2023-05-20 16:20:12',12),(72,'ทำยากน่าดู',41,'2023-05-20 16:20:28',12),(73,'ทำตามแล้ว อร่อยมากคับ',43,'2023-05-20 16:20:44',12),(74,'มีแบบได้ไข่ข้นๆๆเยอะๆๆไหมคับ',46,'2023-05-20 16:21:21',12),(75,'น่าทานมากกกกก',53,'2023-05-20 16:24:21',14),(76,'ทำตามแล้วแป้งแข็ง ',45,'2023-05-20 16:24:40',14),(77,'มีแบบให้เป็นลาวาเย้มๆๆไหมคะ',38,'2023-05-20 16:25:16',14),(78,'หนังไก่สีสวยมากกกก',37,'2023-05-20 16:28:39',15),(79,'ทำง่ายกว่าที่คิดมากกกก',39,'2023-05-20 16:28:52',15),(80,'วัตถุดิบก็เยอะ วิธีทำก็เยอะ :)',42,'2023-05-20 16:29:24',18),(81,'ยยากเหมือนกันนะเนี่ยยย',44,'2023-05-20 16:29:51',15);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `like_id` int NOT NULL AUTO_INCREMENT,
  `menu_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`like_id`),
  UNIQUE KEY `like_id_UNIQUE` (`like_id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (11,46,14),(37,40,15),(41,38,14),(52,37,14),(53,42,14),(55,41,14),(65,47,15),(66,51,15),(67,38,15),(70,43,15),(71,38,17),(72,42,17),(73,41,17),(74,44,17),(75,46,17),(76,47,17),(77,44,18),(78,46,18),(79,52,18),(80,41,16),(81,51,16),(82,37,12),(83,43,12),(85,46,12),(86,37,15),(87,39,15),(88,42,15),(89,44,15),(90,52,15),(91,43,11),(92,44,11),(93,45,11),(94,46,11),(95,52,11),(96,53,11);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `menu_id` int NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(255) NOT NULL,
  `menu_ingredients` text NOT NULL,
  `menu_methods` text NOT NULL,
  `menu_duration` int NOT NULL,
  `menu_image` text NOT NULL,
  `user_id` int NOT NULL,
  `category_nation` varchar(10) NOT NULL,
  `category_meat` varchar(10) NOT NULL,
  `category_cooking` varchar(10) NOT NULL,
  PRIMARY KEY (`menu_id`),
  UNIQUE KEY `menu_id_UNIQUE` (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (37,'ไก่ย่าง','ใจเย็น,ใกล้ละ,ไก่,พริกไทย,กระเทียม','ตั้งสติ,ดูให้รอบครอบ,หมัก,ย่าง',90,'image-1684600228663.jpg',11,'TH','CK','GR'),(38,'ซาลาเปาไข่เค็มลาวาา','ใจเย็น,ใกล้ละ,ไข่,แป้งอะไรสักอย่าง,','ตั้งสติ,ดูให้รอบครอบ,ค้น,ปั้น,นึ่ง',60,'image-1684599589629.jpg',12,'CH','OM','ST'),(39,'ไข่หวาน','ใจเย็น,ใกล้ละ,ไข่','ตั้งสติ,ดูให้รอบครอบ,เทลงกระทะ',35,'image-1684599730979.jpg',14,'JP','OM','FR'),(40,'ซุปมิโซะ','ใจเย็น,ใกล้ละ,มิโซะ','ตั้งสติ,ดูให้รอบครอบ,ต้ม',30,'image-1684599964027.jpg',15,'JP','OM','BO'),(41,'แกงแกะ','ใจเย็น,ใกล้ละ,ไก่,พริก,หอมแดง,ต้นหอม','ตั้งสติ,ดูให้รอบครอบ,ย่าง',54,'image-1684599495029.jpg',16,'TH','CK','GR'),(42,'แกงเขียวหวาน','ใจเย็น,ใกล้ละ,ลูกชิ้นปลากราย,มะเขือเปราะ,โหระพา,กะทิ,พริกชี้ฟ้า,มะเขือ','ตั้งสติ,ดูให้รอบครอบ,ใส่ทุกอย่างลงไป,ต้ม',130,'image-1684598964402.jpg',17,'CH','FH','FR'),(43,'ข้าวมันไก่','ใจเย็น,ใกล้ละ,ไก่,ข้าว,น้ำมัน,กระเทียม,พริก,แตงกวา','ตั้งสติ,ดูให้รอบครอบ,ใส่ทุกอย่างเข้าด้วยกัน,แล้วก็นึ่งละมั้ง',210,'image-1684598987941.jpg',17,'TH','CK','BO'),(44,'เป็ดย่าง','ใจเย็น,ใกล้ละ,เป็ด','ตั้งสติ,ดูให้รอบครอบ,ย่าง',285,'image-1684599979963.jpg',15,'CH','DK','GR'),(45,'ซาลาเปาหมูสับ','ใจเย็น,ใกล้ละ,หมูสับ,พริกไทย,แป้งอะไรสักอย่าง,ไข่','ตั้งสติ,ดูให้รอบครอบ,ปั้น,นึ่ง',75,'image-1684599756699.jpg',14,'CH','OM','BK'),(46,'ปูผัดผงกะหรี่','ใจเย็น,ใกล้ละ','ตั้งสติ,ดูให้รอบครอบ',60,'image-1684600034852.jpg',15,'IN','MT','BO'),(47,'ไก่นิวออลีนส์','ไก่,กระเทียม,พริกไทย,แป้ง,หอมแดง','หั่น,หมัก,ทอด,จัดใส่จาน',90,'image-1684599766534.jpg',14,'TH','CK','FR'),(51,'ข้าวยำเกาหลี','กระเทียม,พริกไทย,fdfsdfs','ตั้งสติ,ดูให้รอบครอบ,ผัด,หมัก',90,'image-1684600098692.jpg',15,'TH','PK','ST'),(52,'ปลากะพงทอดน้ำปลา','ใจเย็น,ใกล้ละ','ตั้งสติ,ดูให้รอบครอบ',0,'image-1684599830698.jpg',14,'TH','FH','FR'),(53,'หมึกแดดเดียว','หมึก,กระเทียม,ซอสพริก,แดด,น้ำมัน,เกลือ','สับกระเทียม,ล้างหมึก,หั่นหมึก,ตั้งน้ำมัน,รอให้ร้อนปานกลาง,นำหมึกลงไปทอด,พอใกล้หมึกใกล้สุก ให้ใส่กระเทียมตามลงไป,แล้วรีบช้อนขึ้น,จัดใส่จาน,เทซอสพริกใส่ถ้วย',85,'images-1684599321854.jpg',18,'TH','SQ','FR');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stars`
--

DROP TABLE IF EXISTS `stars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stars` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `menu_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stars`
--

LOCK TABLES `stars` WRITE;
/*!40000 ALTER TABLE `stars` DISABLE KEYS */;
INSERT INTO `stars` VALUES (16,14,37),(20,14,44),(23,14,40),(24,14,42),(31,14,38),(35,15,40),(36,15,38),(37,15,42),(38,17,38),(39,17,44),(40,17,46),(41,18,37),(42,18,44),(43,18,46),(44,18,52),(45,16,41),(46,16,51),(47,12,37),(48,12,51),(49,12,47),(51,14,41),(52,15,37),(53,15,44),(55,15,52),(56,11,38),(57,11,43),(58,11,44),(59,11,46),(60,11,51);
/*!40000 ALTER TABLE `stars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `token` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_UNIQUE` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,11,'mQ2Rto42YRRXc2IOs&nepE0eFOl@W4/u=uHQ64Fg0Yj3inOr^0!yFyiRpFppRkL@wPcv52MORE&GI1k@7^E0i-pV3AuE/4T7trve'),(3,15,'$J707N4D5w&TaCCY=!qhJ/!wh137XxYk8JL3IV!Qb47nIs^TgNhF04HUqH9=-euoE^ZzysU3hKiQK4#z24h078ITxflqz!wT/-q@'),(4,14,'W!M7dOgd8qrhYwlGCH@p!vU0u4XU^#$w*XkhRRNio59^vDjeju3V@LHwKg/LbNoL5zq$bOD&O=!cU!-ve1pwlXu/B-33k2NqczPe'),(5,12,'LgZLaKpJGfhft=aIxdqxwZPnu^CVLD6nEf@Jdb0VY!C4#yCdZc8WczquKQeK@p/P2v12BUNwCIWbdmGRqKiSYD&LQZp#8qW8Po=2'),(6,16,'hX2-cBbC*xavXNmPex@1yS99!xy2&*2d03p93Xe*5=g^aL=/JYuAPPwY0r8cGXd1mK-m9n2xzZ!zn2O8ndreo=$4Xq#wCQG9vBkv'),(7,17,'2/J6L*kN@c@nBD2eHBUKb7fCwp5!VG4qafls$TW/k7aDv6I4CeonBv6nI^qmgxxFPrhk-TB9HY*xyer$8znFAkwq7cmdFMF4o4Zb'),(8,18,'d9U4VU9CD=m7zrujp$Tw*qKNC3AKxrWqtxMzaKqF3Ze^g#&CLszYpILC8W@2a0PKJMo^R2hv=S#gPi4hG6u3xCg&lUrY^JJGoaQ*');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `join_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`username`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (11,'pure@gmail.com','Pure_jps','$2b$05$ksVTQABkMXJHzK9b5S.e3.M0OdjPvY2v/9r6JvksnwH559G/V117C','2023-05-13 06:01:01'),(12,'UrangOtan@gmail.com','UrangOtan55','$2b$05$KbuV7hC1rH30wF3xLxTcGe/GyZ.gehAI5dkZsvL3EPbenZxD2OCly','2023-05-13 06:25:38'),(14,'yummy@gmail.com','yummy','$2b$05$2pNdfBch1XCAhu7EOKUE/OEykPNGM06kJ2NnokoclLxadu8Xy8.C.','2023-05-13 06:34:56'),(15,'4eve@gmail.com','4ever','$2b$05$1hRfXHRCwxUefDM9iyncPusl/kZnFj02wAp0/0Fb.OL4yWkNy9VmG','2023-05-13 06:37:07'),(16,'hanuman@hotmail.com','5Hanuman','$2b$05$HlpctJGkeF8cY0BATNE9ue6QtbtaPCpNSD5Mpes9nI5lH7JChcYTS','2023-05-20 15:54:42'),(17,'XiaoFei@email.com','XiaoFei','$2b$05$Nn7oHQmPd4cCmzbbfd15LuG3RF3wx8aBkP//c/AElKDzp0UOZXLRi','2023-05-20 15:58:12'),(18,'42485@bodin.ac.th','bodin49','$2b$05$evw8Y/4LrG06lrEQ0j1FUuNhDlnarMFhO48V/zaz7WyRC4H/ejuw2','2023-05-20 16:02:20');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-20 23:33:58
