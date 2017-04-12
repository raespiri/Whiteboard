package datastorage;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;
//import java.util.List;

import com.mysql.jdbc.Statement;

import course.Course;
import users.RegisteredUser;
import users.User;

public class DataStorage {
	ArrayList<User> users;
	ArrayList<Course> courses;
	public DataStorage()
	{
		users = new ArrayList<User>();
		courses = new ArrayList<Course>();
	}
	public void retrieveData()
	{
		try {
            String url = "jdbc:msql://192.241.193.125";
	        java.sql.Connection conn = DriverManager.getConnection(url, "", "");
	        java.sql.Statement stmt = conn.createStatement();
	        ResultSet rs;
	        rs = stmt.executeQuery("SELECT * FROM Users");
	        while( rs.next() ){
	        	String password = rs.getString("pass");
	        	String email = rs.getString("email");
	        	String fullname =  rs.getString("fullname");
	        	String username = rs.getString("username");
	        	String image = rs.getString("image");
	        	String userID = rs.getString("userID");
	        	
	        	RegisteredUser u = new RegisteredUser(password,email,fullname,username,image,userID);
	        	users.add(u);
	        }
	        rs = stmt.executeQuery("SELECT * FROM Courses");
	        while( rs.next() )
	        {
	        	Course c = new Course(rs.getInt("courseID"));
	        	courses.add(c);
	        }
		} catch (Exception e) {
	        System.err.print("Got an exception! ");
	        System.err.println(e.getMessage());
	    }
	}
	
	public RegisteredUser getUser(String userID) {
		for(int i = 0; i < users.size(); i++) {
			if(users.get(i).getUserID().equals(userID)) {
				return (RegisteredUser) users.get(i);
			}
		}
		return null;
	}
}
