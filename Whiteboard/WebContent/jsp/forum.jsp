<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sql.SQLConnection" %>
<%@ page import="content.Post" %>
<%@ page import="java.util.List" %>

<%	
	SQLConnection sqlCon = new SQLConnection();
	sqlCon.connect();
	
	List<content.Post> posts = sqlCon.getPosts(Integer.parseInt(request.getParameter("classID")));
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
		<section class="tabs">
			<h1>CSCI 201</h1>
			<ul class="tabs__container">
				<li><button class="tab__button">Whiteboard</button></li>
				<li><button class="tab__button tab__button--selected">Forum</button></li>
				<li><button class="tab__button">Docs</button></li>
			</ul>
		</section>
		<ul id = "post-list" style = "list-style: none;">
			<li class = "post-in-list">
				<input type = "text" id = "title" class = "title-input" placeholder = "Ask a Question..."/>
				<input type="text" id="body" class = "body-input"  placeholder = "Provide some more detail (Optional)."/>
				<input type="submit" name="submit" onclick="validate()" class = "submit-input"/>
			</li>
			<li><div id="error" style="color:red; font-size: 12px;"> </div></li>
			<% for(content.Post post : posts){ 
				int score = post.getScore();
				String title = post.getTitle();
			%>
				<li class = "post-in-list"><button class = "upvote" ><i class="fa fa-arrow-up" aria-hidden="true"></i></button><button class = "downvote"><i class="fa fa-arrow-down" aria-hidden="true"></i></button>
				<text class = "score"><%=score %></text><a class = "post-title"><%=title %></a></li>
			<%} %>
		</ul>
	</body>
</html>