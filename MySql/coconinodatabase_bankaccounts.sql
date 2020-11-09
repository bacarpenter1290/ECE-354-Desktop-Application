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
-- Table structure for table `bankaccounts`
--

DROP TABLE IF EXISTS `bankaccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bankaccounts` (
  `bankAccountNumber` int NOT NULL AUTO_INCREMENT,
  `customerNumber` int NOT NULL,
  `bank` varchar(1000) COLLATE utf8_bin NOT NULL,
  `routingNumber` int NOT NULL,
  `accountNumber` int NOT NULL,
  `balance` decimal(13,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`bankAccountNumber`),
  UNIQUE KEY `BankAccountNumber_UNIQUE` (`bankAccountNumber`) /*!80000 INVISIBLE */,
  KEY `bankAccountsToCustomers_idx` (`customerNumber`),
  CONSTRAINT `bankAccountsToCustomers` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bankaccounts`
--

LOCK TABLES `bankaccounts` WRITE;
/*!40000 ALTER TABLE `bankaccounts` DISABLE KEYS */;
INSERT INTO `bankaccounts` VALUES (3,7,'Bank 1',1111111,1111111,1000.00),(4,2,'Bank 2',2222222,2222222,100.00),(5,3,'Bank 3',3333333,3333333,10.00),(6,4,'Bank 4',4444444,4444444,0.00),(7,5,'Bank 5',5555555,5555555,50.00),(8,6,'Bank 5',6666666,6666666,15.00),(9,7,'Bank of America',123456789,123456789,2500.00),(10,7,'Bank of America',123456789,123456789,2833.60),(11,7,'Bank of America',123456789,123456789,357.73);
/*!40000 ALTER TABLE `bankaccounts` ENABLE KEYS */;
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
