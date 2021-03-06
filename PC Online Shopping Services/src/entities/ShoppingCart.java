package entities;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class ShoppingCart {
	private int shoppingCartNumber;
	private int customerNumber;
	private Date createdDate;
	private List<ShoppingCartDetail> shoppingCartDetails = new ArrayList<ShoppingCartDetail>();
	
	public ShoppingCart(int shoppingCartNumber, int customerNumber, Date createdDate) {
		this.shoppingCartNumber = shoppingCartNumber;
		this.customerNumber = customerNumber;
		this.createdDate = createdDate;
	}
	
	public ShoppingCart() {
		this.shoppingCartNumber = 0;
		this.customerNumber = 0;
		this.createdDate = new Date(0);
	}
	
	@Override
	public String toString() {
		return "ShoppingCart [shoppingCartNumber=" + shoppingCartNumber + ", customerNumber=" + customerNumber
				+ ", createdDate=" + createdDate + ", shoppingCartDetails=" + shoppingCartDetails + "]";
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
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public List<ShoppingCartDetail> getShoppingCartDetails() {
		return shoppingCartDetails;
	}
	public void setShoppingCartDetails(List<ShoppingCartDetail> shoppingCartDetails) {
		this.shoppingCartDetails = shoppingCartDetails;
	}
}
