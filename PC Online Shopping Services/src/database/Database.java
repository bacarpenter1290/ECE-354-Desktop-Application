package database;

import java.sql.*;
import entities.*;

public class Database {
	
	private final String dBSchema = "coconinodatabase";
	private final String dBUser = "OnlineShoppingApp";
	private final String dBPass = "eSGDm43ZU6bGz9w";
	
	private Connection conn;
	
	public Database() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/" + dBSchema, dBUser, dBPass);
		}
		catch(Exception e){ 
			System.out.println("Error when connecting to databse: " + e);
		}  
	}
	
	public BankAccount getBankAccount(int pk) {
		int bankAccountNumber = 0;
		int customerNumber = 0;
		String bank = "";
		int routingNumber = 0;
		int accountNumber = 0;
		double balance = 0;
		
		BankAccount aBankAccount;	
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select * from bankaccounts where bankAccountNumber = " + pk);
			while(rs.next()) {
				bankAccountNumber = rs.getInt(1);
				customerNumber = rs.getInt(2);
				bank = rs.getString(3);
				routingNumber = rs.getInt(4);
				accountNumber = rs.getInt(5);
				balance = rs.getDouble(6);
			}
			conn.close();
		}
		catch(Exception e){ 
			System.out.println(e);
		}
		aBankAccount = new BankAccount(bankAccountNumber, customerNumber, bank, routingNumber, accountNumber, balance);
		
		return aBankAccount;
	}
}
