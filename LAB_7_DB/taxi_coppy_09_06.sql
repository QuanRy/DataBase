-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: coppy_new_mydb
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
-- Table structure for table `additional_options`
--

DROP TABLE IF EXISTS `additional_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `additional_options` (
  `id_additional_options` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_additional_options`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `additional_options`
--

LOCK TABLES `additional_options` WRITE;
/*!40000 ALTER TABLE `additional_options` DISABLE KEYS */;
INSERT INTO `additional_options` VALUES (1,'кондиционер'),(2,'массажное кресло'),(3,'доставка посылки'),(4,'детское кресло'),(5,'Wi-Fi'),(6,'перевозка грузов'),(7,'массаж'),(8,'увлажнитель воздуха'),(9,'светомузыка'),(10,'еда и напитки');
/*!40000 ALTER TABLE `additional_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `additional_options_has_trips`
--

DROP TABLE IF EXISTS `additional_options_has_trips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `additional_options_has_trips` (
  `additional_options_id_additional_options` int NOT NULL,
  `trips_id_trips` int NOT NULL,
  PRIMARY KEY (`additional_options_id_additional_options`,`trips_id_trips`),
  KEY `fk_additional_options_has_trips_trips1_idx` (`trips_id_trips`),
  KEY `fk_additional_options_has_trips_additional_options1_idx` (`additional_options_id_additional_options`),
  CONSTRAINT `fk_additional_options_has_trips_additional_options1` FOREIGN KEY (`additional_options_id_additional_options`) REFERENCES `additional_options` (`id_additional_options`),
  CONSTRAINT `fk_additional_options_has_trips_trips1` FOREIGN KEY (`trips_id_trips`) REFERENCES `trips` (`id_trips`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `additional_options_has_trips`
--

LOCK TABLES `additional_options_has_trips` WRITE;
/*!40000 ALTER TABLE `additional_options_has_trips` DISABLE KEYS */;
INSERT INTO `additional_options_has_trips` VALUES (1,90),(2,91),(3,92),(4,93),(5,94),(6,95),(7,96),(8,97),(9,98),(10,99);
/*!40000 ALTER TABLE `additional_options_has_trips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autos`
--

DROP TABLE IF EXISTS `autos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autos` (
  `id_autos` int NOT NULL AUTO_INCREMENT,
  `color` varchar(45) NOT NULL,
  `number` varchar(10) NOT NULL,
  `name` varchar(45) NOT NULL,
  `brand` varchar(45) NOT NULL,
  `classes_id_classes` int NOT NULL,
  PRIMARY KEY (`id_autos`),
  UNIQUE KEY `number_UNIQUE` (`number`),
  KEY `fk_autos_classes1_idx` (`classes_id_classes`),
  CONSTRAINT `fk_autos_classes1` FOREIGN KEY (`classes_id_classes`) REFERENCES `classes` (`id_classes`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autos`
--

LOCK TABLES `autos` WRITE;
/*!40000 ALTER TABLE `autos` DISABLE KEYS */;
INSERT INTO `autos` VALUES (80,'голубой','а334фв','solaris','hyundai',71),(81,'серый','м801ук','zafira','opel',73),(82,'черный','в001пр','rio','kia',74),(83,'белый','л647кк','vesta','lada',70),(84,'красный','н190рп','forester','subaru',72),(85,'белый','а532пк','next','газель',75),(86,'желтый','р321вф','logan','renault',70),(87,'черный','м001мм','a7','audi',72),(88,'зеленый','а275ук','movano','opel',73),(89,'синий','п867оп','granta','lada',70);
/*!40000 ALTER TABLE `autos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classes` (
  `id_classes` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id_classes`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` VALUES (70,'Эконом'),(71,'Бизнес'),(72,'Вип'),(73,'Многоместное'),(74,'Детское'),(75,'Грузовое');
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id_clients` int NOT NULL AUTO_INCREMENT,
  `telephone_number` bigint NOT NULL,
  `nickname` varchar(45) NOT NULL,
  PRIMARY KEY (`id_clients`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (30,78005553535,'QuanRy'),(31,79021527509,'4DKBS'),(32,79046107217,'Damisty'),(33,79193337290,'Lucky_Grin'),(34,79213727262,'Tinker_Drinker'),(35,79027432121,'Ivan_Paymon'),(36,79214567357,'Никитка'),(37,79746172574,'Старый_гусь'),(38,78954657251,'Pozhiloy_Ded'),(39,79023746785,'Ded_inside'),(41,79173706710,'Pupkin_007'),(42,79128246683,'ЛОСЬ_ИНОКЕНТИЙ');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contracts` (
  `id_contracts` int NOT NULL AUTO_INCREMENT,
  `taxi_companies_id_taxi_companies` int NOT NULL,
  `autos_id_autos` int NOT NULL,
  `taxi_drivers_id_taxi_drivers` int NOT NULL,
  `entry_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`id_contracts`),
  KEY `fk_contracts_taxi_companies1_idx` (`taxi_companies_id_taxi_companies`),
  KEY `fk_contracts_autos1_idx` (`autos_id_autos`),
  KEY `fk_contracts_taxi_drivers1_idx` (`taxi_drivers_id_taxi_drivers`),
  CONSTRAINT `fk_contracts_autos1` FOREIGN KEY (`autos_id_autos`) REFERENCES `autos` (`id_autos`),
  CONSTRAINT `fk_contracts_taxi_companies1` FOREIGN KEY (`taxi_companies_id_taxi_companies`) REFERENCES `taxi_companies` (`id_taxi_companies`),
  CONSTRAINT `fk_contracts_taxi_drivers1` FOREIGN KEY (`taxi_drivers_id_taxi_drivers`) REFERENCES `taxi_drivers` (`id_taxi_drivers`),
  CONSTRAINT `contracts_chk_1` CHECK ((cast(`entry_date` as date) <= cast(`end_date` as date))),
  CONSTRAINT `contracts_chk_2` CHECK ((cast(`entry_date` as date) <= cast(`end_date` as date)))
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contracts`
--

LOCK TABLES `contracts` WRITE;
/*!40000 ALTER TABLE `contracts` DISABLE KEYS */;
INSERT INTO `contracts` VALUES (100,40,80,60,'2021-09-12','2023-09-12'),(101,41,81,61,'2021-07-25','2022-01-24'),(102,42,82,62,'2020-11-14','2025-05-13'),(103,43,83,63,'2019-03-03','2020-03-03'),(104,44,84,64,'2017-02-27','2019-02-13'),(105,45,85,65,'2022-01-30','2022-12-31'),(106,46,86,66,'2022-02-07','2027-02-07'),(107,47,87,67,'2014-05-01','2024-05-01'),(108,48,88,68,'2019-03-24','2022-03-23'),(109,49,89,69,'2011-06-19','2023-01-17');
/*!40000 ALTER TABLE `contracts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forms_of_payment`
--

DROP TABLE IF EXISTS `forms_of_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forms_of_payment` (
  `id_forms_of_payment` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_forms_of_payment`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forms_of_payment`
--

LOCK TABLES `forms_of_payment` WRITE;
/*!40000 ALTER TABLE `forms_of_payment` DISABLE KEYS */;
INSERT INTO `forms_of_payment` VALUES (20,'наличные'),(21,'бонусы'),(22,'криптовалюта'),(23,'электронные деньги');
/*!40000 ALTER TABLE `forms_of_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_methods`
--

DROP TABLE IF EXISTS `order_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_methods` (
  `id_order_methods` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_order_methods`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_methods`
--

LOCK TABLES `order_methods` WRITE;
/*!40000 ALTER TABLE `order_methods` DISABLE KEYS */;
INSERT INTO `order_methods` VALUES (10,'звонок'),(11,'смс'),(12,'приложение'),(13,'сайт');
/*!40000 ALTER TABLE `order_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id_reviews` int NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL,
  `content` varchar(200) NOT NULL,
  `clients_id_clients` int NOT NULL,
  `taxi_companies_id_taxi_companies` int NOT NULL,
  PRIMARY KEY (`id_reviews`),
  KEY `fk_reviews_clients_idx` (`clients_id_clients`),
  KEY `fk_reviews_taxi_companies1_idx` (`taxi_companies_id_taxi_companies`),
  CONSTRAINT `fk_reviews_clients` FOREIGN KEY (`clients_id_clients`) REFERENCES `clients` (`id_clients`),
  CONSTRAINT `fk_reviews_taxi_companies1` FOREIGN KEY (`taxi_companies_id_taxi_companies`) REFERENCES `taxi_companies` (`id_taxi_companies`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (50,'2022-03-05 22:55:00','Водитель не приехал',30,40),(51,'2022-03-01 21:03:00','Водитель был вежлив',31,41),(52,'2022-02-15 19:21:00','Опоздал на 35 минут',32,42),(53,'2022-01-19 07:23:00','Нагрубил и высадил',33,43),(54,'2022-02-27 20:47:00','Водитель был пьян',34,44),(55,'2022-02-23 14:16:00','Потеряли диван',35,45),(56,'2021-09-03 21:24:00','Отвалилась дверь',36,46),(57,'2021-11-21 09:53:00','Все супер, рекомендую!',37,47),(58,'2021-12-31 23:59:00','Рассказывал анекдоты!',38,48),(59,'2021-10-30 12:30:00','Накурено в салоне! Ужас!',39,49),(60,'2022-02-11 11:21:31','ВСЕ КЛЕВО!',33,40),(61,'2022-02-15 21:52:01','Very GOOD!',33,41);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxi_companies`
--

DROP TABLE IF EXISTS `taxi_companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxi_companies` (
  `id_taxi_companies` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `rating` float NOT NULL,
  PRIMARY KEY (`id_taxi_companies`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxi_companies`
--

LOCK TABLES `taxi_companies` WRITE;
/*!40000 ALTER TABLE `taxi_companies` DISABLE KEYS */;
INSERT INTO `taxi_companies` VALUES (40,'Yandex',4.7),(41,'Uber',4.4),(42,'Vezet',3.9),(43,'Citymobil',4.1),(44,'Saturn',3.2),(45,'Omega',3),(46,'Volt',4.2),(47,'Volga_Bus',3.5),(48,'Doedem_do',2.9),(49,'Uber_Puper',3.3);
/*!40000 ALTER TABLE `taxi_companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxi_drivers`
--

DROP TABLE IF EXISTS `taxi_drivers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxi_drivers` (
  `id_taxi_drivers` int NOT NULL AUTO_INCREMENT,
  `nickname` varchar(45) NOT NULL,
  `driving_experience` tinyint NOT NULL,
  PRIMARY KEY (`id_taxi_drivers`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxi_drivers`
--

LOCK TABLES `taxi_drivers` WRITE;
/*!40000 ALTER TABLE `taxi_drivers` DISABLE KEYS */;
INSERT INTO `taxi_drivers` VALUES (60,'Urat_driver',10),(61,'Mackvin',22),(62,'Puper_Uber',5),(63,'Bog_taxi',7),(64,'Uros_Boros',31),(65,'Gregory',15),(66,'Rus_Indus',8),(67,'_FeDor_Pump',13),(68,'Арарат',23),(69,'I_m_investor',15),(70,'Octavian',9),(71,'TaxiMus',13),(72,'Bogom_dan_Bogdan',7),(73,'DoEdIm_VaX',9);
/*!40000 ALTER TABLE `taxi_drivers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trips`
--

DROP TABLE IF EXISTS `trips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trips` (
  `id_trips` int NOT NULL AUTO_INCREMENT,
  `forms_of_payment_id_forms_of_payment` int NOT NULL,
  `departure_address` varchar(100) NOT NULL,
  `arrival_address` varchar(100) NOT NULL,
  `estimation` tinyint DEFAULT NULL,
  `clients_id_clients` int NOT NULL,
  `order_methods_id_order_methods` int NOT NULL,
  `contracts_id_contracts` int NOT NULL,
  PRIMARY KEY (`id_trips`),
  KEY `fk_trips_forms-of_payment1_idx` (`forms_of_payment_id_forms_of_payment`),
  KEY `fk_trips_clients1_idx` (`clients_id_clients`),
  KEY `fk_trips_order_methods1_idx` (`order_methods_id_order_methods`),
  KEY `fk_trips_contracts1_idx` (`contracts_id_contracts`),
  CONSTRAINT `fk_trips_clients1` FOREIGN KEY (`clients_id_clients`) REFERENCES `clients` (`id_clients`),
  CONSTRAINT `fk_trips_contracts1` FOREIGN KEY (`contracts_id_contracts`) REFERENCES `contracts` (`id_contracts`),
  CONSTRAINT `fk_trips_forms-of_payment1` FOREIGN KEY (`forms_of_payment_id_forms_of_payment`) REFERENCES `forms_of_payment` (`id_forms_of_payment`),
  CONSTRAINT `fk_trips_order_methods1` FOREIGN KEY (`order_methods_id_order_methods`) REFERENCES `order_methods` (`id_order_methods`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trips`
--

LOCK TABLES `trips` WRITE;
/*!40000 ALTER TABLE `trips` DISABLE KEYS */;
INSERT INTO `trips` VALUES (90,20,'ул. Бердянская 11а','ул. Капсовая 24',5,30,10,100),(91,21,'ул. Хользунова 4','ул. Иловая 13',4,31,11,101),(92,22,'ул. Карпатская 7в','пр. Армейский 12в',2,32,12,102),(93,23,'пр. им Ленина 25','ул. Монолитная 2',1,33,12,103),(94,23,'ул. Седых 19б','ул. Свободы 31',3,34,13,104),(95,20,'ул. Тяжелая 23а','ул. Ангараская 4',2,35,10,105),(96,21,'пр. Тараканских 21','ул. Жучиная 1а',4,36,11,106),(97,20,'ул. им Валакаса 12','пр. Гагаринский 2',5,37,13,107),(98,22,'ул. Тарковского 5а','пр. Книжный 4б ',3,38,10,108),(99,21,'ул. Героев 15','пр. Победы 47',5,39,10,109),(100,20,'ул. Хользунова 4','пр. Победы 47',3,35,11,105),(101,21,'ул. Иловая 13 ','ул. Карпатская 7в',1,34,13,102);
/*!40000 ALTER TABLE `trips` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-09 16:29:11
