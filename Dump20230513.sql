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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_nation`
--

LOCK TABLES `category_nation` WRITE;
/*!40000 ALTER TABLE `category_nation` DISABLE KEYS */;
INSERT INTO `category_nation` VALUES ('CH','Chinese','/img/chinese_food.jpg','/img/china_flag.png'),('IN','Indian','/img/indian_food.jpg','/img/india_flag.jpg'),('IT','Italian','/img/italian_food.jpg','/img/italy_flag.png'),('JP','Japanese','/img/japanese_food.jpg','/img/japan_flag.jpg'),('KR','Korean','/img/korean_food.jpg','/img/korea_flag.jpg'),('OI','Others Inter','/img/other_inter_food.jpg',''),('OT','Others','/img/other.jpg',''),('TH','Thai','/img/thai_food.jpg','/img/thailand_flag.jpg');
/*!40000 ALTER TABLE `category_nation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `following`
--

DROP TABLE IF EXISTS `following`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `following` (
  `followed_id` int NOT NULL COMMENT 'ถูกติดตาม',
  `follower_id` int NOT NULL COMMENT 'ใครติดตาม'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `following`
--

LOCK TABLES `following` WRITE;
/*!40000 ALTER TABLE `following` DISABLE KEYS */;
/*!40000 ALTER TABLE `following` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (37,'ไก่ย่าง','ใจเย็น,ใกล้ละ,ไก่,พริกไทย,กระเทียม','ตั้งสติ,ดูให้รอบครอบ,หมัก,ย่าง',90,'images-1683352667187.jpg',1,'TH','CK','GR'),(38,'ซาลาเปาไข่เค็มลาวาา','ใจเย็น,ใกล้ละ,ไข่,แป้งอะไรสักอย่าง,','ตั้งสติ,ดูให้รอบครอบ,ค้น,ปั้น,นึ่ง',60,'image-1683357600229.jpg',1,'CH','OM','ST'),(39,'ไข่หวาน','ใจเย็น,ใกล้ละ,ไข่','ตั้งสติ,ดูให้รอบครอบ,เทลงกระทะ',35,'images-1683352804832.jpg',1,'JP','OM','FR'),(40,'ซุปมิโซะ','ใจเย็น,ใกล้ละ,มิโซะ','ตั้งสติ,ดูให้รอบครอบ,ต้ม',30,'images-1683353048771.jpg',1,'JP','OM','BO'),(41,'ไก่ย่าง','ใจเย็น,ใกล้ละ,ไก่,พริก,หอมแดง,ต้นหอม','ตั้งสติ,ดูให้รอบครอบ,ย่าง',54,'images-1683353110137.jpg',1,'TH','CK','GR'),(42,'แกงเขียวหวาน','ใจเย็น,ใกล้ละ,ลูกชิ้นปลากราย,มะเขือเปราะ,โหระพา,กะทิ,พริกชี้ฟ้า,มะเขือ','ตั้งสติ,ดูให้รอบครอบ,ใส่ทุกอย่างลงไป,ต้ม',130,'images-1683353217673.jpg',1,'TH','FH','BO'),(43,'ข้าวมันไก่','ใจเย็น,ใกล้ละ,ไก่,ข้าว,น้ำมัน,กระเทียม,พริก,แตงกวา','ตั้งสติ,ดูให้รอบครอบ,ใส่ทุกอย่างเข้าด้วยกัน,แล้วก็นึ่งละมั้ง',210,'images-1683353443523.jpg',1,'TH','CK','BO'),(44,'เป็ดย่างqqqqq','ใจเย็น,ใกล้ละ,เป็ด','ตั้งสติ,ดูให้รอบครอบ,ย่าง',285,'image-1683356010500.jpg',1,'CH','DK','GR'),(45,'ซาลาเปาหมูสับๆๆๆๆๆๆๆ','ใจเย็น,ใกล้ละ,หมูสับ,พริกไทย,แป้งอะไรสักอย่าง,ไข่','ตั้งสติ,ดูให้รอบครอบ,ปั้น,นึ่ง',75,'image-1683875502086.jpg',1,'CH','OM','BK'),(46,'Monkey','ใจเย็น,ใกล้ละ','ตั้งสติ,ดูให้รอบครอบ',60,'images-1683878746485.jpg',1,'IN','MT','BO'),(47,'ไก่ทอดนิว','ไก่,กระเทียม,พริกไทย,แป้ง,หอมแดง','หั่น,หมัก,ทอด,จัดใส่จาน',90,'images-1683946888346.jpg',1,'TH','CK','FR');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stars`
--

DROP TABLE IF EXISTS `stars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stars` (
  `user_id` int NOT NULL,
  `menu_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stars`
--

LOCK TABLES `stars` WRITE;
/*!40000 ALTER TABLE `stars` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,11,'mQ2Rto42YRRXc2IOs&nepE0eFOl@W4/u=uHQ64Fg0Yj3inOr^0!yFyiRpFppRkL@wPcv52MORE&GI1k@7^E0i-pV3AuE/4T7trve'),(3,15,'$J707N4D5w&TaCCY=!qhJ/!wh137XxYk8JL3IV!Qb47nIs^TgNhF04HUqH9=-euoE^ZzysU3hKiQK4#z24h078ITxflqz!wT/-q@'),(4,14,'W!M7dOgd8qrhYwlGCH@p!vU0u4XU^#$w*XkhRRNio59^vDjeju3V@LHwKg/LbNoL5zq$bOD&O=!cU!-ve1pwlXu/B-33k2NqczPe');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (11,'pure@gmail.com','Pure_jps','$2b$05$ksVTQABkMXJHzK9b5S.e3.M0OdjPvY2v/9r6JvksnwH559G/V117C','2023-05-13 06:01:01'),(12,'UrangOtan@gmail.com','UrangOtan55','$2b$05$KbuV7hC1rH30wF3xLxTcGe/GyZ.gehAI5dkZsvL3EPbenZxD2OCly','2023-05-13 06:25:38'),(14,'yummy@gmail.com','yummy','$2b$05$2pNdfBch1XCAhu7EOKUE/OEykPNGM06kJ2NnokoclLxadu8Xy8.C.','2023-05-13 06:34:56'),(15,'4eve@gmail.com','4ever','$2b$05$1hRfXHRCwxUefDM9iyncPusl/kZnFj02wAp0/0Fb.OL4yWkNy9VmG','2023-05-13 06:37:07');
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

-- Dump completed on 2023-05-13 18:05:16
