package entities;

public class ProductLine {
	private int productLineNumber;
	private String productLine;
	private String description;
	
	public ProductLine(int productLineNumber, String productLine, String description) {
		this.productLineNumber = productLineNumber;
		this.productLine = productLine;
		this.description = description;
	}
	
	public ProductLine() {
		this.productLineNumber = 0;
		this.productLine = "";
		this.description = "";
	}
	
	@Override
	public String toString() {
		return productLine;
	}
	
	public int getProductLineNumber() {
		return productLineNumber;
	}
	public void setProductLineNumber(int productLineNumber) {
		this.productLineNumber = productLineNumber;
	}
	public String getProductLine() {
		return productLine;
	}
	public void setProductLine(String productLine) {
		this.productLine = productLine;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
}
