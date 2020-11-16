package entities;

public class BankAccount {
	private int bankAccountNumber;
	private int customerNumber;
	private String bank;
	private int routingNumber;
	private int accountNumber;
	
	public BankAccount() {
		bankAccountNumber = 0;
		customerNumber = 0;
		bank = "";
		routingNumber = 0;
	}
	
	public BankAccount(int aBankAccountNumber, int aCustomerNumber, String aBank, int aRoutingNumber, int aAccountNumber) {
		bankAccountNumber = aBankAccountNumber;
		customerNumber = aCustomerNumber;
		bank = aBank;
		routingNumber = aRoutingNumber;
		accountNumber = aAccountNumber;
	}
	
	@Override
	public String toString() {
		return "BankAccount [bankAccountNumber=" + bankAccountNumber + ", customerNumber=" + customerNumber + ", bank="
				+ bank + ", routingNumber=" + routingNumber + ", accountNumber=" + accountNumber + 
				"]";
	}

	public int getBankAccountNumber() {
		return bankAccountNumber;
	}

	public void setBankAccountNumber(int bankAccountNumber) {
		this.bankAccountNumber = bankAccountNumber;
	}

	public int getCustomerNumber() {
		return customerNumber;
	}

	public void setCustomerNumber(int customerNumber) {
		this.customerNumber = customerNumber;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public int getRoutingNumber() {
		return routingNumber;
	}

	public void setRoutingNumber(int routingNumber) {
		this.routingNumber = routingNumber;
	}

	public int getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(int accountNumber) {
		this.accountNumber = accountNumber;
	}
}
