package entities;

import java.time.LocalDate;

public class Order {
	private int orderNumber;
	private int customerNumber;
	private LocalDate orderDate;
	private LocalDate requiredDate;
	private LocalDate shippedDate;
	private String status;
	private String comments;
	
	public Order(int orderNumber, int customerNumber, LocalDate orderDate, LocalDate requiredDate,
			LocalDate shippedDate, String status, String comments) {
		this.orderNumber = orderNumber;
		this.customerNumber = customerNumber;
		this.orderDate = orderDate;
		this.requiredDate = requiredDate;
		this.shippedDate = shippedDate;
		this.status = status;
		this.comments = comments;
	}
	
	public Order() {
		this.orderNumber = 0;
		this.customerNumber = 0;
		this.orderDate = LocalDate.MIN;
		this.requiredDate = LocalDate.MIN;
		this.shippedDate = LocalDate.MIN;
		this.status = "";
		this.comments = "";
	}
	
	@Override
	public String toString() {
		return "Order [orderNumber=" + orderNumber + ", customerNumber=" + customerNumber + ", orderDate=" + orderDate
				+ ", requiredDate=" + requiredDate + ", shippedDate=" + shippedDate + ", status=" + status
				+ ", comments=" + comments + "]";
	}
	
	public int getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(int orderNumber) {
		this.orderNumber = orderNumber;
	}
	public int getCustomerNumber() {
		return customerNumber;
	}
	public void setCustomerNumber(int customerNumber) {
		this.customerNumber = customerNumber;
	}
	public LocalDate getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(LocalDate orderDate) {
		this.orderDate = orderDate;
	}
	public LocalDate getRequiredDate() {
		return requiredDate;
	}
	public void setRequiredDate(LocalDate requiredDate) {
		this.requiredDate = requiredDate;
	}
	public LocalDate getShippedDate() {
		return shippedDate;
	}
	public void setShippedDate(LocalDate shippedDate) {
		this.shippedDate = shippedDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	
}
