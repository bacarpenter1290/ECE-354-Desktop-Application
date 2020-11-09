package entities;

public class BankAccount {
	private int bankAccountNumber;
	private int customerNumber;
	private String bank;
	private int routingNumber;
	private int accountNumber;
	private double balance;
	
	public BankAccount() {
		bankAccountNumber = 0;
		customerNumber = 0;
		bank = "";
		routingNumber = 0;
		accountNumber = 0;
		balance = 0;
	}
	
	public BankAccount(int aBankAccountNumber, int aCustomerNumber, String aBank, int aRoutingNumber, int aAccountNumber, double aBalance) {
		bankAccountNumber = aBankAccountNumber;
		customerNumber = aCustomerNumber;
		bank = aBank;
		routingNumber = aRoutingNumber;
		accountNumber = aAccountNumber;
		balance = aBalance;
	}
	
	public String toString() {
		return "Bank account number " + bankAccountNumber + " held by customer number " + customerNumber + " with a balance of " + balance;
	}
}
