<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Courses</title>
	<script src="https://use.typekit.net/ofv3bwh.js"></script>
	<script>try{Typekit.load({ async: true });}catch(e){}</script>

	<meta name="viewport" content="initial-scale=1.0, user-scalable=yes, width=device-width">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<link rel="shortcut icon" href="/Whiteboard/favicon.png">

	<link href="../css/forum.css" rel="stylesheet" type="text/css">
	<link href="../css/chat.css" rel="stylesheet" type="text/css">
	<link href="../css/font-awesome.css" rel="stylesheet" type="text/css">
	<link href="../css/documents.css" rel="stylesheet" type="text/css">
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
						<li><a class="navigation__courses">Courses</a></li>
						<li><a href="settings.jsp" class="navigation__settings">Settings</a></li>
						<li><a href="profile.jsp" class="navigation__settings">Profile</a></li>
					</ul>
				</div>
			</form>				
		</header>
		<table>
			<%= %>
			<tr><td> </td></tr>
		</table>
	</body>
</html>