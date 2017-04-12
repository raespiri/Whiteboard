package sql;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.util.UUID;

import content.Post;
import notifications.Notification;

public class SQLConnection {
	private Connection conn;
	private final static String addPost = "INSERT INTO Whiteboard.Posts(contentID, userID, classID, Title, Body) VALUES(?, ?, ?, ?, ?)";
	private final static String addUser = "INSERT INTO Users(username, pass, fullname, image, email) VALUES(?, ?, ?, ?, ?)";
	private final static String addNotif = "INSERT INTO Notifications(ActionType, ActionID, FullName, ContentName, CourseName, username) VALUES(?, ?, ?, ?, ?, ?)";
	
	private final static String getPostID= "SELECT * FROM Posts WHERE userID = ? AND classID = ? AND Title=? ";
	private final static String getCourseName = "SELECT * FROM Courses WHERE CourseID = ?";
	private final static String getUserID = "SELECT userID FROM Users WHERE username = ?";
	private final static String getUser = "SELECT * FROM Users WHERE userID = ?";
	private final static String getNotif = "SELECT * FROM Notification WHERE username = ?";
	private final static String getPosts = "SELECT * FROM Posts WHERE ClassID = ";
	private final static String upvotePost = "UPDATE Whiteboard.Posts "+
											"SET score = score + 1 WHERE contentID = '";
	private final static String downvotePost = "UPDATE Whiteboard.Posts "+
			"SET score = score - 1 WHERE contentID = '";
	private final static String getLoginCredentials = "SELECT pass FROM Users WHERE username = ?";
	
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
	
	public String getcoursename(String classID){
		String cname=null;
		try {
			String getcoursename = getCourseName+classID;
			PreparedStatement ps;
			ps = conn.prepareStatement(getcoursename);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				cname = rs.getString(2);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL ERROR WHILE FETCHING coursename");
		}
		
		return cname;
	}
	
	public void addNotif(String actiontype, String actionID, String userID, String contentname, String classID) {
		
		String username=null, fullname = null, coursename=null;
		try {
			String getuserinfo = getUser+userID;
			PreparedStatement ps;
			ps = conn.prepareStatement(getuserinfo);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				username = rs.getString(2);
				fullname = rs.getString(4);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL ERROR WHILE FETCHING userinfo");
		}
		
		coursename = getcoursename(classID);
		
		try {
			PreparedStatement ps = conn.prepareStatement(addNotif);
			
			ps.setString(1, actiontype);
			ps.setString(2, actionID);
			ps.setString(3, fullname);
			ps.setString(4, contentname);
			ps.setString(5, coursename);			
			ps.setString(6, username);
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
	
	public ArrayList<Notification> getNotifs(String username){
		
		ArrayList<Notification> notifs = new ArrayList<Notification>();
		
		try {
			String getNotifsforUser = getNotif+username;//just our own notifications
			PreparedStatement ps;
			ps = conn.prepareStatement(getNotifsforUser);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				java.sql.Date sqlDate = new java.sql.Date(rs.getTime(8).getTime());
				Notification newNotif = new Notification(Integer.toString(rs.getInt(3)), rs.getString(2), rs.getString(4), rs.getString(7), rs.getString(6), rs.getString(5), sqlDate);
				newNotif.setNotificationID(rs.getString(1));
				notifs.add(newNotif);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("SQL ERROR WHILE FETCHING NOTIFS");
		}
		
		return notifs;
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

	public void upvote(String postID) {
		try {
			String withID = upvotePost+postID+"'";
			PreparedStatement ps;
			ps = conn.prepareStatement(withID);
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void downvote(String postID) {
		try {
			String withID = downvotePost+postID+"'";
			System.out.println(withID);
			PreparedStatement ps;
			ps = conn.prepareStatement(withID);
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public String getUserID(String username) {
		try {
			PreparedStatement ps;
			ps = conn.prepareStatement(getUserID);
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			String userID = "";
			if (rs.next()) { // Loop to get all result sets
				userID = rs.getString("userID");
			}
			return userID;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
<<<<<<< HEAD
	public boolean validCredentials(String username, String password) {
		try {
			PreparedStatement ps;
			ps = conn.prepareStatement(getLoginCredentials);
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			String pass = "";
			if (rs.next()) { // Loop to get all result sets
				pass = rs.getString("pass");
				if(pass.equals(password)) {
					return true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
=======
	public String getPostID(String UserID, String ClassID, String title, String post){
		try {
			PreparedStatement ps;
			ps = conn.prepareStatement(getPostID);
			ps.setString(1, UserID);
			ps.setString(2, ClassID);
			ps.setString(3, title);
			ResultSet rs = ps.executeQuery();
			String postID = "";
			if (rs.next()) { // Loop to get all result sets
				postID = rs.getString(1);
			}
			return postID;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
>>>>>>> 92cf105163970ee5beb958dbe02f1704a4020217
	}
}
