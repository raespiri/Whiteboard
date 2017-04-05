package course;

import java.util.Vector;

import content.File;
import content.Message;
import content.Post;
import content.Whiteboard;

public class Course {
	
	private int courseID;
	
	private Vector<String> students;
	private Vector<Post> forum;
	private Vector<Whiteboard> whiteboards;
	private Vector<Message> chat;
	private Vector<File> files;
	
	public Course(int courseID){
		this.courseID = courseID;
	}
}
