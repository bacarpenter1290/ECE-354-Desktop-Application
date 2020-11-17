package application;
	
import java.util.ArrayList;
import java.util.List;

import entities.*;
import javafx.application.Application;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.stage.Stage;
import javafx.stage.WindowEvent;
import services.OnlineShoppingService;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.Pane;


public class Main extends Application {
	Product selectedProduct = new Product();
	ShoppingCartDetail selectedDetail = new ShoppingCartDetail();
	
	List<Product> allProducts;
	List<Product> filteredProducts;
	ObservableList<Product> productData = FXCollections.observableList(new ArrayList<Product>());
	
	List<Brand> allBrands;
	ObservableList<Brand> brandData = FXCollections.observableList(new ArrayList<Brand>());
	
	List<ProductLine> allLines;
	ObservableList<ProductLine> lineData = FXCollections.observableList(new ArrayList<ProductLine>());
	
	List<ShoppingCartDetail> cartDetails;
	ObservableList<ShoppingCartDetail> cartData = FXCollections.observableList(new ArrayList<ShoppingCartDetail>());
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void start(Stage primaryStage) {
		try {
			OnlineShoppingService service = new OnlineShoppingService();
			
			primaryStage.setTitle("Coconino Online Shopping - Customer Login");
			Pane p = new Pane();
			Scene scene = new Scene(p,350,150);
			
			// create login button
			double buttonY = 60;
			double buttonXStart = 100;
			Button loginButton = new Button();
			loginButton.setLayoutX(buttonXStart);
			loginButton.setLayoutY(buttonY);
			loginButton.setText("Log in");
			loginButton.setMaxSize(100, 30);
			loginButton.setMinSize(100, 30);
			
			Button createAccountButton = new Button();
			createAccountButton.setLayoutX(buttonXStart - 25);
			createAccountButton.setLayoutY(buttonY + 50);
			createAccountButton.setText("Create a new account");
			createAccountButton.setMaxSize(150, 30);
			createAccountButton.setMinSize(150, 30);
			
			// create labels for customer number and password
			double labelY = 10;
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
			p.getChildren().add(createAccountButton);
			
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
			Scene shoppingScene = new Scene(shoppingPane,600,600);
			
			shoppingScene.getStylesheets().add(getClass().getResource("application.css").toExternalForm());
			
			// create table for products
			TableView productTable = new TableView();
			productTable.setEditable(true);
			productTable.setLayoutX(10);
			productTable.setLayoutY(25);
			
			TableColumn productNameCol = new TableColumn("Product");
			productNameCol.setCellValueFactory(
					new PropertyValueFactory<Product, String>("productName"));;
			
			TableColumn MRSPCol = new TableColumn("MSRP");
			MRSPCol.setCellValueFactory(
					new PropertyValueFactory<Product, String>("MSRP"));
			
			TableColumn discountCol = new TableColumn("Discount");
			discountCol.setCellValueFactory(
					new PropertyValueFactory<Product, String>("discountPercent"));
			
			productTable.getColumns().addAll(productNameCol, MRSPCol, discountCol);
			
			// create labels for product list and details
			Label listTitleLabel = new Label();
			listTitleLabel.setLayoutX(10);
			listTitleLabel.setLayoutY(0);
			listTitleLabel.setText("Products:");
			listTitleLabel.getStyleClass().add("title");
			
			Label detailsTitleLabel = new Label();
			detailsTitleLabel.setLayoutX(300);
			detailsTitleLabel.setLayoutY(0);
			detailsTitleLabel.setText("Product details:");
			detailsTitleLabel.getStyleClass().add("title");
			
			// create label and text boxes for selected product
			labelY = 25;
			double labelYOffset = 50;
			labelStartX = 300;
			Label productLabel = new Label();
			productLabel.setLayoutX(labelStartX);
			productLabel.setLayoutY(labelY);
			productLabel.setText("Product");
			
			Label brandLabel = new Label();
			brandLabel.setLayoutX(labelStartX);
			brandLabel.setLayoutY(labelY + labelYOffset);
			brandLabel.setText("Brand");
			
			Label productLineLabel = new Label();
			productLineLabel.setLayoutX(labelStartX);
			productLineLabel.setLayoutY(labelY + 2*labelYOffset);
			productLineLabel.setText("Product Line");
			
			Label descriptionLabel = new Label();
			descriptionLabel.setLayoutX(labelStartX);
			descriptionLabel.setLayoutY(labelY + 3*labelYOffset);
			descriptionLabel.setText("Description");
			
			Label qunatityInStockLabel = new Label();
			qunatityInStockLabel.setLayoutX(labelStartX);
			qunatityInStockLabel.setLayoutY(labelY + 4*labelYOffset);
			qunatityInStockLabel.setText("Quantity in stock");
			
			Label msrpLabel = new Label();
			msrpLabel.setLayoutX(labelStartX);
			msrpLabel.setLayoutY(labelY + 5*labelYOffset);
			msrpLabel.setText("MSRP");
			
			Label discountLabel = new Label();
			discountLabel.setLayoutX(labelStartX);
			discountLabel.setLayoutY(labelY + 6*labelYOffset);
			discountLabel.setText("Discount Percent");
			
			Label priceLabel = new Label();
			priceLabel.setLayoutX(labelStartX);
			priceLabel.setLayoutY(labelY + 7*labelYOffset);
			priceLabel.setText("Current Price");
			
			double textOffsetX = 100;
			TextField productText = new TextField();
			productText.setLayoutX(labelStartX + textOffsetX);
			productText.setLayoutY(labelY);
			productText.setDisable(true);
			productText.getStyleClass().add("disabledText");
			
			TextField brandText = new TextField();
			brandText.setLayoutX(labelStartX + textOffsetX);
			brandText.setLayoutY(labelY + labelYOffset);
			brandText.setDisable(true);
			brandText.getStyleClass().add("disabledText");
			
			TextField productLineText = new TextField();
			productLineText.setLayoutX(labelStartX + textOffsetX);
			productLineText.setLayoutY(labelY + 2*labelYOffset);
			productLineText.setDisable(true);
			productLineText.getStyleClass().add("disabledText");
			
			TextField descriptionText = new TextField();
			descriptionText.setLayoutX(labelStartX + textOffsetX);
			descriptionText.setLayoutY(labelY + 3*labelYOffset);
			descriptionText.setDisable(true);
			descriptionText.getStyleClass().add("disabledText");
			
			TextField quantityInStockText = new TextField();
			quantityInStockText.setLayoutX(labelStartX + textOffsetX);
			quantityInStockText.setLayoutY(labelY + 4*labelYOffset);
			quantityInStockText.setDisable(true);
			quantityInStockText.getStyleClass().add("disabledText");
			
			TextField msrpText = new TextField();
			msrpText.setLayoutX(labelStartX + textOffsetX);
			msrpText.setLayoutY(labelY + 5*labelYOffset);
			msrpText.setDisable(true);
			msrpText.getStyleClass().add("disabledText");
			
			TextField discountText = new TextField();
			discountText.setLayoutX(labelStartX + textOffsetX);
			discountText.setLayoutY(labelY + 6*labelYOffset);
			discountText.setDisable(true);
			discountText.getStyleClass().add("disabledText");
			
			TextField priceText = new TextField();
			priceText.setLayoutX(labelStartX + textOffsetX);
			priceText.setLayoutY(labelY + 7*labelYOffset);
			priceText.setDisable(true);
			priceText.getStyleClass().add("disabledText");
			
			buttonY = 500;
			buttonXStart = 10;
			double buttonXOffset = 150;
			Button viewCartButton = new Button();
			viewCartButton.setLayoutX(buttonXStart + buttonXOffset);
			viewCartButton.setLayoutY(buttonY);
			viewCartButton.setText("View Cart");
			viewCartButton.setMaxSize(100, 30);
			viewCartButton.setMinSize(100, 30);
			
			Button addToCartButton = new Button();
			addToCartButton.setLayoutX(buttonXStart + 2*buttonXOffset);
			addToCartButton.setLayoutY(buttonY);
			addToCartButton.setText("Add to Cart");
			addToCartButton.setMaxSize(100, 30);
			addToCartButton.setMinSize(100, 30);
			addToCartButton.setDisable(true);
			
			Button logoffButton = new Button();
			logoffButton.setLayoutX(buttonXStart + 3*buttonXOffset);
			logoffButton.setLayoutY(buttonY);
			logoffButton.setText("Logoff");
			logoffButton.setMaxSize(100, 30);
			logoffButton.setMinSize(100, 30);
			
			Button resetButton = new Button();
			resetButton.setLayoutX(buttonXStart);
			resetButton.setLayoutY(buttonY);
			resetButton.setText("Reset filters");
			resetButton.setMaxSize(100, 30);
			resetButton.setMinSize(100, 30);
			
			Label brandFilterLabel = new Label();
			brandFilterLabel.setLayoutX(10);
			brandFilterLabel.setLayoutY(430);
			brandFilterLabel.setText("Filter by brand:");
			
			ComboBox<Brand> brandCombo = new ComboBox<>();
			allBrands = service.db.getAllBrands();
			brandData = FXCollections.observableList(allBrands);
			brandCombo.setItems(brandData);
			brandCombo.setLayoutX(10);
			brandCombo.setLayoutY(450);
			
			Label lineFilterLabel = new Label();
			lineFilterLabel.setLayoutX(200);
			lineFilterLabel.setLayoutY(430);
			lineFilterLabel.setText("Filter by product lines:");
			
			ComboBox<ProductLine> lineCombo = new ComboBox<>();
			allLines = service.db.getProductLines();
			lineData = FXCollections.observableList(allLines);
			lineCombo.setItems(lineData);
			lineCombo.setLayoutX(200);
			lineCombo.setLayoutY(450);
			
			shoppingPane.getChildren().add(listTitleLabel);
			shoppingPane.getChildren().add(detailsTitleLabel);
			
			shoppingPane.getChildren().add(productTable);
			
			shoppingPane.getChildren().add(productLabel);
			shoppingPane.getChildren().add(brandLabel);
			shoppingPane.getChildren().add(productLineLabel);
			shoppingPane.getChildren().add(descriptionLabel);
			shoppingPane.getChildren().add(qunatityInStockLabel);
			shoppingPane.getChildren().add(msrpLabel);
			shoppingPane.getChildren().add(discountLabel);
			shoppingPane.getChildren().add(priceLabel);
			shoppingPane.getChildren().add(brandFilterLabel);
			shoppingPane.getChildren().add(lineFilterLabel);
			
			shoppingPane.getChildren().add(productText);
			shoppingPane.getChildren().add(brandText);
			shoppingPane.getChildren().add(productLineText);
			shoppingPane.getChildren().add(descriptionText);
			shoppingPane.getChildren().add(quantityInStockText);
			shoppingPane.getChildren().add(msrpText);
			shoppingPane.getChildren().add(discountText);
			shoppingPane.getChildren().add(priceText);
			
			shoppingPane.getChildren().add(viewCartButton);
			shoppingPane.getChildren().add(addToCartButton);
			shoppingPane.getChildren().add(resetButton);
			shoppingPane.getChildren().add(logoffButton);
			
			shoppingPane.getChildren().add(brandCombo);
			shoppingPane.getChildren().add(lineCombo);
			
			shoppingWindow.setScene(shoppingScene);
			
			// make shopping cart window
			Stage cartWindow = new Stage();
			cartWindow.setTitle("Shopping Cart");
			
			Pane cartPane = new Pane();
			Scene cartScene = new Scene(cartPane, 1000, 800);
			cartScene.getStylesheets().add(getClass().getResource("application.css").toExternalForm());
			
			// create table for cart
			TableView cartTable = new TableView();
			cartTable.setEditable(true);
			cartTable.setPrefWidth(200);
			cartTable.setLayoutX(10);
			cartTable.setLayoutY(25);
			
			TableColumn cartProductNameCol = new TableColumn("Product");
			cartProductNameCol.setCellValueFactory(
					new PropertyValueFactory<Product, String>("product"));
					
			TableColumn cartQuantityCol = new TableColumn("Quantity");
			cartQuantityCol.setCellValueFactory(
					new PropertyValueFactory<Product, String>("quantity"));
			
			cartTable.getColumns().addAll(cartProductNameCol, cartQuantityCol);
			
			Label cartTitleLabel = new Label();
			cartTitleLabel.setLayoutX(10);
			cartTitleLabel.setLayoutY(0);
			cartTitleLabel.setText("Shopping Cart:");
			cartTitleLabel.getStyleClass().add("title");
			
			Label cartDetailsTitleLabel = new Label();
			cartDetailsTitleLabel.setLayoutX(300);
			cartDetailsTitleLabel.setLayoutY(0);
			cartDetailsTitleLabel.setText("Cart Details:");
			cartDetailsTitleLabel.getStyleClass().add("title");
			
			Button closeCartButton = new Button();
			closeCartButton.setLayoutX(10);
			closeCartButton.setLayoutY(450);
			closeCartButton.setText("Close");
			closeCartButton.setMaxSize(100, 30);
			closeCartButton.setMinSize(100, 30);
			
			// create label and text boxes for selected product
			labelY = 25;
			labelYOffset = 50;
			labelStartX = 300;
			Label cartProductLabel = new Label();
			cartProductLabel.setLayoutX(labelStartX);
			cartProductLabel.setLayoutY(labelY);
			cartProductLabel.setText("Product");
			
			Label cartQuantityLabel = new Label();
			cartQuantityLabel.setLayoutX(labelStartX);
			cartQuantityLabel.setLayoutY(labelY + labelYOffset);
			cartQuantityLabel.setText("Quantity");
			
			Label cartMSRPLabel = new Label();
			cartMSRPLabel.setLayoutX(labelStartX);
			cartMSRPLabel.setLayoutY(labelY + 2*labelYOffset);
			cartMSRPLabel.setText("MSRP");
			
			Label cartDiscountLabel = new Label();
			cartDiscountLabel.setLayoutX(labelStartX);
			cartDiscountLabel.setLayoutY(labelY + 3*labelYOffset);
			cartDiscountLabel.setText("Discount");
			
			Label cartTaxLabel = new Label();
			cartTaxLabel.setLayoutX(labelStartX);
			cartTaxLabel.setLayoutY(labelY + 4*labelYOffset);
			cartTaxLabel.setText("Sales Tax");
			
			Label cartSubTotalLabel = new Label();
			cartSubTotalLabel.setLayoutX(labelStartX);
			cartSubTotalLabel.setLayoutY(labelY + 5*labelYOffset);
			cartSubTotalLabel.setText("Subtotal");
			
			textOffsetX = 100;
			TextField cartProductText = new TextField();
			cartProductText.setLayoutX(labelStartX + textOffsetX);
			cartProductText.setLayoutY(labelY);
			cartProductText.setDisable(true);
			cartProductText.getStyleClass().add("disabledText");
			
			TextField cartQuantityText = new TextField();
			cartQuantityText.setLayoutX(labelStartX + textOffsetX);
			cartQuantityText.setLayoutY(labelY + labelYOffset);
			cartQuantityText.setDisable(true);
			cartQuantityText.getStyleClass().add("disabledText");
			
			TextField cartMSRPText = new TextField();
			cartMSRPText.setLayoutX(labelStartX + textOffsetX);
			cartMSRPText.setLayoutY(labelY + 2*labelYOffset);
			cartMSRPText.setDisable(true);
			cartMSRPText.getStyleClass().add("disabledText");
			
			TextField cartDiscountText = new TextField();
			cartDiscountText.setLayoutX(labelStartX + textOffsetX);
			cartDiscountText.setLayoutY(labelY + 3*labelYOffset);
			cartDiscountText.setDisable(true);
			cartDiscountText.getStyleClass().add("disabledText");
			
			TextField cartTaxText = new TextField();
			cartTaxText.setLayoutX(labelStartX + textOffsetX);
			cartTaxText.setLayoutY(labelY + 4*labelYOffset);
			cartTaxText.setDisable(true);
			cartTaxText.getStyleClass().add("disabledText");
			
			TextField cartSubTotalText = new TextField();
			cartSubTotalText.setLayoutX(labelStartX + textOffsetX);
			cartSubTotalText.setLayoutY(labelY + 5*labelYOffset);
			cartSubTotalText.setDisable(true);
			cartSubTotalText.getStyleClass().add("disabledText");
			
			cartPane.getChildren().add(cartTable);
			
			cartPane.getChildren().add(closeCartButton);
			
			cartPane.getChildren().add(cartTitleLabel);
			cartPane.getChildren().add(cartDetailsTitleLabel);
			cartPane.getChildren().add(cartProductLabel);
			cartPane.getChildren().add(cartQuantityLabel);
			cartPane.getChildren().add(cartMSRPLabel);
			cartPane.getChildren().add(cartDiscountLabel);
			cartPane.getChildren().add(cartTaxLabel);
			cartPane.getChildren().add(cartSubTotalLabel);
			
			cartPane.getChildren().add(cartProductText);
			cartPane.getChildren().add(cartQuantityText);
			cartPane.getChildren().add(cartMSRPText);
			cartPane.getChildren().add(cartDiscountText);
			cartPane.getChildren().add(cartTaxText);
			cartPane.getChildren().add(cartSubTotalText);
			
			cartWindow.setScene(cartScene);
			
			// make customer account creation window
			Stage customerWindow = new Stage();
			customerWindow.setTitle("Create account");
			
			Pane customerPane = new Pane();
			Scene customerScene = new Scene(customerPane, 300, 600);
			
			// close the confirm window when the ok button is pressed
			closeCartButton.setOnAction(new EventHandler<ActionEvent>() {
				public void handle(ActionEvent e) {
					shoppingWindow.show();
					cartWindow.close();
				}
			});

			// create label and text boxes for selected product
			labelY = 20;
			labelYOffset = 50;
			labelStartX = 10;
			Label firstNameLabel = new Label();
			firstNameLabel.setLayoutX(labelStartX);
			firstNameLabel.setLayoutY(labelY);
			firstNameLabel.setText("First Name");
			
			Label lastNameLabel = new Label();
			lastNameLabel.setLayoutX(labelStartX);
			lastNameLabel.setLayoutY(labelY + labelYOffset);
			lastNameLabel.setText("Last Name");
			
			Label phoneLabel = new Label();
			phoneLabel.setLayoutX(labelStartX);
			phoneLabel.setLayoutY(labelY + 2*labelYOffset);
			phoneLabel.setText("Phone Number");
			
			Label address1Label = new Label();
			address1Label.setLayoutX(labelStartX);
			address1Label.setLayoutY(labelY + 3*labelYOffset);
			address1Label.setText("Address Line 1");
			
			Label address2Label = new Label();
			address2Label.setLayoutX(labelStartX);
			address2Label.setLayoutY(labelY + 4*labelYOffset);
			address2Label.setText("Address Line 2");
			
			Label cityLabel = new Label();
			cityLabel.setLayoutX(labelStartX);
			cityLabel.setLayoutY(labelY + 5*labelYOffset);
			cityLabel.setText("City");
			
			Label stateLabel = new Label();
			stateLabel.setLayoutX(labelStartX);
			stateLabel.setLayoutY(labelY + 6*labelYOffset);
			stateLabel.setText("State (2 letters)");
			
			Label postalCodeLabel = new Label();
			postalCodeLabel.setLayoutX(labelStartX);
			postalCodeLabel.setLayoutY(labelY + 7*labelYOffset);
			postalCodeLabel.setText("Postal Code");
			
			Label countryLabel = new Label();
			countryLabel.setLayoutX(labelStartX);
			countryLabel.setLayoutY(labelY + 8*labelYOffset);
			countryLabel.setText("Country");
			
			Label createPasswordLabel = new Label();
			createPasswordLabel.setLayoutX(labelStartX);
			createPasswordLabel.setLayoutY(labelY + 9*labelYOffset);
			createPasswordLabel.setText("Enter password: ");
			
			textOffsetX = 100;
			TextField firstNameText = new TextField();
			firstNameText.setLayoutX(labelStartX + textOffsetX);
			firstNameText.setLayoutY(labelY);
			
			TextField lastNameText = new TextField();
			lastNameText.setLayoutX(labelStartX + textOffsetX);
			lastNameText.setLayoutY(labelY + labelYOffset);
			
			TextField phoneText = new TextField();
			phoneText.setLayoutX(labelStartX + textOffsetX);
			phoneText.setLayoutY(labelY + 2*labelYOffset);
			
			TextField address1Text = new TextField();
			address1Text.setLayoutX(labelStartX + textOffsetX);
			address1Text.setLayoutY(labelY + 3*labelYOffset);
			
			TextField address2Text = new TextField();
			address2Text.setLayoutX(labelStartX + textOffsetX);
			address2Text.setLayoutY(labelY + 4*labelYOffset);
			
			TextField cityText = new TextField();
			cityText.setLayoutX(labelStartX + textOffsetX);
			cityText.setLayoutY(labelY + 5*labelYOffset);
			
			TextField stateText = new TextField();
			stateText.setLayoutX(labelStartX + textOffsetX);
			stateText.setLayoutY(labelY + 6*labelYOffset);
			
			TextField postalCodeText = new TextField();
			postalCodeText.setLayoutX(labelStartX + textOffsetX);
			postalCodeText.setLayoutY(labelY + 7*labelYOffset);
			
			TextField countryText = new TextField();
			countryText.setLayoutX(labelStartX + textOffsetX);
			countryText.setLayoutY(labelY + 8*labelYOffset);
			
			PasswordField createPasswordText = new PasswordField();
			createPasswordText.setLayoutX(labelStartX + textOffsetX);
			createPasswordText.setLayoutY(labelY + 9*labelYOffset);
			
			Button createButton = new Button();
			createButton.setLayoutX(labelStartX + textOffsetX / 2);
			createButton.setLayoutY(labelY + 10*labelYOffset);
			createButton.setText("Create");
			createButton.setMaxSize(250, 50);
			createButton.setMinSize(250, 50);
			
			customerPane.getChildren().add(createButton);
			customerPane.getChildren().add(createPasswordText);
			customerPane.getChildren().add(countryText);
			customerPane.getChildren().add(postalCodeText);
			customerPane.getChildren().add(cityText);
			customerPane.getChildren().add(stateText);
			customerPane.getChildren().add(address2Text);
			customerPane.getChildren().add(address1Text);
			customerPane.getChildren().add(phoneText);
			customerPane.getChildren().add(lastNameText);
			customerPane.getChildren().add(firstNameText);
			
			customerPane.getChildren().add(createPasswordLabel);
			customerPane.getChildren().add(countryLabel);
			customerPane.getChildren().add(postalCodeLabel);
			customerPane.getChildren().add(cityLabel);
			customerPane.getChildren().add(stateLabel);
			customerPane.getChildren().add(address2Label);
			customerPane.getChildren().add(address1Label);
			customerPane.getChildren().add(phoneLabel);
			customerPane.getChildren().add(lastNameLabel);
			customerPane.getChildren().add(firstNameLabel);
			
			customerWindow.setScene(customerScene);
			
			// create window for confirmation
			Stage confirmWindow = new Stage();
			confirmWindow.setTitle("Confirmation");
			
			Pane confirmPane = new Pane();
			Scene confirmScene = new Scene(confirmPane, 300, 100);
			
			Label confirmLabel = new Label();
			confirmLabel.setLayoutX(10);
			confirmLabel.setLayoutY(10);
			
			Button confirmOkButton = new Button();
			confirmOkButton.setLayoutX(10);
			confirmOkButton.setLayoutY(50);
			confirmOkButton.setText("Ok");
			createButton.setMaxSize(100, 30);
			createButton.setMinSize(100, 30);
			
			confirmPane.getChildren().add(confirmLabel);
			confirmPane.getChildren().add(confirmOkButton);
			
			confirmWindow.setScene(confirmScene);
			
			// close the confirm window when the ok button is pressed
			confirmOkButton.setOnAction(new EventHandler<ActionEvent>() {
				public void handle(ActionEvent e) {
					confirmWindow.close();
				}
			});
			
			// create window for choosing quantity to add to cart
			Stage addToCartWindow = new Stage();
			addToCartWindow.setTitle("Choose Quantity");
			
			Pane addToCartPane = new Pane();
			Scene addToCartScene = new Scene(addToCartPane, 400, 400);
			
			Label addToCartLabel = new Label();
			addToCartLabel.setLayoutX(10);
			addToCartLabel.setLayoutY(10);
			addToCartLabel.setText("Enter quantity: ");
			
			TextField addToCartText = new TextField();
			addToCartText.setLayoutX(100);
			addToCartText.setLayoutY(10);
			
			Button confirmAddToCartButton = new Button();
			confirmAddToCartButton.setLayoutX(50);
			confirmAddToCartButton.setLayoutY(50);
			confirmAddToCartButton.setText("Confirm");
			confirmAddToCartButton.setMaxSize(100, 30);
			confirmAddToCartButton.setMinSize(100, 30);
			
			addToCartPane.getChildren().add(addToCartLabel);
			addToCartPane.getChildren().add(addToCartText);
			addToCartPane.getChildren().add(confirmAddToCartButton);
			
			addToCartWindow.setScene(addToCartScene);
			
			addToCartWindow.setOnCloseRequest(new EventHandler<WindowEvent>() {
			    @Override
			    public void handle(WindowEvent e) {
			    	addToCartText.setText("");
			    }
			});
			
			// close application when logoff is pressed
			logoffButton.setOnAction(new EventHandler<ActionEvent>() {
				public void handle(ActionEvent e) {
					shoppingWindow.close();
				}
			});
			
			// otherwise, display warning
			createButton.setOnAction(new EventHandler<ActionEvent>() {
				public void handle(ActionEvent e) {
					try {
						Customer customer = new Customer(0, firstNameText.getText(), lastNameText.getText(),
								phoneText.getText(), address1Text.getText(), address2Text.getText(), cityText.getText(),
								stateText.getText(), Integer.parseInt(postalCodeText.getText()), countryText.getText());
						
						customer = service.db.createCustomer(customer, createPasswordText.getText());
						
						if(customer.getCustomerNumber() == 0) {
							invalidLabel.setText("Invalid entry");
							invalidWindow.show();
						}
						else {
							confirmLabel.setText("Account created. Your customer number is " + customer.getCustomerNumber());
							confirmWindow.show();
							customerWindow.close();
							
							createPasswordText.setText("");
							countryText.setText("");
							postalCodeText.setText("");
							cityText.setText("");
							stateText.setText("");
							address2Text.setText("");
							address1Text.setText("");
							phoneText.setText("");
							lastNameText.setText("");
							firstNameText.setText("");
						}
					}
					catch(Exception ex) {
						invalidLabel.setText("Invalid entry");
						invalidWindow.show();
					}
				}
			});
			
			// when the login button is pressed, check to make sure password correct
			// if correct, move to online shopping system
			// otherwise, display warning
			loginButton.setOnAction(new EventHandler<ActionEvent>() {
				public void handle(ActionEvent e) {
					try {
						int customerNumber = Integer.parseInt(customerText.getText());
						boolean correctPassword = service.db.isPasswordCorrect(customerNumber, passwordText.getText());
						if(correctPassword) {
							service.setCurrentCustomer(service.db.getCustomer(customerNumber));
							shoppingWindow.setTitle(shoppingWindow.getTitle() + service.getCurrentCustomer().getCustomerNumber());
							
							allProducts = service.db.getAllProducts();
							productData = FXCollections.observableList(allProducts);
							productTable.setItems(productData);
							
							customerText.setText("");
							passwordText.setText("");
							
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
			
			// reset filters
			resetButton.setOnAction(new EventHandler<ActionEvent>() {
				public void handle(ActionEvent e) {
					productData = FXCollections.observableList(allProducts);
					productTable.setItems(productData);
					brandCombo.getSelectionModel().clearSelection();
					
					brandCombo.setDisable(false);
					lineCombo.setDisable(false);
				}
			});
			
			// add item to cart
			addToCartButton.setOnAction(new EventHandler<ActionEvent>() {
				public void handle(ActionEvent e) {
					addToCartWindow.show();
				}
			});
			
			// add item to cart
			confirmAddToCartButton.setOnAction(new EventHandler<ActionEvent>() {
				public void handle(ActionEvent e) {
					try {
						int quantity = Integer.parseInt(addToCartText.getText());
						boolean valid = service.db.addProductToCart(selectedProduct, quantity, service.getCurrentCustomer().getCustomerNumber());
						if(valid) {
							addToCartText.setText("");
							addToCartWindow.close();
						}
						else {
							invalidLabel.setText("Not enough in stock");
							invalidWindow.show();
						}
					}
					catch (Exception ex) {
						invalidLabel.setText("Invalid entry");
						invalidWindow.show();
					}
				}
			});
			
			// create a new account
			createAccountButton.setOnAction(new EventHandler<ActionEvent>() {
				public void handle(ActionEvent e) {
					customerWindow.show();
				}
			});
			
			// view cart
			viewCartButton.setOnAction(new EventHandler<ActionEvent>() {
				public void handle(ActionEvent e) {
					Customer curr = service.getCurrentCustomer();
					ShoppingCart cart = service.db.getShoppingCart(curr.getCustomerNumber());
					cartDetails = cart.getShoppingCartDetails();
			    	cartData = FXCollections.observableList(cartDetails);
			    	cartTable.setItems(cartData);
					
			    	cartWindow.setTitle("Shopping cart - Customer #" + service.getCurrentCustomer().getCustomerNumber());
					cartWindow.show();
					
					shoppingWindow.close();
				}
			});
			
			// when a product is selected, display the products full info
			productTable.getSelectionModel().selectedItemProperty().addListener((obs, oldSelection, newSelection) -> {
			    if (newSelection != null) {
			    	selectedProduct = (Product)newSelection;
			    	Brand brand = service.db.getBrand(selectedProduct.getVendorNumber());
			    	ProductLine line = service.db.getProductLine(selectedProduct.getProductLineNumber());
			        productText.setText(selectedProduct.getProductName());
			        brandText.setText(brand.getBrandName());
			        productLineText.setText(line.getProductLine());
			        descriptionText.setText(selectedProduct.getProductDescription());
			        quantityInStockText.setText(Integer.toString(selectedProduct.getQuantityInStock()));
			        msrpText.setText(String.format("%.2f",selectedProduct.getMSRP()));
			        discountText.setText(Double.toString(selectedProduct.getDiscountPercent()));
			        
			        double price = selectedProduct.getMSRP() * (1 - (selectedProduct.getDiscountPercent() / 100));
			        priceText.setText(Double.toString(price));
			        
			        addToCartButton.setDisable(false);
			    }
			});
			
			cartTable.getSelectionModel().selectedItemProperty().addListener((obs, oldSelection, newSelection) -> {
			    if (newSelection != null) {
			    	selectedDetail = (ShoppingCartDetail)newSelection;
			    	selectedProduct = selectedDetail.getProduct();
			    	cartProductText.setText(selectedProduct.getProductName());
			    	cartQuantityText.setText(Integer.toString(selectedDetail.getQuantity()));
			    	cartMSRPText.setText(String.format("%.2f",selectedProduct.getMSRP()));
			    	cartDiscountText.setText(Double.toString(selectedProduct.getDiscountPercent()));
			    	cartTaxText.setText(Double.toString(service.getSalesTaxRate()));
			    	double subtotal = selectedProduct.getMSRP() * (1 - ((selectedProduct.getDiscountPercent() - service.getSalesTaxRate()) / 100)) * selectedDetail.getQuantity();
			    	cartSubTotalText.setText(String.format("%.2f", subtotal));
			    }
			});
			
			lineCombo.valueProperty().addListener((obs, oldval, newval) -> {
			    if(newval != null) {
			    	ProductLine line = (ProductLine)newval;
			    	filteredProducts = this.filterProductsByLine(line.getProductLineNumber());
			    	productData = FXCollections.observableList(filteredProducts);
					productTable.setItems(productData);
					
					brandCombo.setDisable(true);
			    }
			});
			
			brandCombo.valueProperty().addListener((obs, oldval, newval) -> {
			    if(newval != null) {
			    	Brand brand = (Brand)newval;
			    	filteredProducts = this.filterProductsByBrand(brand.getVendorNumber());
			    	productData = FXCollections.observableList(filteredProducts);
					productTable.setItems(productData);
					
					lineCombo.setDisable(true);
			    }
			});
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<Product> filterProductsByBrand(int vendorNumber) {
		List<Product> filteredProducts = new ArrayList<Product>();
		
		for(int i = 0; i < allProducts.size(); i++) {
			Product curr = allProducts.get(i);
			if(curr.getVendorNumber() == vendorNumber) {
				filteredProducts.add(curr);
			}
		}
		
		return filteredProducts;
	}
	
	public List<Product> filterProductsByLine(int productLineNumber) {
		List<Product> filteredProducts = new ArrayList<Product>();
		
		for(int i = 0; i < allProducts.size(); i++) {
			Product curr = allProducts.get(i);
			if(curr.getProductLineNumber() == productLineNumber) {
				filteredProducts.add(curr);
			}
		}
		
		return filteredProducts;
	}
	
	public static void main(String[] args) {
		launch(args);
	}
}
