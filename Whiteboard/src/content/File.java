package content;

import java.sql.Date;

public class File extends Content {
	
	private String filename;
	private String type;
	private byte[] data;

	public File(String contentID, String userID, String classID, Date time, String filename, String type){
		super(contentID, userID, classID, time);
		this.filename = filename;
		this.type = type;
	}
}
