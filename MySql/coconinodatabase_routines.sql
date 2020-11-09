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
-- Dumping routines for database 'coconinodatabase'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddProductToCart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddProductToCart`(
	CustomerNumber int
	,ProductNumber int
    ,Quantity int
)
BEGIN
	/* first, check to see if this customer has a cart already */
	SET @ShoppingCartNumber = 0;
	SET @ShoppingCartNumber = (SELECT shoppingCartNumber 
								FROM shoppingcart 
                                WHERE customerNumber = CustomerNumber
                                ORDER BY createdDate desc
                                LIMIT 1);
                                
	/* if the customer doesn't have a cart, create one.
    otherwise, continue */
    IF @ShoppingCartNumber = 0 THEN
		INSERT INTO `coconinodatabase`.`shoppingcart` (customerNumber, createdDate)
		VALUES (CustomerNumber, current_date());
		SET @ShoppingCartNumber = last_insert_id();
	END IF;
    
    /* next, check to see if this product is already in the customer's cart */
    SET @ProductAdded = 0;
	SET @ProductAdded = (SELECT productNumber 
						FROM shoppingcartdetails 
                        WHERE shoppingcartdetails.shoppingCartNumber = @ShoppingCartNumber 
								AND shoppingcartdetails.productNumber = ProductNumber);
                                
	/* if the product isn't in the cart, add a row in shoppingcartdetails
    if the product is in the cart already, add the new quantity to the old quantity in cart */
    IF @ProductAdded IS NULL THEN
		INSERT INTO `coconinodatabase`.`shoppingcartdetails` (shoppingCartNumber, productNumber, quantity)
		VALUES (@ShoppingCartNumber, ProductNumber, Quantity); 
	ELSE
		UPDATE `coconinodatabase`.`shoppingcartdetails`
		SET shoppingcartdetails.quantity = shoppingcartdetails.quantity + Quantity
        WHERE shoppingcartdetails.shoppingCartNumber = @ShoppingCartNumber 
				AND shoppingcartdetails.productNumber = ProductNumber;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Checkout` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Checkout`(
	CustomerNumber int
    ,SelectedBankAccountNumber int
)
sp: BEGIN
	/* find the shopping cart number for this customer */
    SET @ShoppingCartNumber = 0;
	SET @ShoppingCartNumber = (SELECT shoppingCartNumber 
				FROM shoppingcart 
				WHERE customerNumber = CustomerNumber
				ORDER BY createdDate desc
				LIMIT 1);
                
	/* find out how many products are being ordered, this is the number of order lines */
	SET @OrderLines = (SELECT count(shoppingcartdetails.productNumber)
						FROM shoppingcartdetails
						WHERE shoppingcartdetails.shoppingCartNumber = @ShoppingCartNumber
						LIMIT 1);
						
	/* make sure that there is enough product in stock for this order */
    SET @PrevProductNumber = 0;
	SET @Count = 0;
	WHILE @Count < @OrderLines DO
		SET @ProductNumber = 0;
		SET @QuantityOrdered = 0;
		
		/* find the next product in the cart */
		SET @ProductNumber = (SELECT productNumber
							FROM shoppingcartdetails
							WHERE shoppingCartNumber = @ShoppingCartNumber AND shoppingcartdetails.productNumber > @PrevProductNumber
							ORDER BY productNumber
							LIMIT 1);
		
		/* find the quantity of that product in the cart */
		SET @QuantityOrdered = (SELECT quantity
							FROM shoppingcartdetails
							WHERE shoppingCartNumber = @ShoppingCartNumber AND productNumber = @ProductNumber
							ORDER BY productNumber
							LIMIT 1);
		
        /* find the quantity of that product in stock */
		SET @QuantityInStock = (SELECT quantityInStock
								FROM products
								WHERE products.productNumber = @ProductNumber);
		
		/* make sure there is enough of the product in stock 
        If there isn't enough stock, remove the item from cart and leave the procedure*/
		IF (@QuantityInStock < @QuantityOrdered) THEN
			DELETE FROM shoppingcartdetails
            WHERE shoppingCartNumber = @ShoppingCartNumber AND productNumber = @ProductNumber;
            
            SELECT "Not enough inventory for this order. Product has been removed from cart.", @ProductNumber;
            
            LEAVE sp;
		END IF;
		
        SET @PrevProductNumber = @ProductNumber;
		SET @Count = @Count + 1;
	END WHILE;
	
	/* find the sales tax rate */
	SET @SalesTax = 0;
	SET @SalesTax = (SELECT statesalestaxrates.salesTaxRatePercent
					FROM customers
						INNER JOIN statesalestaxrates ON customers.state = statesalestaxrates.state
					WHERE customers.customerNumber = CustomerNumber);

	/* then, calculate the total of the cart including discounts and sales tax */
	SET @Total = 0;
	SET @Total = (SELECT sum(((products.MSRP * shoppingcartdetails.quantity) * (1 - (products.discountPercent / 100))) * (1 + (@SalesTax / 100)))
				FROM shoppingcart
					INNER JOIN shoppingcartdetails ON shoppingcart.shoppingCartNumber = shoppingcartdetails.shoppingCartNumber
					INNER JOIN products ON shoppingcartdetails.productNumber = products.productNumber
				WHERE shoppingcart.shoppingCartNumber = @ShoppingCartNumber
                ORDER BY shoppingcart.createdDate DESC
                LIMIT 1);
                
	/* round the total */
	SET @Total = ROUND(@Total, 2);
	
    /* get the balance of the selected bank account and verify that the account is this customer's account */
	SET @Balance = 0;
	SET @Balance = (SELECT balance
					FROM bankaccounts
					WHERE bankAccountNumber = SelectedBankAccountNumber AND customerNumber = CustomerNumber);
	
    /* if the balance or total is null, something's wrong */
	IF (@Balance IS NULL) THEN
		SELECT "Bank account number is invalid.";
		LEAVE sp;
	END IF;
    
    IF (@Total IS NULL) THEN
		SELECT "Cannot calculate cart's total.";
		LEAVE sp;
	END IF;
	
    /* if the balance is larger than the total, allow the checkout */
    IF(@Balance >= @Total) THEN
		/* create an order and save the order number */
		INSERT INTO orders (customerNumber, orderDate, requiredDate, status)
		VALUES (CustomerNumber, current_date(), date_add(current_date(), INTERVAL 7 DAY), 'processing'); 
        
        SET @OrderNumber = LAST_INSERT_ID();
        
        /* find out how many products were ordered, this is the number of order lines */
        SET @OrderLines = (SELECT count(shoppingcartdetails.productNumber)
							FROM shoppingcartdetails
                            WHERE shoppingcartdetails.shoppingCartNumber = @ShoppingCartNumber
							LIMIT 1);
                            
		/* create an order details row for each product ordered */
		SET @Count = 0;
        WHILE @Count < @OrderLines DO
			SET @ProductNumber = 0;
            SET @QuantityOrdered = 0;
            SET @PriceEach = 0;
            
            /* find the first product in the cart */
            SET @ProductNumber = (SELECT productNumber
								FROM shoppingcartdetails
								WHERE shoppingCartNumber = @ShoppingCartNumber
								ORDER BY productNumber
								LIMIT 1);
            
            /* find the quantity of that product in the cart */
            SET @QuantityOrdered = (SELECT quantity
								FROM shoppingcartdetails
								WHERE shoppingCartNumber = @ShoppingCartNumber AND productNumber = @ProductNumber
								ORDER BY productNumber
								LIMIT 1);
            
            /* calculate the price of each of this product */
            SET @PriceEach = (SELECT products.MSRP * (1 - (products.discountPercent / 100))
								FROM products
                                WHERE productNumber = @ProductNumber
                                LIMIT 1);
			
			/* insert the order details into the orderdetails table */
			INSERT INTO orderdetails (orderNumber, productNumber, orderLineNumber, quantityOrdered, priceEach)
			VALUES (@OrderNumber, @ProductNumber, (@Count + 1), @QuantityOrdered, @PriceEach);
			
			/* remove the ordered products from stock */
			UPDATE products
			SET quantityInStock = quantityInStock - @QuantityOrdered
			WHERE productNumber = @ProductNumber;
		
			/* delete the product from the shopping cart */
			DELETE FROM shoppingcartdetails
			WHERE shoppingCartNumber = @ShoppingCartNumber AND productNumber = @ProductNumber;
            
            SET @Count = @Count + 1;
		END WHILE;
        
        /* subtract the order total from the balance */
        UPDATE bankaccounts
        SET balance = @Balance - @Total
        WHERE bankAccountNumber = SelectedBankAccountNumber AND customerNumber = CustomerNumber;
        
        /* send back the order number and total */
        SELECT @OrderNumber, @Total;
	ELSEIF (@Total > @Balance) THEN
		SELECT "Insufficient Funds";
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateBankAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateBankAccount`(
	customerNumber int
    ,bank VARCHAR(1000)
    ,routingNumber int
    ,accountNumber int
    ,balance decimal(13,2)
)
BEGIN
	INSERT INTO `coconinodatabase`.`bankaccounts` (customerNumber, bank, routingNumber, accountNumber, balance)
	VALUES (customerNumber, bank, routingNumber, accountNumber, balance);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SelectAllProductsFromBrand` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllProductsFromBrand`(
	brandName varchar(100)
)
BEGIN
	SELECT products.*, brands.brandName
	FROM `coconinodatabase`.`products` AS products
	INNER JOIN `coconinodatabase`.`brands` AS brands ON products.vendorNumber = brands.vendorNumber
	WHERE brands.brandName = brandName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SelectAllProductsFromProductLine` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllProductsFromProductLine`(
	ProductLine varchar(100)
)
BEGIN
	SELECT products.*, productlines.productLine
	FROM `coconinodatabase`.`products` AS products
	INNER JOIN `coconinodatabase`.`productlines` AS productlines ON products.productLineNumber = productlines.productLineNumber
	WHERE LOWER(productlines.productLine) = LOWER(ProductLine);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SelectCustomersFrom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectCustomersFrom`(
	City varchar(100)
    ,State varchar(2)
)
BEGIN
	SELECT * FROM coconinodatabase.customers
	WHERE customers.city = City AND customers.state = State;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SelectDistinctCities` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectDistinctCities`()
BEGIN
	SELECT DISTINCT city, state FROM coconinodatabase.customers;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SelectOrdersLastMonth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectOrdersLastMonth`()
