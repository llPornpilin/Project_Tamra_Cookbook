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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'ไข่1','ไข่1ฟอง,ไข่1ฟอง,ไข่1ฟอง','ทอด,ทอด,ทอด',10,'1',1,'CH','BF','BK'),(2,'ไข่2','ไข่1ฟอง,ไข่1ฟอง,ไข่1ฟอง','ทอด,ทอด,ทอด',20,'2',1,'CH','BF','BO'),(3,'ไข่3','ไข่1ฟอง,ไข่1ฟอง,ไข่1ฟอง','ทอด,ทอด,ทอด',30,'3',1,'TH','CK','BO'),(4,'ไข่4','ไข่1ฟอง,ไข่1ฟอง,ไข่1ฟอง','ทอด,ทอด,ทอด',40,'4',1,'TH','FH','ST'),(5,'ไข่5','ไข่1ฟอง,ไข่1ฟอง,ไข่1ฟอง','ทอด,ทอด,ทอด',50,'5',1,'TH','MT','ST');
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
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`username`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-22 19:33:06
