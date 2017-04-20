 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sql.SQLConnection" %>
<%@ page import="content.Post" %>
<%@ page import="notifications.*, users.*" %>
<%@ page import="java.util.List, java.util.Collections" %>
<%
	RegisteredUser curUser = (RegisteredUser) session.getAttribute("currUser");
	if (curUser == null){
		response.sendRedirect("error.jsp");
		return;
	}
	String curUserName = curUser.getUsername();
	String curUserID = curUser.getUserID();
	SQLConnection sqlCon = new SQLConnection();
	sqlCon.connect();
	Post post = null;
	String classID = request.getParameter("classID");
	String courseName = sqlCon.getcoursename(classID);
	int score = 0;
	String userID = "";
	String username = curUserName;

	List<content.Post> replies=null;
	if(request.getParameter("postID") != null){
		String postID = request.getParameter("postID");
		post = sqlCon.getPost(postID);
		score = post.getScore();
		String title = post.getTitle();
		String body = post.getBody();
		userID = post.getUserID();
		username = sqlCon.getUsername(userID);
		String postername = sqlCon.getUsername(userID);
		replies = sqlCon.getReplies(postID);
		Collections.sort(replies);//to sort by date
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Whiteboard: <%=title %></title>
	<script src="https://use.typekit.net/ofv3bwh.js"></script>
	<script>try{Typekit.load({ async: true });}catch(e){}</script>
		<script src="../js/logout.js" type="text/javascript"></script>

	<meta name="viewport" content="initial-scale=1.0, user-scalable=yes, width=device-width">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<link rel="shortcut icon" href="/Whiteboard/favicon.png">

	<link href="../css/forum.css" rel="stylesheet" type="text/css">
	<link href="../css/chat.css" rel="stylesheet" type="text/css">
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
		<div class="tabs__wrapper">
			<h1><%= courseName %></h1>
			<ul style="position: relative: left:2%;" class="tabs__container">
				<li><a href="whiteboard.jsp?classID=<%=classID%>"><button class="tab__button">Whiteboard</button></a></li>
				<li><a href="forum.jsp?classID=<%=classID%>"><button class="tab__button tab__button--selected">Forum</button></a></li>
				<li><a href="documents.jsp?classID=<%=classID%>"><button class="tab__button">Docs</button></a></li>
			</ul>
		</div>
	</section>
	<div class="content-wrapper">
		<div class="post">
			<div class="post__vote-container">
				<button class="vote-arrow vote-arrow--upvote" onclick="upvote('<%=postID%>')">
					<i class="fa fa-chevron-up" aria-hidden="true"></i>
				</button>
				<text id="score<%=postID %>" class="score">
					<%=score %>
				</text>	
				<button class="vote-arrow vote-arrow--downvote">
					<i class="fa fa-chevron-down" aria-hidden="true" onclick="downvote('<%=postID%>')"></i>
				</button>
			</div>	
			<img></img>
			<div class="post__content-container">
				<a class="post__title"><%=title%></a>
				<div class="post__metadata">submitted by <a class="post__author"><%=postername %></a></div>
				<div class="post__body" ><%=body %></div>
			</div>
		</div>
		
		<%if(!curUserName.equals("guest")){%>
			<div class="submit-container submit-container--single">
				<div class="submit__input-wrapper">
					<input type="hidden" id="title" value="reply"/>
					<input type="text" id="body" class="submit__body-input" placeholder="Answer this question..."/>
				</div>
				<input type="submit" name="Reply" onclick="reply('<%=postID %>', '<%=curUserName %>')" class="submit__button"/>
			</div>
		<% }
		if(replies != null){
			for(content.Post reply : replies){ 
				int replyScore = reply.getScore();
				String replyTitle = reply.getTitle();
				String replyBody = reply.getBody();
				String replyPostID = reply.getContentID();
				String replyUserID = reply.getUserID();
				String replyUsername = sqlCon.getUsername(replyUserID);
		%>
		<div class="post">
			<div class="post__vote-container">
				<button class="vote-arrow vote-arrow--upvote" onclick="upvote('<%=replyPostID%>')">
					<i class="fa fa-chevron-up" aria-hidden="true"></i>
				</button>
				<text id="score<%=replyPostID%>" class="score"> <%=replyScore %> </text>
				<button class="vote-arrow vote-arrow--downvote">
					<i class="fa fa-chevron-down" aria-hidden="true" onclick="downvote('<%=replyPostID%>')"></i>
				</button>
			</div>
			<div class="post__content-container">
				<div class="post__metadata post__metadata--header"><a class="post__author"><%=replyUsername %></a></div>
				<text class="post__body"><%=replyBody %></text>

				<%if(sqlCon.isPrivileged(curUserID, request.getParameter("classID"))) { %>
					<button class="post__delete-button" onclick="deletePost('<%=replyPostID %>')"><i class="icon-remove-sign">&times;</i></button>
				<%} %>
			</div>
		</div>
		<%}} %>

	</div>
	
	<!-- Scripts -->
	<script src="../js/forum.js" type="text/javascript"></script>
	<script src="../js/forumPost.js" type="text/javascript"></script>
	<script src="../js/mod.js" type="text/javascript"></script>
</body>
</html>
<%}%>