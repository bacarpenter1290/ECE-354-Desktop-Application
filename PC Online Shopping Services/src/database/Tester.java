package database;

public class Tester {	
	
	public static void main(String[] args) {
		
		Database db;
		try {
			db = new Database();
			
			System.out.println(db.getBankAccount(3));
			
			System.out.println(db.isPasswordCorrect(2, "2"));
			
			System.out.println(db.getBrand(1));
			
			System.out.println(db.getAllBrands());
			
			System.out.println(db.getCustomer(3));
			
			System.out.println(db.getAllCustomers());
			
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