BEGIN
	SELECT * FROM `coconinodatabase`.`orders`
	WHERE month(orderDate) = month(date_add(current_date(), INTERVAL -1 MONTH));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SelectPastCustomerOrders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectPastCustomerOrders`(
	/* TimeRange is the length of the time period queried over
    TimeParameter is either day, week, month, or year */
	TimeRange int
    ,TimeParameter varchar(10)
    ,CustomerNumber int
)
BEGIN
	/* search by the choosen parameters, defaults to past 6 months if parameters are null or incorrect */
	IF LOWER(TimeParameter) = 'day' THEN
		SELECT * FROM orders
        WHERE orders.customerNumber = CustomerNumber AND day(orderDate) >= day(date_add(current_date(), INTERVAL -TimeRange DAY));
	ELSEIF LOWER(TimeParameter) = 'year' THEN
		SELECT * FROM orders
        WHERE orders.customerNumber = CustomerNumber AND year(orderDate) >= year(date_add(current_date(), INTERVAL -TimeRange YEAR));
	ELSEIF LOWER(TimeParameter) = 'month' THEN
		SELECT * FROM orders
        WHERE orders.customerNumber = CustomerNumber AND month(orderDate) >= month(date_add(current_date(), INTERVAL -TimeRange MONTH));
	ELSEIF LOWER(TimeParameter) = 'week' THEN
		SELECT * FROM orders
        WHERE orders.customerNumber = CustomerNumber AND week(orderDate) >= week(date_add(current_date(), INTERVAL -TimeRange WEEK));
	ELSE
		SELECT * FROM orders
        WHERE orders.customerNumber = CustomerNumber AND month(orderDate) >= month(date_add(current_date(), INTERVAL -6 MONTH));
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SelectProductsLessThan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectProductsLessThan`(
	Number int
)
BEGIN
	SELECT * FROM coconinodatabase.products
    WHERE products.quantityInStock < Number;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateProductsLessThan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateProductsLessThan`(
	Number int
)
BEGIN
	/* set safe updates to 0 to allow changes to a table without referencing the primary key */
	SET SQL_SAFE_UPDATES = 0;
    
    /* update the table */
	UPDATE coconinodatabase.products
	SET products.quantityInStock = Number
	WHERE products.quantityInStock < Number;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-08 23:57:22
