<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sql.SQLConnection" %>
<%@ page import="notifications.*, users.*" %>
<%@ page import="java.util.ArrayList" %>

<%	
	SQLConnection sqlCon = new SQLConnection();
	sqlCon.connect();
	
 	RegisteredUser curruser = (RegisteredUser) session.getAttribute("currUser");
	String username = curruser.getUsername();
	ArrayList<Notification> notifs = sqlCon.getNotifs(username);
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
		
		<h1>Welcome,</h1>
		<%=username %>
	
	<div id = "container">
	
		<div id="leftside">
			<div id="qbox">
				<form id="askquestion">
					<input type="text" id="questiontext" value="Ask a question...">
					<input type="submit">
				</form>	
			</div>
			<div id = "feed">
				<div>
					<h4>John Doe</h4>
					<p>Lorem ipsum dolor sit amet,
					consectetur adipiscing elit, sed do 
					eiusmod tempor incididunt ut labore et
					dolore magna aliqua. Ut enim ad minim veniam,
					</p>
				</div>
				
				<div>
				<br>
					<h4>testtt</h4>
					<p>Lorem ipsum dolor sit amet,
					consectetur adipiscing elit, sed do 
					eiusmod tempor incididunt ut labore et
					dolore magna aliqua. Ut enim ad minim veniam,
					</p>
				</div>
			</div>
		</div>
		
		<div id = "rightside">
			<div id = "mycourses">
				<h1>My Courses</h1>
				<h3><a href = "../jsp/forum.jsp?classID=201">CSCI201</a></h3>
				
				<h1>Moderating</h1>
				<h3>CSCI270</h3>
			</div>
		</div>
	
	</div>
</body>
</html>