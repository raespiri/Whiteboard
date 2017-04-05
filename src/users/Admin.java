package users;

public class Admin extends Moderator {

	public Admin() {
		// TODO Auto-generated constructor stub
	}
	
	public Moderator createMod(String userID) {
		return new Moderator(); // Skeleton stub
	}
	
	public Course createCourse() {
		return new Course();
	}
	
	public void deleteCourse(String classID) {
		
	}
}
