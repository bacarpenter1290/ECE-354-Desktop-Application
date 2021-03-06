package entities;

public class OrderDetail {
	private int orderNumber;
	private int productNumber;
	private Product product = new Product();
	private int orderLineNumber;
	private int quantityOrdered;
	private double priceEach;
	
	public OrderDetail(int orderNumber, int productNumber, int orderLineNumber, int quantityOrdered, double priceEach) {
		this.orderNumber = orderNumber;
		this.productNumber = productNumber;
		this.orderLineNumber = orderLineNumber;
		this.quantityOrdered = quantityOrdered;
		this.priceEach = priceEach;
	}
	
	public OrderDetail() {
		this.orderNumber = 0;
		this.productNumber = 0;
		this.orderLineNumber = 0;
		this.quantityOrdered = 0;
		this.priceEach = 0;
	}
	
	@Override
	public String toString() {
		return "OrderDetail [orderNumber=" + orderNumber + ", productNumber=" + productNumber + ", product=" + product
				+ ", orderLineNumber=" + orderLineNumber + ", quantityOrdered=" + quantityOrdered + ", priceEach="
				+ priceEach + "]";
	}

	public int getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(int orderNumber) {
		this.orderNumber = orderNumber;
	}
	public int getProductNumber() {
		return productNumber;
	}
	public void setProductNumber(int productNumber) {
		this.productNumber = productNumber;
	}
	public int getOrderLineNumber() {
		return orderLineNumber;
	}
	public void setOrderLineNumber(int orderLineNumber) {
		this.orderLineNumber = orderLineNumber;
	}
	public int getQuantityOrdered() {
		return quantityOrdered;
	}
	public void setQuantityOrdered(int quantityOrdered) {
		this.quantityOrdered = quantityOrdered;
	}
	public double getPriceEach() {
		return priceEach;
	}
	public void setPriceEach(double priceEach) {
		this.priceEach = priceEach;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
}
