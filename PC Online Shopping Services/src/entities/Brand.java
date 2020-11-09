package entities;

public class Brand {
	private int vendorNumber;
	private String brandName;
	private String description;
	
	public Brand(int vendorNumber, String brandName, String description) {
		this.vendorNumber = vendorNumber;
		this.brandName = brandName;
		this.description = description;
	}
	
	public Brand() {
		this.vendorNumber = 0;
		this.brandName = "";
		this.description = "";
	}

	@Override
	public String toString() {
		return "Brand [vendorNumber=" + vendorNumber + ", brandName=" + brandName + ", description=" + description
				+ "]";
	}

	public int getVendorNumber() {
		return vendorNumber;
	}

	public void setVendorNumber(int vendorNumber) {
		this.vendorNumber = vendorNumber;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	
}
