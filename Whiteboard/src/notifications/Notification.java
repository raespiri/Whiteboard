package notifications;

/*
 * Notification Class
 */
public class Notification {
	private String actionType; // Type of action
	private String contentID; // Content key
	private String fname;
	private String lname;
	private String contentname;//name of actual content (e.g. filename)
	private String coursename;
	
	public Notification(String contentID, String actiontype, String fname, String lname, String coursename, String contentname ){
		this.contentID = contentID;
		this.actionType = actiontype;
		this.fname = fname;
		this.lname = lname;
		this.coursename = coursename;
		this.contentname = contentname;
	}
	
	// Getters and Setters
	public String getActionType() {
		return actionType;
	}
	
	public void setActionType(String actionType) {
		this.actionType = actionType;
	}
	
	public String getContentID() {
		return contentID;
	}
	
	public void setContentID(String contentID) {
		this.contentID = contentID;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

	public String getContentname() {
		return contentname;
	}

	public void setContentname(String contentname) {
		this.contentname = contentname;
	}

	public String getCoursename() {
		return coursename;
	}

	public void setCoursename(String coursename) {
		this.coursename = coursename;
	}
}
