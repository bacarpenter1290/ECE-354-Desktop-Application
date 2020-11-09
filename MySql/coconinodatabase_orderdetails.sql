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
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetails` (
  `orderNumber` int NOT NULL,
  `productNumber` int NOT NULL,
  `orderLineNumber` int NOT NULL,
  `quantityOrdered` int NOT NULL,
  `priceEach` decimal(13,2) NOT NULL,
  PRIMARY KEY (`orderNumber`,`productNumber`),
  KEY `orderDetailsToProdcuts_idx` (`productNumber`),
  CONSTRAINT `orderDetailsToOrders` FOREIGN KEY (`orderNumber`) REFERENCES `orders` (`orderNumber`),
  CONSTRAINT `orderDetailsToProdcuts` FOREIGN KEY (`productNumber`) REFERENCES `products` (`productNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (2,1,1,1,200.00),(3,4,1,1,10.00),(4,7,1,1,40.00),(5,10,1,1,65.00),(6,11,1,1,10.00),(7,1,1,2,200.00),(8,4,1,10,10.00),(9,4,1,15,10.00),(10,1,0,4,200.00),(10,2,1,3,475.00),(10,3,2,5,396.00),(10,4,3,4,10.00),(10,5,4,5,15.00),(11,1,1,1,200.00),(11,2,2,1,475.00),(11,3,3,1,396.00),(11,4,4,1,10.00),(11,5,5,1,15.00),(12,1,1,1,200.00),(12,2,2,1,475.00),(12,3,3,1,396.00),(12,4,4,1,10.00),(12,5,5,1,15.00),(13,1,1,1,200.00),(13,2,2,1,475.00),(13,3,3,1,396.00),(13,4,4,1,10.00),(13,5,5,1,15.00),(14,1,1,1,200.00),(14,2,2,1,475.00),(14,3,3,1,396.00),(14,4,4,1,10.00),(14,5,5,1,15.00),(15,10,1,1,65.00),(16,10,1,2,65.00),(17,10,1,3,65.00),(18,10,1,2,65.00),(19,1,1,2,200.00);
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
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
