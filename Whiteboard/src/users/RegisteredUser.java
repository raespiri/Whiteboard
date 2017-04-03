package users;

import java.util.ArrayList;

import content.Content;
import notifications.Notification;

public class RegisteredUser extends User {
	private String password; // User password
	private String email; // User email
	private ArrayList<String> friends; // List of user's friends
	private ArrayList<String> classes; // List of user's classes
	private ArrayList<Notification> actions; // List of user's notifications
	
	// Constructor
	public RegisteredUser() {

	}
	
	// Getters and Setters
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	// Method to add a new class
	public void addClass(String classID) {
		classes.add(classID);
	}
	
	// Method to create a new post
	public void post(String postID, Content content) {
		
	}
	
	// Method to publish a new file
	public void publish(String classID, String file) {
		
	}
	
	// Method to send a new chat message
	public void chat(String classID, Content content) {
		
	}
	
	// Method to create a new whiteboard drawing
	public void draw(String classID, Content content) {
		
	}
	
	// Method to add a new friend
	public void addFriend(String userID) {
		friends.add(userID);
	}
	
}