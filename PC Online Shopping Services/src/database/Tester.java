package database;

import entities.*;
import services.CustomException;

public class Tester {	
	
	public static void main(String[] args) {
		
		Database db;
		try {
			db = new Database();
			
			BankAccount newBank = new BankAccount(0, 2, "New Bank", 132, 179);
			newBank = db.createBankAccount(newBank);
			System.out.println(db.getBankAccount(newBank.getBankAccountNumber()));
			
			Customer newCustomer = new Customer(0, "Test", "Smith", "451351541", "123 Test St", "", "Hammond", "IN", 46383, "USA");
			newCustomer = db.createCustomer(newCustomer, "Test");
			System.out.println(db.getCustomer(newCustomer.getCustomerNumber()));
			
			OrderDetail detail1 = new OrderDetail(0, 1, 0, 2, 0);
			OrderDetail detail2 = new OrderDetail(0, 6, 0, 1, 0);
			Order newOrder = new Order(7, "");
			newOrder.addOrderDetail(detail1);
			newOrder.addOrderDetail(detail2);
			newOrder = db.createOrder(newOrder);
			System.out.println(db.getOrder(newOrder.getOrderNumber()));
			
			BankAccount bank1 = db.getBankAccount(3);
			System.out.println(bank1);
			bank1.setAccountNumber(1234567);
			db.updateBankAccount(bank1);
			System.out.println(db.getBankAccount(3));
			
			System.out.println(db.isPasswordCorrect(2, "2"));
			
			System.out.println(db.getBrand(1));
			
			Brand aBrand = db.getBrand(1);
			aBrand.setDescription("Test update");
			db.updateBrand(aBrand);
			System.out.println(db.getBrand(1));
			
			System.out.println(db.getAllBrands());
			
			Customer customer1 = db.getCustomer(3);
			System.out.println(db.getCustomer(3));
			customer1.setAddressLine2("Apt Test");
			db.updateCustomer(customer1);
			System.out.println(db.getCustomer(3));
			
			System.out.println(db.getAllCustomers());
			
			Order order1 = db.getOrder(5);
			System.out.println(db.getOrder(5));
			order1.setComments("Test");
			db.updateOrder(order1);
			System.out.println(db.getOrder(5));
			
			System.out.println(db.getAllCustomerOrders(7));
			
			System.out.println(db.getProductLines());
			
			System.out.println(db.getAllProducts());
			
			System.out.println(db.getAllProductsFromBrand(1));
			
			System.out.println(db.getAllProductsInLine(3));
			
			System.out.println(db.getAllBrands());
			
			System.out.println(db.getShoppingCart(7));
			
			db.close();
			
		} catch (CustomException e) {
			e.printStackTrace();
		}
	}

}
