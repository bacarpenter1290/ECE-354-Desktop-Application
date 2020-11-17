package services;

import database.Database;
import entities.Customer;

public class OnlineShoppingService {
	public Database db;
	private Customer currentCustomer;
	private double salesTaxRate;
	
	public OnlineShoppingService() throws CustomException {
		try {
			db = new Database();
		}
		catch (CustomException e) {
			throw e;
		}
		currentCustomer = new Customer();
	}
	
	public void setCurrentCustomer(Customer customer) {
		currentCustomer = customer;
		salesTaxRate = db.getSalesTax(customer.getState());
	}
	
	public Customer getCurrentCustomer() {
		return currentCustomer;
	}

	public double getSalesTaxRate() {
		return salesTaxRate;
	}

	public void setSalesTaxRate(double salesTaxRate) {
		this.salesTaxRate = salesTaxRate;
	}
}
