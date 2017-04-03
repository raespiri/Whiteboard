package content;

import java.sql.Date;

public class Content {
	private String contentID;
	private String userID;
	private String classID;
	private Date time;
	
	public Content(String contentID, String userID, String classID, Date time)
	{
		this.setContentID(contentID);
		this.setUserID(userID);
		this.setClassID(classID);
		this.setTime(time);
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getClassID() {
		return classID;
	}

	public void setClassID(String classID) {
		this.classID = classID;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getContentID() {
		return contentID;
	}

	public void setContentID(String contentID) {
		this.contentID = contentID;
	}
}