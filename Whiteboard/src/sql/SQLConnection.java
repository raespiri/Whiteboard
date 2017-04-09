package sql;

import java.sql.SQLException;

import java.sql.*;

public class SQLConnection {
	private Connection conn;
	private final static String addUser = "INSERT INTO Users(username, pass, fullname, image, email) VALUES(?, ?, ?, ?, ?)";
	public SQLConnection() {
		try {
			new com.mysql.jdbc.Driver();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void connect() {
		try {
			conn = DriverManager.getConnection("jdbc:mysql://192.241.193.125/Whiteboard?user=root&password=21d7BIiQypvrDu7Bcbvb&useSSL=false");
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void stop() {
		try {
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void addUser(String username, String pass, String fullname, String image, String email) {
		try {
			PreparedStatement ps = conn.prepareStatement(addUser);
			ps.setString(1, username);
			ps.setString(2, pass);
			ps.setString(3, fullname);
			ps.setString(4, image);
			ps.setString(5, email);
			ps.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
