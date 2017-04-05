package users;

import java.util.Vector;

public class Instructor extends TeachersAssistant {
	
	private Vector<String> instructorClasses;
	
	{
		instructorClasses = new Vector<String>();
	}
	public Instructor() {
		// TODO Auto-generated constructor stub
	}
	
	public TeachersAssistant createTA(String classID, String userID) {
		return new TeachersAssistant(); // Skeleton stub
	}
}
