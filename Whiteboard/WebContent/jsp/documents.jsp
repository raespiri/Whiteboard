<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sql.SQLConnection" %>
<%@ page import="content.File" %>
<%@ page import="java.util.ArrayList, java.util.Collections" %>

<%	
	SQLConnection sqlCon = new SQLConnection();
	sqlCon.connect();
	ArrayList<File> docs=null;
	int ClassID;
	String currclassID = "";
	if(session.getAttribute("currclassID") != null){
		currclassID = (String) session.getAttribute("currclassID");
		docs = sqlCon.getDocs(currclassID);
		Collections.sort(docs);//to sort by date
		//System.out.println(request.getParameter("currclassID") + "cid");
	}
	else{

		sqlCon.stop();
		response.sendRedirect("error.jsp");
	}
	sqlCon.stop();
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
					<li><a href="profile.jsp" class="navigation__settings">Profile</a></li>
				</ul>
			</div>
		</header>
		<section class="tabs">
			<h1>CSCI 201</h1>
			<ul class="tabs__container">
				<li><a href = "../html/Whiteboard.html?classID=<%=currclassID%>"><button class="tab__button">Whiteboard</button></a></li>
				<li><a href = "forum.jsp?classID=<%=currclassID%>"><button class="tab__button">Forum</button></a></li>
				<li><a href = "documents.jsp?classID=<%=currclassID%>"><button class="tab__button tab__button--selected">Docs</button></a></li>
			</ul>
		</section>
		<h3>File Upload:</h3>
		Select a document to upload: <br />
		<form action="../DocumentServlet" method="post" enctype="multipart/form-data">
			<input type="file" name="file" size="50" />
			<br />
			<input type="submit" value="Upload File" />
		</form>
		<table>
			
		</table>
	</body>
</html>