<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sql.SQLConnection" %>
<%@ page import="notifications.*, users.*, java.util.Collections" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Vector" %>
<%@ page import="course.*" %>

<%	
	SQLConnection sqlCon = new SQLConnection();
	sqlCon.connect();
	ArrayList<Notification> notifs=null;
	String username =null;
	//System.out.println("here1");
 	RegisteredUser curruser = (RegisteredUser) session.getAttribute("currUser");

 	try{
 		curruser.getUserID();
 		curruser.getUsername();
 	}
 	catch(NullPointerException e){
 		sqlCon.stop();
 		response.sendRedirect("error.jsp");
 		return;
 	}

 		username = curruser.getUsername();
 		notifs = sqlCon.getNotifs(username);
 		Collections.sort(notifs);//to sort by date	 	
		sqlCon.stop();
%>
<html>
	<head>
		<title>Whiteboard</title>
		<script src="https://use.typekit.net/ofv3bwh.js"></script>
		<script>try{Typekit.load({ async: true });}catch(e){}</script>

		<meta name="viewport" content="initial-scale=1.0, user-scalable=yes, width=device-width">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<link rel="shortcut icon" href="/Whiteboard/favicon.png">

		<link href="../css/forum.css" rel="stylesheet" type="text/css">
		<link href="../css/chat.css" rel="stylesheet" type="text/css">
		<link href="../css/font-awesome.css" rel="stylesheet" type="text/css">
		<link href="../css/homepage.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<header>
			<form action="/Whiteboard/SearchServlet" method="get">
				<div class="header__wrapper">
					<div class="header__logo-container">
						<a class="logo-container__logo" href="../jsp/homepage.jsp"></a>
					</div>
					<ul class="header__navigation-container">
						<li><input style="float: left" type="text" name="searchField"></li>
						<li><button class="navigation__search" type="submit"><i class="fa fa-search"></i></button></li>
						<li><a href="courses.jsp" class="navigation__courses">Courses</a></li>
						<li><a href="settings.jsp" class="navigation__settings">Settings</a></li>
						<li><a href="profile.jsp" class="navigation__settings">Profile</a></li>
					</ul>
				</div>
			</form>	
		</header>	
		
		<br>
		<h1>Welcome, <%=username %></h1>
	
		<div id = "container">	
			<div id="leftside">
				<ul id = "notif-list" style = "list-style: none;">
					<li><div id="error" style="color:red; font-size: 12px;"> </div></li>
					<% 	if(notifs != null){
							for(Notification n : notifs){ 
							String title = n.getContentname();
							String fullname = n.getFullname();
							String actiontype = n.getActionType();
							String coursename = n.getCoursename();
					%>
						<li class = "notif-in-list">
							<text class = "notif-name"><%=fullname %></text>
							<%if( actiontype.equals("Post")){%>
								posted in
								<text class = "notif-title"><%=coursename %></text>
								<br>
								<text class = "notif-title"><%=title %></text>
							<%}} %>							
						</li>
					<%} %>
				</ul>	
			</div>	
			<div id = "rightside">
				<div id = "mycourses">
					<h1>My Courses</h1>
					<%
						SQLConnection sql = new SQLConnection();
						sql.connect();
						int UserID = Integer.parseInt(curruser.getUserID());
						Vector<Course> courses  = sql.getUserCourses(UserID);
						for(int i = 0; i < courses.size(); i++) {
					%>
							<h3><a href = "forum.jsp?classID=<%= courses.get(i).getCourseID() %>"><%=courses.get(i).getName() %></a></h3>
					<% 
						}
					%>					
					<br>
					<h1>Moderating</h1>
					<h3>CSCI270</h3>
				</div>
			</div>
		</div>

		<!-- Scripts -->
		<script src="../js/forum.js" type="text/javascript"></script>
	</body>
</html>