-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: coconinodatabase
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `orderNumber` int NOT NULL AUTO_INCREMENT,
  `customerNumber` int NOT NULL,
  `orderDate` date NOT NULL,
  `requiredDate` date NOT NULL,
  `shippedDate` date DEFAULT NULL,
  `status` varchar(100) COLLATE utf8_bin NOT NULL,
  `comments` varchar(2500) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`orderNumber`),
  UNIQUE KEY `orderNumber_UNIQUE` (`orderNumber`),
  KEY `ordersToCustomer_idx` (`customerNumber`),
  CONSTRAINT `ordersToCustomers` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (2,7,'2020-09-18','2020-09-25',NULL,'Preparing',NULL),(3,2,'2020-08-18','2020-08-25','2020-08-23','Completed',NULL),(4,3,'2020-07-18','2020-07-25','2020-07-23','Completed',NULL),(5,4,'2020-09-10','2020-09-20','2020-09-18','Shipped',NULL),(6,5,'2020-01-18','2020-01-25','2020-01-23','Completed',NULL),(7,6,'2019-12-18','2019-12-25','2019-12-23','Completed',NULL),(8,7,'2020-09-25','2020-10-02',NULL,'processing',NULL),(9,7,'2020-09-25','2020-10-02',NULL,'processing',NULL),(10,7,'2020-09-25','2020-10-02',NULL,'processing',NULL),(11,7,'2020-09-25','2020-10-02',NULL,'processing',NULL),(12,7,'2020-09-25','2020-10-02',NULL,'processing',NULL),(13,7,'2020-09-25','2020-10-02',NULL,'processing',NULL),(14,7,'2020-09-26','2020-10-03',NULL,'processing',NULL),(15,7,'2020-09-26','2020-10-03',NULL,'processing',NULL),(16,7,'2020-09-26','2020-10-03',NULL,'processing',NULL),(17,7,'2020-09-26','2020-10-03',NULL,'processing',NULL),(18,7,'2020-09-26','2020-10-03',NULL,'processing',NULL),(19,7,'2020-09-26','2020-10-03',NULL,'processing',NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-08 23:57:22
