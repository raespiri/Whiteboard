package servlets;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import sql.SQLConnection;

/**
 * Servlet implementation class DocumentServlet
 */
@WebServlet("/DocumentServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
maxFileSize=1024*1024*10,      // 10MB
maxRequestSize=1024*1024*50)   // 50MB
public class DocumentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DocumentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String CourseID = (String) session.getAttribute("currclassID");
		
		SQLConnection sqlCon = new SQLConnection(); 
		sqlCon.connect();
		String courseName = sqlCon.getcoursename(CourseID);
		
		// constructs the directory path to store upload file
	    String uploadPath = getServletContext().getRealPath("") + "docUploads";

	    // Create docUploads folder if it doesn't exist
	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) {
	        uploadDir.mkdir();
	    }
	 
	    uploadPath += "/" + courseName;
	    
		 // Create course folder if it doesn't exist
	    File real_uploadDir = new File(uploadPath);
	    if (!real_uploadDir.exists()) {
	        real_uploadDir.mkdir();
	    }
	    
	    for (Part part : request.getParts()) { // loop through parts and get filename
	        String fileName = getFileName(part);
	        fileName = new File(fileName).getName();
	        part.write(uploadPath + File.separator + fileName); // Write file
	    }
		response.sendRedirect("jsp/documents.jsp"); //redirect to documents page

	}
	
	private String getFileName(Part part) {
	    String contentDisp = part.getHeader("content-disposition");
	    String[] items = contentDisp.split(";");
	    for (String s : items) {
	        if (s.trim().startsWith("filename")) {
	            return s.substring(s.indexOf("=") + 2, s.length()-1);
	        }
	    }
	    return "";
	}
}
