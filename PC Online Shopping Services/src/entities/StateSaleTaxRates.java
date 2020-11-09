package entities;

public class StateSaleTaxRates {
	private String state;
	private double salesTaxRatePercent;
	
	public StateSaleTaxRates(String state, double salesTaxRatePercent) {
		this.state = state;
		this.salesTaxRatePercent = salesTaxRatePercent;
	}
	
	public StateSaleTaxRates() {
		this.state = "";
		this.salesTaxRatePercent = 0;
	}
	
	@Override
	public String toString() {
		return "StateSaleTaxRates [state=" + state + ", salesTaxRatePercent=" + salesTaxRatePercent + "]";
	}
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public double getSalesTaxRatePercent() {
		return salesTaxRatePercent;
	}
	public void setSalesTaxRatePercent(double salesTaxRatePercent) {
		this.salesTaxRatePercent = salesTaxRatePercent;
	}
	
	
}
