package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sql.SQLConnection;

/**
 * Servlet implementation class ForumServlet
 */
@WebServlet("/ForumServlet")
public class ForumServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForumServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    public List<content.Post> getPosts(String classID)
    {
		SQLConnection sqlCon = new SQLConnection();
		sqlCon.connect();
		return sqlCon.getPosts(Integer.parseInt(classID));
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("type").equals("submit"))
		{
			String title = request.getParameter("title"); //get title
	    	String body = request.getParameter("body"); //get body
	    	int classID = Integer.parseInt(request.getParameter("classID"));
			SQLConnection sqlCon = new SQLConnection();
			sqlCon.connect();
			sqlCon.addPost(classID, title, body);
			sqlCon.stop();
		}
		else
		{
			List<content.Post> posts = getPosts(request.getParameter("classID"));
			request.setAttribute("posts", posts);
	        request.getRequestDispatcher("/jsp/forum.jsp?classID="+request.getParameter("classID")).forward(request, response);
		}
	}
}
