package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Tester {
	private final static String dBSchema = "coconinodatabase";
	private final static String dBUser = "OnlineShoppingApp";
	private final static String dBPass = "eSGDm43ZU6bGz9w";
	
	
	
	public static void main(String[] args) {
		
		Database db = new Database();
		
		/*
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/" + dBSchema, dBUser, dBPass);
			
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select * from bankaccounts");
			while(rs.next())
				System.out.println(rs.getInt(1)+"  "+rs.getString(2)+"  "+rs.getString(3));  
			conn.close();  
		}
		catch(Exception e){ System.out.println(e);}
		
		*/
		
		System.out.println(db.getBankAccount(3));
		
	}

}