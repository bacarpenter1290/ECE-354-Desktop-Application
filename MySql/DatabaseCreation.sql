/* 
File Name: DatabaseCreation.sql
Author: Baylee Carpenter
Date: 11/20/2020
Comments:
This sql script will create the database and tables for the coconino online shopping system.
This script will also insert rows into the tables so that the database can be used immediately after executing this.
*/

/* 
	Please note that the tables must be created in the order of this script
	due to the foreign keys between tables 
*/
    
-- -----------------------------------------------------
-- create database 'coconinodatabase'
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS `coconinodatabase`;
USE `coconinodatabase` ;

-- -----------------------------------------------------
-- tables must be dropped in the opposite order they have created due to their foreign keys
-- -----------------------------------------------------
DROP TABLE IF EXISTS shoppingcartdetails;
DROP TABLE IF EXISTS shoppingcart;
DROP TABLE IF EXISTS orderdetails;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS brands;
DROP TABLE IF EXISTS productlines;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS bankaccounts;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS statesalestaxrates;
DROP TABLE IF EXISTS passwords;

-- -----------------------------------------------------
-- Table `coconinodatabase`.`statetaxrates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coconinodatabase`.`stateSalesTaxRates` (
  `state` VARCHAR(2) NOT NULL,
  `salesTaxRatePercent` DOUBLE NOT NULL,
  PRIMARY KEY (`state`),
  UNIQUE INDEX `state_UNIQUE` (`state` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

-- Insert 2020 average state sales tax into statetaxrates table

INSERT INTO `coconinodatabase`.`statesalestaxrates` (`state`, `salesTaxRatePercent`) VALUES 
('AL', '9.22')
,('AK', '1.76')
,('AZ', '8.4')
,('AR', '9.47')
,('CA', '8.66')
,('CO', '7.65')
,('CT', '6.35')
,('DC', '6')
,('DE', '0')
,('FL', '7.05')
,('GA', '7.31')
,('HI', '4.44')
,('ID', '6.03')
,('IL', '9.08')
,('IN', '7.0')
,('IA', '6.94')
,('KS', '8.68')
,('KY', '6')
,('LA', '9.52')
,('ME', '5.5')
,('MA', '6.25')
,('MD', '6')
,('MI', '6')
,('MN', '7.46')
,('MS', '7.07')
,('MO', '8.18')
,('MT', '0')
,('NC', '6.97')
,('ND', '6.86')
,('NH', '0')
,('NJ', '6.6')
,('NM', '7.82')
,('NY', '8.52')
,('NE', '6.93')
,('NV', '8.32')
,('OH', '7.17')
,('OK', '8.94')
,('OR', '0')
,('PA', '6.34')
,('RI', '7')
,('SC', '7.46')
,('SD', '6.4')
,('TN', '9.53')
,('TX', '8.19')
,('UT', '7.18')
,('VA', '5.65')
,('VT', '6.22')
,('WV', '6.41')
,('WA', '9.21')
,('WI', '5.46')
,('WY', '5.34');

-- -----------------------------------------------------
-- Table `coconinodatabase`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coconinodatabase`.`customers` (
  `customerNumber` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(100) NOT NULL,
  `lastName` VARCHAR(100) NOT NULL,
  `phoneNumber` VARCHAR(15) NULL,
  `addressLine1` VARCHAR(100) NOT NULL,
  `addressLine2` VARCHAR(100) NULL DEFAULT NULL,
  `city` VARCHAR(100) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `postalCode` INT NOT NULL,
  `country` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`customerNumber`),
  UNIQUE INDEX `customerNumber_UNIQUE` (`customerNumber` ASC) VISIBLE,
  CONSTRAINT `customersToStateSalesTaxRates`
    FOREIGN KEY (`state`)
    REFERENCES `coconinodatabase`.`stateSalesTaxRates` (`state`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

-- insert customers into customers table

INSERT INTO `customers` 
VALUES (2,'Baylee','Carpenter','1111111111','Test St',NULL,'New Carlisle','IN',46552,'USA')
,(3,'Joe','Smith','2222222222','Joes St',NULL,'Valparaiso','IN',46383,'USA')
,(4,'Jane','Smith','3333333333','Janes St',NULL,'Hammond','IN',46323,'USA')
,(5,'Bob','Frost','4444444444','Bobs St','Apt 123','Hammond','IN',46323,'USA')
,(6,'Autumn','Phillips','5555555555','Autumns St',NULL,'New York City','NY',10001,'USA')
,(7,'Caitlyn','Jones','6666666666','Caitlyns St',NULL,'Charleston','SC',29401,'USA');



-- -----------------------------------------------------
-- Table `coconinodatabase`.`passwords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coconinodatabase`.`passwords` (
  `customerNumber` INT NOT NULL,
  `password` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`customerNumber`),
  INDEX `passwords_idx` (`customerNumber` ASC) VISIBLE,
  CONSTRAINT `passwordsToCustomers`
    FOREIGN KEY (`customerNumber`)
    REFERENCES `coconinodatabase`.`customers` (`customerNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
  )
ENGINE = InnoDB;

-- the default passwords are the same as the customer number
INSERT INTO `passwords` 
VALUES (2,SHA1('2'))
,(3,SHA1('3'))
,(4,SHA1('4'))
,(5,SHA1('5'))
,(6,SHA1('6'))
,(7,SHA1('7'));

-- -----------------------------------------------------
-- Table `coconinodatabase`.`bankaccounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coconinodatabase`.`bankAccounts` (
  `bankAccountNumber` INT NOT NULL AUTO_INCREMENT,
  `customerNumber` INT NOT NULL,
  `bank` VARCHAR(1000) NOT NULL,
  `routingNumber` INT NOT NULL,
  `accountNumber` INT NOT NULL,
  `balance` DECIMAL(13,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`bankAccountNumber`),
  UNIQUE INDEX `BankAccountNumber_UNIQUE` (`bankAccountNumber` ASC) INVISIBLE,
  INDEX `bankAccountsToCustomers_idx` (`customerNumber` ASC) VISIBLE,
  CONSTRAINT `bankAccountsToCustomers`
    FOREIGN KEY (`customerNumber`)
    REFERENCES `coconinodatabase`.`customers` (`customerNumber`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

-- insert bank accounts into bankaccounts table

INSERT INTO `bankaccounts` VALUES (3,7,'Bank 1',1111111,1111111,1000.00)
,(4,2,'Bank 2',2222222,2222222,100.00)
,(5,3,'Bank 3',3333333,3333333,10.00)
,(6,4,'Bank 4',4444444,4444444,0.00)
,(7,5,'Bank 5',5555555,5555555,50.00)
,(8,6,'Bank 5',6666666,6666666,15.00)
,(9,7,'Bank of America',123456789,123456789,2500.00)
,(10,7,'Bank of America',123456789,123456789,2833.60)
,(11,7,'Bank of America',123456789,123456789,357.73);

-- -----------------------------------------------------
-- Table `coconinodatabase`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coconinodatabase`.`orders` (
  `orderNumber` INT NOT NULL AUTO_INCREMENT,
  `customerNumber` INT NOT NULL,
  `orderDate` DATE NOT NULL,
  `requiredDate` DATE NOT NULL,
  `shippedDate` DATE NULL DEFAULT NULL,
  `status` VARCHAR(100) NOT NULL,
  `comments` VARCHAR(2500) NULL DEFAULT NULL,
  PRIMARY KEY (`orderNumber`),
  UNIQUE INDEX `orderNumber_UNIQUE` (`orderNumber` ASC) VISIBLE,
  INDEX `ordersToCustomer_idx` (`customerNumber` ASC) VISIBLE,
  CONSTRAINT `ordersToCustomers`
    FOREIGN KEY (`customerNumber`)
    REFERENCES `coconinodatabase`.`customers` (`customerNumber`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

-- insert orders into orders table

INSERT INTO `orders` VALUES (2,7,'2020-09-18','2020-09-25',NULL,'Preparing',NULL)
,(3,2,'2020-08-18','2020-08-25','2020-08-23','Completed',NULL)
,(4,3,'2020-07-18','2020-07-25','2020-07-23','Completed',NULL)
,(5,4,'2020-09-10','2020-09-20','2020-09-18','Shipped',NULL)
,(6,5,'2020-01-18','2020-01-25','2020-01-23','Completed',NULL)
,(7,6,'2019-12-18','2019-12-25','2019-12-23','Completed',NULL)
,(8,7,'2020-09-25','2020-10-02',NULL,'processing',NULL)
,(9,7,'2020-09-25','2020-10-02',NULL,'processing',NULL)
,(10,7,'2020-09-25','2020-10-02',NULL,'processing',NULL)
,(11,7,'2020-09-25','2020-10-02',NULL,'processing',NULL)
,(12,7,'2020-09-25','2020-10-02',NULL,'processing',NULL)
,(13,7,'2020-09-25','2020-10-02',NULL,'processing',NULL)
,(14,7,'2020-09-26','2020-10-03',NULL,'processing',NULL)
,(15,7,'2020-09-26','2020-10-03',NULL,'processing',NULL)
,(16,7,'2020-09-26','2020-10-03',NULL,'processing',NULL)
,(17,7,'2020-09-26','2020-10-03',NULL,'processing',NULL)
,(18,7,'2020-09-26','2020-10-03',NULL,'processing',NULL)
,(19,7,'2020-09-26','2020-10-03',NULL,'processing',NULL);

-- -----------------------------------------------------
-- Table `coconinodatabase`.`productLines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coconinodatabase`.`productLines` (
  `productLineNumber` INT NOT NULL AUTO_INCREMENT,
  `productLine` VARCHAR(100) NOT NULL,
  `description` VARCHAR(2500) NOT NULL,
  PRIMARY KEY (`productLineNumber`),
  UNIQUE INDEX `productLineNumber_UNIQUE` (`productLineNumber` ASC) VISIBLE)
ENGINE = InnoDB;

-- insert product lines into table

INSERT INTO `productlines` VALUES (1,'Beauty','Beauty products for everyone')
,(2,'Electronics','Electronics that last')
,(3,'Furniture','High Quality Furniture')
,(4,'Home','Goods to make a place your home')
,(5,'Clothing','Best clothing you can find');
-- -----------------------------------------------------
-- Table `coconinodatabase`.`brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coconinodatabase`.`brands` (
  `vendorNumber` INT NOT NULL AUTO_INCREMENT,
  `brandName` VARCHAR(100) NOT NULL,
  `description` VARCHAR(2500) NOT NULL,
  PRIMARY KEY (`vendorNumber`),
  UNIQUE INDEX `vendorNumber_UNIQUE` (`vendorNumber` ASC) VISIBLE)
ENGINE = InnoDB;

-- insert brands into table

INSERT INTO `brands` VALUES (1,'OLay','beauty brand')
,(2,'DKNY','beauty and clothing brand')
,(3,'LG','Electronic brand')
,(4,'GE','Electronic brand')
,(5,'Liberty Furniture','Furniture Brand')
,(6,'Lexington','Furniture Brand')
,(7,'Ikea','Furniture and home brand')
,(8,'H&M','Clothing brand');

-- -----------------------------------------------------
-- Table `coconinodatabase`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coconinodatabase`.`products` (
  `productNumber` INT NOT NULL AUTO_INCREMENT,
  `productName` VARCHAR(1000) NOT NULL,
  `vendorNumber` INT NOT NULL,
  `productLineNumber` INT NOT NULL,
  `productDescription` VARCHAR(2500) NOT NULL,
  `quantityInStock` INT NOT NULL DEFAULT '0',
  `MSRP` DECIMAL(13,2) NOT NULL,
  `discountPercent` DOUBLE NOT NULL DEFAULT '0',
  PRIMARY KEY (`productNumber`),
  UNIQUE INDEX `productNumber_UNIQUE` (`productNumber` ASC) VISIBLE,
  INDEX `productsToProductLines_idx` (`productLineNumber` ASC) VISIBLE,
  INDEX `productsToBrands_idx` (`vendorNumber` ASC) VISIBLE,
  CONSTRAINT `productsToProductLines`
    FOREIGN KEY (`productLineNumber`)
    REFERENCES `coconinodatabase`.`productLines` (`productLineNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `productsToBrands`
    FOREIGN KEY (`vendorNumber`)
    REFERENCES `coconinodatabase`.`brands` (`vendorNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

-- insert products into table

INSERT INTO `products` VALUES (1,'40\" TV',3,2,'40\" HDTV',498,200.00,0)
,(2,'50\" TV',3,2,'50\" 4K TV',499,500.00,5)
,(3,'50\" TV',4,2,'50\" HDTV',999,400.00,1)
,(4,'Red Shirt',8,5,'Nice Red T-Shirt',9999,10.00,0)
,(5,'Blue Shirt',8,5,'Nice Blue T-Shirt',499,15.00,0)
,(6,'Eyeliner',1,1,'Great eyeliner',1000,20.00,5)
,(7,'Makeup Brush Set',1,1,'Set of brushes',50,40.00,0)
,(8,'Sofa',5,3,'Black 3-seat sofa',5,600.00,5)
,(9,'Recliner',7,3,'Gray recliner',2,350.00,2)
,(10,'Lamp',7,4,'Decorative Lamp',92,65.00,0)
,(11,'Skeleton Decoration',7,4,'Decoration for Halloween',1000,10.00,0)
,(12,'Dress Shirt',2,5,'Nice shirt',1000,50.00,10)
,(13,'Lawn Chair',6,3,'Lawn chair for outdoor use',50,30.00,0);

-- -----------------------------------------------------
-- Table `coconinodatabase`.`orderdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coconinodatabase`.`orderDetails` (
  `orderNumber` INT NOT NULL,
  `productNumber` INT NOT NULL,
  `orderLineNumber` INT NOT NULL,
  `quantityOrdered` INT NOT NULL,
  `priceEach` DECIMAL(13,2) NOT NULL,
  PRIMARY KEY (`orderNumber`, `productNumber`),
  INDEX `orderDetailsToProdcuts_idx` (`productNumber` ASC) VISIBLE,
  CONSTRAINT `orderDetailsToOrders`
    FOREIGN KEY (`orderNumber`)
    REFERENCES `coconinodatabase`.`orders` (`orderNumber`),
  CONSTRAINT `orderDetailsToProdcuts`
    FOREIGN KEY (`productNumber`)
    REFERENCES `coconinodatabase`.`products` (`productNumber`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

-- insert order details into table

INSERT INTO `orderdetails` VALUES (2,1,1,1,200.00)
,(3,4,1,1,10.00),(4,7,1,1,40.00)
,(5,10,1,1,65.00),(6,11,1,1,10.00)
,(7,1,1,2,200.00),(8,4,1,10,10.00)
,(9,4,1,15,10.00),(10,1,0,4,200.00)
,(10,2,1,3,475.00),(10,3,2,5,396.00)
,(10,4,3,4,10.00),(10,5,4,5,15.00)
,(11,1,1,1,200.00),(11,2,2,1,475.00)
,(11,3,3,1,396.00),(11,4,4,1,10.00)
,(11,5,5,1,15.00),(12,1,1,1,200.00)
,(12,2,2,1,475.00),(12,3,3,1,396.00)
,(12,4,4,1,10.00),(12,5,5,1,15.00)
,(13,1,1,1,200.00),(13,2,2,1,475.00)
,(13,3,3,1,396.00),(13,4,4,1,10.00)
,(13,5,5,1,15.00),(14,1,1,1,200.00)
,(14,2,2,1,475.00),(14,3,3,1,396.00)
,(14,4,4,1,10.00),(14,5,5,1,15.00)
,(15,10,1,1,65.00),(16,10,1,2,65.00)
,(17,10,1,3,65.00),(18,10,1,2,65.00)
,(19,1,1,2,200.00);

-- -----------------------------------------------------
-- Table `coconinodatabase`.`shoppingCart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coconinodatabase`.`shoppingCart` (
  `shoppingCartNumber` INT NOT NULL AUTO_INCREMENT,
  `customerNumber` INT NOT NULL,
  `createdDate` DATE NOT NULL,
  PRIMARY KEY (`shoppingCartNumber`),
  UNIQUE INDEX `shoppingCartNumber_UNIQUE` (`shoppingCartNumber` ASC) VISIBLE,
  INDEX `shoppingCartToCustomers_idx` (`customerNumber` ASC) VISIBLE,
  CONSTRAINT `shoppingCartToCustomers`
    FOREIGN KEY (`customerNumber`)
    REFERENCES `coconinodatabase`.`customers` (`customerNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- insert shopping carts into the table
-- this table doesn't include every customer because carts will be created automatically when customers add products to their cart
INSERT INTO `shoppingcart` VALUES (1,7,'2020-09-19'),(3,2,'2020-09-19');

-- -----------------------------------------------------
-- Table `coconinodatabase`.`shoppingCartDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coconinodatabase`.`shoppingCartDetails` (
  `shoppingCartNumber` INT NOT NULL,
  `productNumber` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`shoppingCartNumber`, `productNumber`),
  INDEX `shoppingCartDetailsToProducts_idx` (`productNumber` ASC) VISIBLE,
  CONSTRAINT `shoppingCartDetailsToShoppingCart`
    FOREIGN KEY (`shoppingCartNumber`)
    REFERENCES `coconinodatabase`.`shoppingCart` (`shoppingCartNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `shoppingCartDetailsToProducts`
    FOREIGN KEY (`productNumber`)
    REFERENCES `coconinodatabase`.`products` (`productNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- no insert, no active carts
