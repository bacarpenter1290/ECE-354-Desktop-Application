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
-- Table structure for table `statesalestaxrates`
--

DROP TABLE IF EXISTS `statesalestaxrates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statesalestaxrates` (
  `state` varchar(2) COLLATE utf8_bin NOT NULL,
  `salesTaxRatePercent` double NOT NULL,
  PRIMARY KEY (`state`),
  UNIQUE KEY `state_UNIQUE` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statesalestaxrates`
--

LOCK TABLES `statesalestaxrates` WRITE;
/*!40000 ALTER TABLE `statesalestaxrates` DISABLE KEYS */;
INSERT INTO `statesalestaxrates` VALUES ('AK',1.76),('AL',9.22),('AR',9.47),('AZ',8.4),('CA',8.66),('CO',7.65),('CT',6.35),('DC',6),('DE',0),('FL',7.05),('GA',7.31),('HI',4.44),('IA',6.94),('ID',6.03),('IL',9.08),('IN',46552),('KS',8.68),('KY',6),('LA',9.52),('MA',6.25),('MD',6),('ME',5.5),('MI',6),('MN',7.46),('MO',8.18),('MS',7.07),('MT',0),('NC',6.97),('ND',6.86),('NE',6.93),('NH',0),('NJ',6.6),('NM',7.82),('NV',8.32),('NY',8.52),('OH',7.17),('OK',8.94),('OR',0),('PA',6.34),('RI',7),('SC',7.46),('SD',6.4),('TN',9.53),('TX',8.19),('UT',7.18),('VA',5.65),('VT',6.22),('WA',9.21),('WI',5.46),('WV',6.41),('WY',5.34);
/*!40000 ALTER TABLE `statesalestaxrates` ENABLE KEYS */;
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
