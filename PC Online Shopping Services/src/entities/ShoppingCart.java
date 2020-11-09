package entities;

import java.time.LocalDate;

public class ShoppingCart {
	private int shoppingCartNumber;
	private int customerNumber;
	private LocalDate createdDate;
	
	public ShoppingCart(int shoppingCartNumber, int customerNumber, LocalDate createdDate) {
		this.shoppingCartNumber = shoppingCartNumber;
		this.customerNumber = customerNumber;
		this.createdDate = createdDate;
	}
	
	public ShoppingCart() {
		this.shoppingCartNumber = 0;
		this.customerNumber = 0;
		this.createdDate = LocalDate.MIN;
	}
	
	@Override
	public String toString() {
		return "ShoppingCart [shoppingCartNumber=" + shoppingCartNumber + ", customerNumber=" + customerNumber
				+ ", createdDate=" + createdDate + "]";
	}
	
	public int getShoppingCartNumber() {
		return shoppingCartNumber;
	}
	public void setShoppingCartNumber(int shoppingCartNumber) {
		this.shoppingCartNumber = shoppingCartNumber;
	}
	public int getCustomerNumber() {
		return customerNumber;
	}
	public void setCustomerNumber(int customerNumber) {
		this.customerNumber = customerNumber;
	}
	public LocalDate getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(LocalDate createdDate) {
		this.createdDate = createdDate;
	}
	
}
