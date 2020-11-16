package entities;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class Order {
	private int orderNumber;
	private int customerNumber;
	private Date orderDate;
	private Date requiredDate;
	private Date shippedDate;
	private String status;
	private String comments;
	private List<OrderDetail> orderDetails = new ArrayList<OrderDetail>();
	
	public Order(int orderNumber, int customerNumber, Date orderDate, Date requiredDate,
			Date shippedDate, String status, String comments) {
		this.orderNumber = orderNumber;
		this.customerNumber = customerNumber;
		this.orderDate = orderDate;
		this.requiredDate = requiredDate;
		this.shippedDate = shippedDate;
		this.status = status;
		this.comments = comments;
	}
	
	public Order(int customerNumber, String comments) {
		this.customerNumber = customerNumber;
		this.comments = comments;
	}
	
	public Order() {
		this.orderNumber = 0;
		this.customerNumber = 0;
		this.orderDate = new Date(0);
		this.requiredDate = new Date(0);
		this.shippedDate = new Date(0);
		this.status = "";
		this.comments = "";
	}
	
	
	@Override
	public String toString() {
		return "Order [orderNumber=" + orderNumber + ", customerNumber=" + customerNumber + ", orderDate=" + orderDate
				+ ", requiredDate=" + requiredDate + ", shippedDate=" + shippedDate + ", status=" + status
				+ ", comments=" + comments + ", orderDetails=" + orderDetails + "]";
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
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public Date getRequiredDate() {
		return requiredDate;
	}
	public void setRequiredDate(Date requiredDate) {
		this.requiredDate = requiredDate;
	}
	public Date getShippedDate() {
		return shippedDate;
	}
	public void setShippedDate(Date shippedDate) {
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
	public List<OrderDetail> getOrderDetails() {
		return orderDetails;
	}
	public void addOrderDetail(OrderDetail orderDetail) {
		orderDetails.add(orderDetail);
	}
	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}
}
