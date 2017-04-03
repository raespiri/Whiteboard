package notifications;

public class Notification {
	private String actionType; // Type of action
	private String contentID; // Content key
	
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
}
