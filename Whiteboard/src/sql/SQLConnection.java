package sql;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.util.UUID;

public class SQLConnection {
	private Connection conn;
	private final static String addPost = "INSERT INTO Whiteboard.Posts(contentID, userID, classID, Title, Body) VALUES(?, ?, ?, ?, ?)";
	private final static String addUser = "INSERT INTO Users(username, pass, fullname, image, email) VALUES(?, ?, ?, ?, ?)";
	private final static String getPosts = "SELECT * FROM Posts WHERE ClassID = ";
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

	public void addPost(int classID, String title, String body) {
		try {
			PreparedStatement ps = conn.prepareStatement(addPost);
			UUID idOne = UUID.randomUUID();
			ps.setString(1, idOne.toString());
			ps.setInt(2, 803850);
			ps.setInt(3, classID);
			ps.setString(4, title);
			ps.setString(5, body);
			ps.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public List<content.Post> getPosts(int classID)
	{
		try {
			String getPostsForClass = getPosts+classID;
			PreparedStatement ps;
			ps = conn.prepareStatement(getPostsForClass);
			ResultSet rs = ps.executeQuery();
			List<content.Post> posts = new ArrayList<content.Post>();
			while(rs.next())
			{
				java.sql.Date sqlDate = new java.sql.Date(rs.getTime(6).getTime());
				content.Post newPost = new content.Post(rs.getString(1), Integer.toString(rs.getInt(2)), Integer.toString(rs.getInt(3)), rs.getString(4), rs.getString(5), sqlDate);
				newPost.setScore(rs.getInt(7));
				posts.add(newPost);
			}
			return posts;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("SQL ERROR WHILE FETCHING POSTS");
		}
		return null;
	}
}
