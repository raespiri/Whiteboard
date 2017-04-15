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
<title>Insert title here</title>
</head>
<body>
	<ul style = "list-style: none;">
		<li><span><button class = "vote-button" id = "upvote" >UP</button><button style = "position: relative; top:30" class = "vote-button" id = "downvote">DOWN</button>
		<img></img>
		<a><%=title%></a><a> <%=body %></a>
	</span></li>
	<li>
		<input type ="hidden" id = "title" class = "title-input" value = "reply"/>
		<input type="text" id="body" class = "body-input"  placeholder = "Reply to this Post."/>
		<input type="submit" name="Reply" onclick="reply('<%=postID %>')" class = "submit-input"/>
	</li>
	<li>Answers sorted by best</li>
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