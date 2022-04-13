-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: vovan_internet_shop
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `id_brand` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `country` varchar(45) NOT NULL,
  `build` varchar(45) NOT NULL,
  PRIMARY KEY (`id_brand`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (1,'LG','ручная сборка','Германия');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id_client` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `age` int NOT NULL,
  `nummber_buys` int DEFAULT NULL,
  PRIMARY KEY (`id_client`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (2,'Арарат',19,3);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery` (
  `id_delivery` int NOT NULL AUTO_INCREMENT,
  `address` varchar(100) NOT NULL,
  `cost` float NOT NULL,
  PRIMARY KEY (`id_delivery`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES (3,'ул. Хользунова 15а',50);
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedbacks`
--

DROP TABLE IF EXISTS `feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedbacks` (
  `id_feedback` int NOT NULL AUTO_INCREMENT,
  `content` varchar(500) NOT NULL,
  `date_time` datetime NOT NULL,
  `id_client` int NOT NULL,
  PRIMARY KEY (`id_feedback`),
  KEY `id_client` (`id_client`),
  CONSTRAINT `feedbacks_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedbacks`
--

LOCK TABLES `feedbacks` WRITE;
/*!40000 ALTER TABLE `feedbacks` DISABLE KEYS */;
INSERT INTO `feedbacks` VALUES (4,'Хороший магазин!','2022-03-01 19:17:22',2);
/*!40000 ALTER TABLE `feedbacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods` (
  `id_good` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `id_brand` int NOT NULL,
  `id_parameter` int NOT NULL,
  PRIMARY KEY (`id_good`),
  KEY `id_brand` (`id_brand`),
  KEY `id_parameter` (`id_parameter`),
  CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`id_brand`) REFERENCES `brands` (`id_brand`),
  CONSTRAINT `goods_ibfk_2` FOREIGN KEY (`id_parameter`) REFERENCES `parameters` (`id_parameter`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (5,'электрический чайник',1,7);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_to_orders`
--

DROP TABLE IF EXISTS `goods_to_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_to_orders` (
  `id_good` int NOT NULL,
  `id_order` int NOT NULL,
  PRIMARY KEY (`id_good`,`id_order`),
  KEY `id_order` (`id_order`),
  CONSTRAINT `goods_to_orders_ibfk_1` FOREIGN KEY (`id_good`) REFERENCES `goods` (`id_good`),
  CONSTRAINT `goods_to_orders_ibfk_2` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_to_orders`
--

LOCK TABLES `goods_to_orders` WRITE;
/*!40000 ALTER TABLE `goods_to_orders` DISABLE KEYS */;
INSERT INTO `goods_to_orders` VALUES (5,6);
/*!40000 ALTER TABLE `goods_to_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_to_stocks`
--

DROP TABLE IF EXISTS `goods_to_stocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_to_stocks` (
  `id_good` int NOT NULL,
  `id_stock` int NOT NULL,
  PRIMARY KEY (`id_good`,`id_stock`),
  KEY `id_stock` (`id_stock`),
  CONSTRAINT `goods_to_stocks_ibfk_1` FOREIGN KEY (`id_good`) REFERENCES `goods` (`id_good`),
  CONSTRAINT `goods_to_stocks_ibfk_2` FOREIGN KEY (`id_stock`) REFERENCES `sales` (`id_stock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_to_stocks`
--

LOCK TABLES `goods_to_stocks` WRITE;
/*!40000 ALTER TABLE `goods_to_stocks` DISABLE KEYS */;
INSERT INTO `goods_to_stocks` VALUES (5,8);
/*!40000 ALTER TABLE `goods_to_stocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id_order` int NOT NULL AUTO_INCREMENT,
  `cost` float NOT NULL,
  `id_client` int NOT NULL,
  `id_delivery` int NOT NULL,
  `id_store_employee` int NOT NULL,
  `id_good` int NOT NULL,
  PRIMARY KEY (`id_order`),
  KEY `id_client` (`id_client`),
  KEY `id_delivery` (`id_delivery`),
  KEY `id_store_employee` (`id_store_employee`),
  KEY `id_good` (`id_good`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`id_delivery`) REFERENCES `delivery` (`id_delivery`),
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`id_store_employee`) REFERENCES `store_employees` (`id_store_employee`),
  CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`id_good`) REFERENCES `goods` (`id_good`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (6,319,2,3,9,5);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parameters`
--

DROP TABLE IF EXISTS `parameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parameters` (
  `id_parameter` int NOT NULL AUTO_INCREMENT,
  `color` varchar(45) NOT NULL,
  `age` int NOT NULL,
  PRIMARY KEY (`id_parameter`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parameters`
--

LOCK TABLES `parameters` WRITE;
/*!40000 ALTER TABLE `parameters` DISABLE KEYS */;
INSERT INTO `parameters` VALUES (7,'черный',18);
/*!40000 ALTER TABLE `parameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parameters_to_value_parameters`
--

DROP TABLE IF EXISTS `parameters_to_value_parameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parameters_to_value_parameters` (
  `id_parameter` int NOT NULL,
  `id_value_parameter` int NOT NULL,
  PRIMARY KEY (`id_parameter`,`id_value_parameter`),
  KEY `id_value_parameter` (`id_value_parameter`),
  CONSTRAINT `parameters_to_value_parameters_ibfk_1` FOREIGN KEY (`id_value_parameter`) REFERENCES `value_parameters` (`id_value_parameter`),
  CONSTRAINT `parameters_to_value_parameters_ibfk_2` FOREIGN KEY (`id_parameter`) REFERENCES `parameters` (`id_parameter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parameters_to_value_parameters`
--

LOCK TABLES `parameters_to_value_parameters` WRITE;
/*!40000 ALTER TABLE `parameters_to_value_parameters` DISABLE KEYS */;
INSERT INTO `parameters_to_value_parameters` VALUES (7,10);
/*!40000 ALTER TABLE `parameters_to_value_parameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `id_stock` int NOT NULL AUTO_INCREMENT,
  `condition` varchar(400) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id_stock`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (8,'Trade-In старого чайника','Великий обмен');
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_employees`
--

DROP TABLE IF EXISTS `store_employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_employees` (
  `id_store_employee` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `efficiency` float NOT NULL,
  `number_of_sales` int DEFAULT NULL,
  PRIMARY KEY (`id_store_employee`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_employees`
--

LOCK TABLES `store_employees` WRITE;
/*!40000 ALTER TABLE `store_employees` DISABLE KEYS */;
INSERT INTO `store_employees` VALUES (9,'Валя',0.89,1293);
/*!40000 ALTER TABLE `store_employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `value_parameters`
--

DROP TABLE IF EXISTS `value_parameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `value_parameters` (
  `id_value_parameter` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `value` float NOT NULL,
  PRIMARY KEY (`id_value_parameter`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `value_parameters`
--

LOCK TABLES `value_parameters` WRITE;
/*!40000 ALTER TABLE `value_parameters` DISABLE KEYS */;
INSERT INTO `value_parameters` VALUES (10,'мощность',100);
/*!40000 ALTER TABLE `value_parameters` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-13 21:39:57
