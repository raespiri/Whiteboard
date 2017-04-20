<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sql.SQLConnection" %>
<%@ page import="notifications.*, users.*, java.util.Collections" %>
<%@ page import="java.util.ArrayList" %>

<%	
	SQLConnection sqlCon = new SQLConnection();
	sqlCon.connect();
	
	String username =null;
	//System.out.println("here1");
	RegisteredUser curruser = (RegisteredUser) session.getAttribute("currUser");
	//System.out.println(curruser.getUsername());
	if(curruser != null){
		username = curruser.getUsername();
	}
	else{
		sqlCon.stop();
		response.sendRedirect("error.jsp");
		return;
	}


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
		<link href="../css/partials/main.css" rel="stylesheet" type="text/css">
		<link href="../css/font-awesome.css" rel="stylesheet" type="text/css">
	</head>
<body>
	<header>
		<div class="header__wrapper">
			<div class="header__logo-container">
				<a class="logo-container__logo" href="../jsp/homepage.jsp"></a>
			</div>
			<ul class="header__navigation-container">
				<li class="navigation__search">
					<form action="/Whiteboard/SearchServlet" method="get">
						<input type="text" name="searchField" placeholder="Search...">
						<button class="navigation__search" type="submit"><i class="fa fa-search"></i></button>
					</form>
				</li>
				<li><a href="courses.jsp" class="navigation__courses">Courses</a></li>
				<li><a href="settings.jsp" class="navigation__settings">Settings</a></li>
				<li><a href="profile.jsp" class="navigation__settings">Profile</a></li>
				<li><button onclick="logout()" class="navigation__logout"><i class="fa fa-sign-out"  aria-hidden="true"></i></button></li>
			</ul>
		</div>
	</header>
	
	<section class="tabs">
		<div class="tabs__wrapper tabs__wrapper--vertical">
			<h1>Settings</h1>
			<ul class="tabs__container tabs__container--vertical">
				<li><a href="changepassword.jsp"><button class="tab__button tab__button--selected">Change Password</button></a></li>
				<li><a href="changepicture.jsp"><button class="tab__button tab__button--selected">Change Profile Picture</button></a></li>
				<li><a href="deleteaccount.jsp"><button class="tab__button tab__button--selected tab__button--warning">Delete Account</button></a></li>
			</ul>
		</div>
	</section>
	
	<!-- Scripts -->
	<script src="../js/forum.js" type="text/javascript"></script>
	
</body>