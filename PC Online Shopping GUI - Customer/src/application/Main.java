package application;
	
import database.Database;
import entities.Customer;
import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.layout.Pane;


public class Main extends Application {
	Customer currentCustomer = new Customer();
	@Override
	public void start(Stage primaryStage) {
		try {
			Database db = new Database();
			
			primaryStage.setTitle("Coconino Online Shopping - Customer Login");
			double sceneWidth = 1000;
			double sceneLength = 600;
			Pane p = new Pane();
			Scene scene = new Scene(p,sceneWidth,sceneLength);
			
			// create login button
			double buttonY = 450;
			double buttonXStart = 300;
			Button loginButton = new Button();
			loginButton.setLayoutX(buttonXStart);
			loginButton.setLayoutY(buttonY);
			loginButton.setText("Log in");
			loginButton.setMaxSize(100, 30);
			loginButton.setMinSize(100, 30);
			
			// create labels for customer number and password
			double labelY = 100;
			double labelStartX = 10;
			double labelXOffset = 160;
			Label customerLabel = new Label();
			customerLabel.setLayoutX(labelStartX);
			customerLabel.setLayoutY(labelY);
			customerLabel.setText("Customer Number:");
			
			Label passwordLabel = new Label();
			passwordLabel.setLayoutX(labelStartX + labelXOffset);
			passwordLabel.setLayoutY(labelY);
			passwordLabel.setText("Password: ");
			
			// create text boxes for customer number and password
			double textY = labelY + 20;
			double textStartX = 10;
			double textXOffset = 160; 
			TextField customerText = new TextField();
			customerText.setLayoutX(textStartX);
			customerText.setLayoutY(textY);
			customerText.setStyle("-fx-opacity: 1;");
	        
			PasswordField passwordText = new PasswordField();
			passwordText.setLayoutX(textStartX + textXOffset);
			passwordText.setLayoutY(textY);
			passwordText.setStyle("-fx-opacity: 1;");
			
			p.getChildren().add(loginButton);
			p.getChildren().add(customerLabel);
			p.getChildren().add(passwordLabel);
			p.getChildren().add(customerText);
			p.getChildren().add(passwordText);
			
			primaryStage.setScene(scene);
			primaryStage.show();
			
			// create a new stage, pane, and scene to tell the user that was an invalid input
			Stage invalidWindow = new Stage();
			invalidWindow.setTitle("Invalid Input");
			
			Pane invalidPane = new Pane();
			Scene invalidScene = new Scene(invalidPane,250,75);
			invalidWindow.setScene(invalidScene);
			
			// create a label to inform the user of an invalid input
			Label invalidLabel = new Label();
			invalidLabel.setLayoutX(10);
			invalidLabel.setLayoutY(10);
			
			// create a button that the user will press to close the invalid window
			Button okButton = new Button();
			okButton.setLayoutX(100);
			okButton.setLayoutY(40);
			okButton.setText("Ok");
			
			// add the above elements to the invalid pane
			invalidPane.getChildren().add(invalidLabel);
			invalidPane.getChildren().add(okButton);
			
			// close the invalid window when the ok button is pressed
			okButton.setOnAction(new EventHandler<ActionEvent>() {
				public void handle(ActionEvent e) {
					invalidWindow.close();
				}
			});
			
			// create a new stage, pane, and scene for the shopping system after logging in
			Stage shoppingWindow = new Stage();
			shoppingWindow.setTitle("Coconino Online Shopping System - Customer #");
			
			Pane shoppingPane = new Pane();
			Scene shoppingScene = new Scene(shoppingPane,250,75);
			
			shoppingWindow.setScene(shoppingScene);
			
			// when the login button is pressed, check to make sure password correct
			// if correct, move to online shopping system
			// otherwise, display warning
			loginButton.setOnAction(new EventHandler<ActionEvent>() {
				public void handle(ActionEvent e) {
					try {
						int customerNumber = Integer.parseInt(customerText.getText());
						boolean correctPassword = db.isPasswordCorrect(customerNumber, passwordText.getText());
						if(correctPassword) {
							setCustomer(db.getCustomer(customerNumber));
							shoppingWindow.setTitle(shoppingWindow.getTitle() + currentCustomer.getCustomerNumber());
							primaryStage.close();
							shoppingWindow.show();
						}
						else {
							invalidLabel.setText("Password does not match customer number.");
							invalidWindow.show();
						}
					}
					catch(Exception ex) {
						invalidLabel.setText("Must enter a number into customer number");
						invalidWindow.show();
					}
				}
			});
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		launch(args);
	}
	
	public void setCustomer(Customer customer) {
		currentCustomer = customer;
		System.out.println(currentCustomer.getFirstName());
	}
}
