<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sql.SQLConnection" %>
<%@ page import="notifications.*, users.*, java.util.Collections" %>
<%@ page import="java.util.ArrayList" %>

<%	
	SQLConnection sqlCon = new SQLConnection();
	sqlCon.connect();
	
 	RegisteredUser curruser = (RegisteredUser) session.getAttribute("currUser");
	String username = curruser.getUsername();
	ArrayList<Notification> notifs = sqlCon.getNotifs(username);
	Collections.sort(notifs);//to sort by date
	
	sqlCon.stop();
%>
<html>
	<head>
		<title>Whiteboard</title>
		<script src="https://use.typekit.net/ofv3bwh.js"></script>
		<script>try{Typekit.load({ async: true });}catch(e){}</script>
		<script src="../js/forum.js"></script>
		<link href="../css/forum.css" rel="stylesheet" type="text/css">
		<link href="../css/whiteboard.css" rel="stylesheet" type="text/css">
		<link href="../css/font-awesome.css" rel="stylesheet" type="text/css">
		<link href="../css/homepage.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<header>
			<div class="header__wrapper">
				<div class="header__logo-container">
					<a class="logo-container__logo" href="../jsp/homepage.jsp"></a>
				</div>
				<ul class="header__navigation-container">
					<li><button class="navigation__search"><i class="fa fa-search"></i></button></li>
					<li><a class="navigation__courses">Courses</a></li>
					<li><a class="navigation__settings">Settings</a></li>
				</ul>
			</div>
		</header>	
		
		<br>
		<h1>Welcome, <%=username %></h1>
	
		<div id = "container">	
			<div id="leftside">
				<ul id = "notif-list" style = "list-style: none;">
					<li><div id="error" style="color:red; font-size: 12px;"> </div></li>
					<% for(Notification n : notifs){ 
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
							<%} %>							
						</li>
					<%} %>
				</ul>	
			</div>	
			<div id = "rightside">
				<div id = "mycourses">
					<h1>My Courses</h1>
					<h3><a href = "../jsp/forum.jsp?classID=1">CSCI201</a></h3>
					
					<br>
					<h1>Moderating</h1>
					<h3>CSCI270</h3>
				</div>
			</div>
		</div>
	</body>
</html>