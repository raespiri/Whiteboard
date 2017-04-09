package datastorage;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.Statement;

import course.Course;
import users.RegisteredUser;
import users.User;

public class DataStorage {
	List<User> users;
	List<Course> courses;
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
	        	RegisteredUser u = new RegisteredUser();
	        	u.setUserID(rs.getString("username"));
	        	users.add(u);
	        }
		} catch (Exception e) {
	        System.err.print("Got an exception! ");
	        System.err.println(e.getMessage());
	    }
	}
}
