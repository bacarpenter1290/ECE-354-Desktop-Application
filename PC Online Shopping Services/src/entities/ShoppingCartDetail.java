package entities;

public class ShoppingCartDetail {
	private int shoppingCartNumber;
	private int productNumber;
	private Product product;
	private int quantity;
	
	public ShoppingCartDetail(int shoppingCartNumber, int productNumber, int quantity) {
		this.shoppingCartNumber = shoppingCartNumber;
		this.productNumber = productNumber;
		this.quantity = quantity;
	}
	
	public ShoppingCartDetail() {
		this.shoppingCartNumber = 0;
		this.productNumber = 0;
		this.quantity = 0;
	}
	
	@Override
	public String toString() {
		return "ShoppingCartDetail [shoppingCartNumber=" + shoppingCartNumber + ", productNumber=" + productNumber
				+ ", product=" + product + ", quantity=" + quantity + "]";
	}
	
	public int getShoppingCartNumber() {
		return shoppingCartNumber;
	}
	public void setShoppingCartNumber(int shoppingCartNumber) {
		this.shoppingCartNumber = shoppingCartNumber;
	}
	public int getProductNumber() {
		return productNumber;
	}
	public void setProductNumber(int productNumber) {
		this.productNumber = productNumber;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
}
