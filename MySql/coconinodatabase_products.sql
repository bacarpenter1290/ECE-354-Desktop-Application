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
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `productNumber` int NOT NULL AUTO_INCREMENT,
  `productName` varchar(1000) COLLATE utf8_bin NOT NULL,
  `vendorNumber` int NOT NULL,
  `productLineNumber` int NOT NULL,
  `productDescription` varchar(2500) COLLATE utf8_bin NOT NULL,
  `quantityInStock` int NOT NULL DEFAULT '0',
  `MSRP` decimal(13,2) NOT NULL,
  `discountPercent` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`productNumber`),
  UNIQUE KEY `productNumber_UNIQUE` (`productNumber`),
  KEY `productsToProductLines_idx` (`productLineNumber`),
  KEY `productsToBrands_idx` (`vendorNumber`),
  CONSTRAINT `productsToBrands` FOREIGN KEY (`vendorNumber`) REFERENCES `brands` (`vendorNumber`),
  CONSTRAINT `productsToProductLines` FOREIGN KEY (`productLineNumber`) REFERENCES `productlines` (`productLineNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'40\" TV',3,2,'40\" HDTV',498,200.00,0),(2,'50\" TV',3,2,'50\" 4K TV',499,500.00,5),(3,'50\" TV',4,2,'50\" HDTV',999,400.00,1),(4,'Red Shirt',8,5,'Nice Red T-Shirt',9999,10.00,0),(5,'Blue Shirt',8,5,'Nice Blue T-Shirt',499,15.00,0),(6,'Eyeliner',1,1,'Great eyeliner',1000,20.00,5),(7,'Makeup Brush Set',1,1,'Set of brushes',50,40.00,0),(8,'Sofa',5,3,'Black 3-seat sofa',5,600.00,5),(9,'Recliner',7,3,'Gray recliner',2,350.00,2),(10,'Lamp',7,4,'Decorative Lamp',92,65.00,0),(11,'Skeleton Decoration',7,4,'Decoration for Halloween',1000,10.00,0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
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
