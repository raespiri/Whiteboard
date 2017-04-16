<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sql.SQLConnection" %>
<%@ page import="content.Post" %>
<%@ page import="java.util.List, java.util.Collections" %>
<%
	SQLConnection sqlCon = new SQLConnection();
	sqlCon.connect();
	Post post = null;
	String classID = request.getParameter("classID");
	List<content.Post> replies=null;
	if(request.getParameter("postID") != null){
		String postID = request.getParameter("postID");
		post = sqlCon.getPost(postID);
		String title = post.getTitle();
		String body = post.getBody();
		replies = sqlCon.getReplies(postID);
		Collections.sort(replies);//to sort by date
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Whiteboard: <%=title %></title>
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
				<li><a href="profile.jsp" class="navigation__settings">Profile</a></li>
			</ul>
		</div>
	</header>
	<section class="tabs">
		<h1>CSCI 201</h1>
		<ul class="tabs__container">
			<li><a href = "../html/Whiteboard.html?classID=<%=classID%>"><button class="tab__button">Whiteboard</button></a></li>
			<li><a href = "forum.jsp?classID=<%=classID%>"><button class="tab__button tab__button--selected">Forum</button></a></li>
			<li><a href = "../jsp/documents.jsp?classID=<%=classID%>"><button class="tab__button">Docs</button></a></li>
		</ul>
	</section>
	<ul style = "list-style: none;">
		<li class="post-in-list">
			<div class = "ballot-box">
				<button class = "upvote-in-box" onclick = "upvote('<%=postID%>')">
					<i class="fa fa-arrow-up" aria-hidden="true"></i>
				</button>	
				<button class = "downvote-in-box">
					<i class="fa fa-arrow-down" aria-hidden="true" onclick = "downvote('<%=postID%>')"></i>
				</button>
			</div>	
			<img></img>
			<text class = "post-title-on-page"><%=title%></text><a> <%=body %></a>
		</li>
	<li>
		<input type ="hidden" id = "title" class = "title-input" value = "reply"/>
		<input type="text" id="body" class = "reply-input"  placeholder = "Reply to this Post."/>
		<input type="submit" name="Reply" onclick="reply('<%=postID %>')" class = "submit-reply-input"/>
	</li>
	<li style="margin-left:20%;">Answers sorted by best</li>
	<% 
	if(replies != null){
		for(content.Post reply : replies){ 
			int replyScore = reply.getScore();
			String replyTitle = reply.getTitle();
			String replyBody = reply.getBody();
			String replyPostID = reply.getContentID();
	%>
	<li class = "post-in-list">
		<button class = "upvote" onclick = "upvote('<%=replyPostID%>')">
			<i class="fa fa-arrow-up" aria-hidden="true"></i>
		</button>
		<button class = "downvote">
			<i class="fa fa-arrow-down" aria-hidden="true" onclick = "downvote('<%=replyPostID%>')"></i>
		</button>
		<text class = "score"> <%=replyScore %> </text>
		<text class = "post-title"><%=replyBody %></text>
	</li>
	<%}} %>
	</ul>
	
</body>
<script>
	function GetURLParameter(sParam){
	    var sPageURL = window.location.search.substring(1);
	    var sURLVariables = sPageURL.split('&');
	    for (var i = 0; i < sURLVariables.length; i++) 
	    {
	        var sParameterName = sURLVariables[i].split('=');
	        if (sParameterName[0] == sParam) 
	        {
	            return sParameterName[1];
	        }
	    }
	}
	function reply(parentID)
	{
		if(document.getElementById('body').value === "") {
			console.log("no body text");
		}
		else {
			console.log('replying');
			var url = "../ForumPostServlet?title="+document.getElementById('title').value+"&body="
					+document.getElementById('body').value+"&type=submit"+"&classID="+GetURLParameter("classID")+"&parentID="+parentID;
			var req = new XMLHttpRequest();
			req.open("GET", url, true);
			if(req.readyState == 4 && req.status == 200) { 
				console.log("sent to post servlet");
			}
			req.send(null);
		}
	}
</script>
</html>
<%}%>