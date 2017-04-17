<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sql.SQLConnection" %>
<%@ page import="content.Post" %>
<%@ page import="java.util.List, java.util.Collections" %>

<%	
	RegisteredUser curUser = (RegisteredUser) session.getAttribute("currUser");
	if (curUser == null) response.sendRedirect("error.jsp");
	
	SQLConnection sqlCon = new SQLConnection();
	sqlCon.connect();
	List<content.Post> posts=null;
	String classID = "";
	String courseName = "";
	if(request.getParameter("classID") != null){
		posts = sqlCon.getPosts(Integer.parseInt(request.getParameter("classID")));
		Collections.sort(posts);//to sort by date
		//System.out.println(request.getParameter("classID") + "cid");
		session = request.getSession();		
		session.setAttribute("currclassID", request.getParameter("classID")); // Set session attribute for guest user;
		classID = request.getParameter("classID");
		courseName = sqlCon.getcoursename(classID);
	}
	else{
		//System.out.println(session.getAttribute("currclassID") + "cci");
		if(session.getAttribute("currclassID") != null){
			String currclassID = (String) session.getAttribute("currclassID");
			posts = sqlCon.getPosts(Integer.parseInt(currclassID));
			Collections.sort(posts);//to sort by date
			classID = request.getParameter("classID");
		}
		else{
			sqlCon.stop();
			response.sendRedirect("error.jsp");
		}
	}
	
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
		<link href="../css/whiteboard.css" rel="stylesheet" type="text/css">
		<link href="../css/font-awesome.css" rel="stylesheet" type="text/css">
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
		<section class="tabs">
			<div class="tabs__wrapper">
				<h1><%= courseName %></h1>
				<ul class="tabs__container">
					<li><a href = "whiteboard.jsp?classID=<%=classID%>"><button class="tab__button">Whiteboard</button></a></li>
					<li><a href = "forum.jsp?classID=<%=classID%>"><button class="tab__button  tab__button--selected">Forum</button></a></li>
					<li><a href = "documents.jsp?classID=<%=classID%>"><button class="tab__button">Docs</button></a></li>
				</ul>
			</div>
		</section>
		<ul id = "post-list" style = "list-style: none;">
			<li class = "post-in-list">
				<input type = "text" id = "title" class = "title-input" placeholder = "Ask a Question..."/>
				<input type="text" id="body" class = "body-input"  placeholder = "Provide some more detail (Optional)."/>
				<input type="submit" name="submit" onclick="validate()" class = "submit-input"/>
			</li>
			<li><div id="error" style="color:red; font-size: 12px;"> </div></li>
			<% 
			if(posts != null){
				for(content.Post post : posts){ 
					int score = post.getScore();
					String title = post.getTitle();
					String postID = post.getContentID();
					String userID = post.getUserID();
					String username = sqlCon.getUsername(userID);
			%>
				<li class = "post-in-list">
					<button class = "upvote" onclick = "upvote('<%=postID%>')">
						<i class="fa fa-arrow-up" aria-hidden="true"></i>
					</button>
					<button class = "downvote">
						<i class="fa fa-arrow-down" aria-hidden="true" onclick = "downvote('<%=postID%>')"></i>
					</button>
					<text class = "score" id = "score<%=postID%>"> <%=score %> </text>
					<a href = "forumPost.jsp?postID=<%=postID %>&classID=<%=classID %>" class = "post-title"><%=title %></a><button class = 'delete-button' style = "float:right; display:none;">x</button><br>
					<a style = "position: relative; top:15px; margin-left: 18%; margin-top: 5px; color: black;">posted by: <%=username %></a>
				</li>
			<%} } %>
		</ul>

		<!-- Scripts -->
		<script src="../js/forum.js" type="text/javascript"></script>
	</body>
</html>