<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<ul style = "list-style: none;">
	<li><form method = "GET" action = "forumServlet">
			<input type="text" name="name" />
			<input type="submit" name="submit" value="Submit" />
	</form></li>
	
	<li><span><button class = "vote-button" id = "upvote" >UP</button><button style = "position: relative; top:30" class = "vote-button" id = "downvote">DOWN</button>
		<img></img>
		<a>Title of the post</a><a> Text of the post</a>
	</span></li>
	
	<li><span><button class = "vote-button" id = "upvote" >UP</button><button style = "position: relative; top:30" class = "vote-button" id = "downvote">DOWN</button>
		<img></img>
		<a>Title of the post</a><a> Text of the post</a>
	</span></li>
	
	<li><span><button class = "vote-button" id = "upvote" >UP</button><button style = "position: relative; top:30" class = "vote-button" id = "downvote">DOWN</button>
		<img></img>
		<a>Title of the post</a><a> Text of the post</a>
	</span></li>
</ul>
</body>
</html>