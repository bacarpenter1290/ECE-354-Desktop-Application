package entities;

public class Product {
	private int productNumber;
	private String productName;
	private int vendorNumber;
	private int productLineNumber;
	private String productDescription;
	private int quantityInStock;
	private double MRSP;
	private double discountPercent;
	
	public Product(int productNumber, String productName, int vendorNumber, int productLineNumber,
			String productDescription, int quantityInStock, double mRSP, double discountPercent) {
		this.productNumber = productNumber;
		this.productName = productName;
		this.vendorNumber = vendorNumber;
		this.productLineNumber = productLineNumber;
		this.productDescription = productDescription;
		this.quantityInStock = quantityInStock;
		MRSP = mRSP;
		this.discountPercent = discountPercent;
	}
	
	public Product() {
		this.productNumber = 0;
		this.productName = "";
		this.vendorNumber = 0;
		this.productLineNumber = 0;
		this.productDescription = "";
		this.quantityInStock = 0;
		MRSP = 0;
		this.discountPercent = 0;
	}
	
	@Override
	public String toString() {
		return "Product [productNumber=" + productNumber + ", productName=" + productName + ", vendorNumber="
				+ vendorNumber + ", productLineNumber=" + productLineNumber + ", productDescription="
				+ productDescription + ", quantityInStock=" + quantityInStock + ", MRSP=" + MRSP + ", discountPercent="
				+ discountPercent + "]";
	}
	
	public int getProductNumber() {
		return productNumber;
	}
	public void setProductNumber(int productNumber) {
		this.productNumber = productNumber;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getVendorNumber() {
		return vendorNumber;
	}
	public void setVendorNumber(int vendorNumber) {
		this.vendorNumber = vendorNumber;
	}
	public int getProductLineNumber() {
		return productLineNumber;
	}
	public void setProductLineNumber(int productLineNumber) {
		this.productLineNumber = productLineNumber;
	}
	public String getProductDescription() {
		return productDescription;
	}
	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}
	public int getQuantityInStock() {
		return quantityInStock;
	}
	public void setQuantityInStock(int quantityInStock) {
		this.quantityInStock = quantityInStock;
	}
	public double getMRSP() {
		return MRSP;
	}
	public void setMRSP(double mRSP) {
		MRSP = mRSP;
	}
	public double getDiscountPercent() {
		return discountPercent;
	}
	public void setDiscountPercent(double discountPercent) {
		this.discountPercent = discountPercent;
	}
	
	
}
