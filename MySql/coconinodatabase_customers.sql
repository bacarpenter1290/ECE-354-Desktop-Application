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
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customerNumber` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(100) COLLATE utf8_bin NOT NULL,
  `lastName` varchar(100) COLLATE utf8_bin NOT NULL,
  `phoneNumber` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `addressLine1` varchar(100) COLLATE utf8_bin NOT NULL,
  `addressLine2` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `city` varchar(100) COLLATE utf8_bin NOT NULL,
  `state` varchar(45) COLLATE utf8_bin NOT NULL,
  `postalCode` int NOT NULL,
  `country` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`customerNumber`),
  UNIQUE KEY `customerNumber_UNIQUE` (`customerNumber`),
  KEY `customersToStateSalesTaxRates` (`state`),
  CONSTRAINT `customersToStateSalesTaxRates` FOREIGN KEY (`state`) REFERENCES `statesalestaxrates` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (2,'Baylee','Carpenter','1111111111','Test St',NULL,'New Carlisle','IN',46552,'USA'),(3,'Joe','Smith','2222222222','Joes St',NULL,'Valparaiso','IN',46383,'USA'),(4,'Jane','Smith','3333333333','Janes St',NULL,'Hammond','IN',46323,'USA'),(5,'Bob','Frost','4444444444','Bobs St','Apt 123','Hammond','IN',46323,'USA'),(6,'Autumn','Phillips','5555555555','Autumns St',NULL,'New York City','NY',10001,'USA'),(7,'Caitlyn','Jones','6666666666','Caitlyns St',NULL,'Charleston','SC',29401,'USA');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
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
