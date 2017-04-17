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
	String courseName = sqlCon.getcoursename(classID);
	int score = 0;
	List<content.Post> replies=null;
	if(request.getParameter("postID") != null){
		String postID = request.getParameter("postID");
		post = sqlCon.getPost(postID);
		score = post.getScore();
		String title = post.getTitle();
		String body = post.getBody();
		String userID = post.getUserID();
		String postername = sqlCon.getUsername(userID);
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
	<script src="../js/forum.js"></script>
</head>
<body>
	<header>
		<form action="../SearchServlet" method="get">
			<div class="header__wrapper">
				<div class="header__logo-container">
					<a class="logo-container__logo" href="../jsp/homepage.jsp"></a>
				</div>
				<ul class="header__navigation-container">
					<li><input style="float: left" type="text" name="searchField"></li>
					<li><button class="navigation__search" type="submit"><i class="fa fa-search"></i></button></li>
					<li><a class="navigation__courses">Courses</a></li>
					<li><a class="navigation__settings">Settings</a></li>
					<li><a href="profile.jsp" class="navigation__settings">Profile</a></li>
				</ul>
			</div>
		</form>	
	</header>
	<section class="tabs">
		<div class="tabs__wrapper">
			<h1><%= courseName %></h1>
			<ul style = "position: relative: left:2%;" class="tabs__container">
				<li><a href = "../html/Whiteboard.html?classID=<%=classID%>"><button class="tab__button">Whiteboard</button></a></li>
				<li><a href = "forum.jsp?classID=<%=classID%>"><button class="tab__button tab__button--selected">Forum</button></a></li>
				<li><a href = "../jsp/documents.jsp?classID=<%=classID%>"><button class="tab__button">Docs</button></a></li>
			</ul>
		</div>
	</section>
	<ul style = "list-style: none;">
		<li class="post-in-list" style="margin-top: 10px; background-color: #00DB92; min-height:200px; margin-bottom: 30px;">
			<div class = "ballot-box">
				<button class = "upvote-in-box" onclick = "upvote('<%=postID%>')">
					<i class="fa fa-arrow-up" aria-hidden="true"></i>
				</button>
				<text id="score<%=postID %>" class = "score-in-box">
					<%=score %>
				</text>	
				<button class = "downvote-in-box">
					<i class="fa fa-arrow-down" aria-hidden="true" onclick = "downvote('<%=postID%>')"></i>
				</button>
			</div>	
			<img></img>
			<a class = "post-title-on-page"><%=title%></a><br>
			<a style = "color: black; margin-left: 20px;">posted by: <%=postername %></a>
			<div class="post-body-box" ><%=body %></div>
		</li>
		<li><br></li>
	<li>
		<input type ="hidden" id = "title" class = "title-input" value = "reply"/>
		<input type="text" id="body" class = "reply-input"  placeholder = "Reply to this Post."/>
		<input type="submit" name="Reply" onclick="reply('<%=postID %>')" class = "submit-reply-input"/>
	</li>
	</ul>
	<ul id = "reply-list">
	<% 
	if(replies != null){
		for(content.Post reply : replies){ 
			int replyScore = reply.getScore();
			String replyTitle = reply.getTitle();
			String replyBody = reply.getBody();
			String replyPostID = reply.getContentID();
	%>
	<li>
		<button class = "upvote" onclick = "upvote('<%=replyPostID%>')">
			<i class="fa fa-arrow-up" aria-hidden="true"></i>
		</button>
		<button class = "downvote">
			<i class="fa fa-arrow-down" aria-hidden="true" onclick = "downvote('<%=replyPostID%>')"></i>
		</button>
		<text id = "score<%=replyPostID%>" class = "score"> <%=replyScore %> </text>
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
			req.onreadystatechange = function() {
				if(req.readyState == 4 && req.status == 200) { 
					
					var postID = req.responseText;
					console.log(postID);
					var list = document.getElementById('reply-list');
					var entry = document.createElement('li');
					entry.className = 'post-in-list';
					
					var body = document.getElementById('body').value;
					var bodyNode = document.createElement('text');
					bodyNode.className = 'post-title';
					bodyNode.innerHTML = body;
					
					var upButton = document.createElement('button');
					upButton.className = 'upvote';
					upButton.onclick = function(){upvote(postID)};
					var upArrow = document.createElement('i');
					upArrow.className = 'fa fa-arrow-up';
					upButton.appendChild(upArrow);
					entry.appendChild(upButton);
					
					var dButton = document.createElement('button');
					dButton.className = 'downvote';
					dButton.onclick = function(){downvote(postID)};
					var dArrow = document.createElement('i');
					dArrow.className = 'fa fa-arrow-down';
					dButton.appendChild(dArrow);
					entry.appendChild(dButton);
					
					var score = document.createElement('text');
					score.className = 'score';
					var scoreID = 'score'+postID;
					score.id = scoreID;
					score.innerHTML = '1';
					entry.appendChild(score);
					
					entry.appendChild(bodyNode);
					list.insertBefore(entry, list.childNodes[0]);
				}
			}
			req.send(null);
		}
	}
</script>
</html>
<%}%>