package database;

public class Tester {	
	
	public static void main(String[] args) {
		
		Database db = new Database();
		
		System.out.println(db.getBankAccount(3));
		
		System.out.println(db.isPasswordCorrect(2, "2"));
		
		db.close();
	}

}
