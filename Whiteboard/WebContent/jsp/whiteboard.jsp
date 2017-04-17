<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sql.SQLConnection" %>
<%@ page import="notifications.*, users.*, java.util.Collections" %>

<%	
	RegisteredUser curUser = (RegisteredUser) session.getAttribute("currUser");
	String username = curUser.getUsername();

	SQLConnection sqlCon = new SQLConnection();
	sqlCon.connect();
	String classID = (String)request.getParameter("classID");
	String courseName = sqlCon.getcoursename(classID);
	sqlCon.stop();
%>

<html lang="en" dir="ltr">
	<head>
		<title>Whiteboard</title>
		<script src="https://use.typekit.net/ofv3bwh.js"></script>
		<script>try{Typekit.load({ async: true });}catch(e){}</script>

		<link href="../css/whiteboard.css" rel="stylesheet" type="text/css">
		<link href="../css/font-awesome.css" rel="stylesheet" type="text/css">
	</head>
	<body ontouchstart>
		<header>
			<div class="header__wrapper">
				<div class="header__logo-container">
					<a class="logo-container__logo" href="../jsp/homepage.jsp"></a>
				</div>
				<ul class="header__navigation-container">
					<li><button class="navigation__search"><i class="fa fa-search"></i></button></li>
					<li><a class="navigation__courses">Courses</a></li>
					<li><a class="navigation__settings">Settings</a></li>
					<li><a href="profile.jsp" class="navigation__settings">Profile</a></li>
				</ul>
			</div>
		</header>	
		<section class="tabs">
			<div class="tabs__wrapper">
				<h1><%= courseName %></h1>
				<ul class="tabs__container">
					<li><a href = "../html/Whiteboard.html?classID=<%=classID%>"><button class="tab__button tab__button--selected">Whiteboard</button></a></li>
				<li><a href = "forum.jsp?classID=<%=classID%>"><button class="tab__button">Forum</button></a></li>
				<li><a href = "../jsp/documents.jsp?classID=<%=classID%>"><button class="tab__button">Docs</button></a></li>
				</ul>
			</div>
		</section>
		<section class="whiteboard">
			<div class="whiteboard__toolbar-container">
				<button class="toolbar__color toolbar__color--black toolbar__color--selected" data-color="black"></button>
				<button class="toolbar__color toolbar__color--red" data-color="#DB0060"></button>
				<button class="toolbar__color toolbar__color--orange" data-color="#F0712B"></button>
				<button class="toolbar__color toolbar__color--green" data-color="#00DB92"></button>
				<button class="toolbar__color toolbar__color--blue" data-color="#0079DB"></button>
				<button class="toolbar__color toolbar__color--white" data-color="#EEE" data-width="50"></button>
			</div>
			<canvas id="whiteboard__canvas" width="500px" height="500px"></canvas>
		</section>

		<!-- BEGIN CHAT MODULE -->
		<section class="chat">
			<div class="chat__header"><h1>Chat</h1></div>
			<div class="chat__scrollview">
				<template class="chat__message">
					<h2 class="chat__message--sender">Sender</h2>
					<div class="chat__message--message">The quick brown fox jumps over the lazy dog</div>
				</template>
			</div>
			<div class="chat__input-container">
				<input class="chat__message-input" type="text" placeholder="Type a message..." />
				<button class="chat__message-send">Send</button>
			</div>
		</section>
		<!-- END CHAT MODULE -->

		<!-- Scripts -->
		<script src="../js/WBSocketMessage.js" type="text/javascript"></script>
		<script src="../js/whiteboard.js" type="text/javascript"></script>
		<script src="../js/chat.js" type="text/javascript"></script>
		<script type="text/javascript">
			let secure = (location.protocol === "https:") ? "s" : ""
			new Chat("ws" + secure + "://" + location.host + "/Whiteboard/server/v1/chat", `<%= username %>`)
		</script>
	</body>
</html>