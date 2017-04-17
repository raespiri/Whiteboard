<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sql.SQLConnection" %>
<%@ page import="content.File" %>
<%@ page import="java.util.ArrayList, java.util.Collections" %>

<%	
	RegisteredUser curUser = (RegisteredUser) session.getAttribute("currUser");
	if (curUser == null) response.sendRedirect("error.jsp");
	
	SQLConnection sqlCon = new SQLConnection();
	sqlCon.connect();
	ArrayList<File> docs=null;
	int ClassID;
	String currclassID = "";
	String courseName = "";
	if (session.getAttribute("currclassID") != null){
		currclassID = (String) session.getAttribute("currclassID");
		docs = sqlCon.getDocs(currclassID);
		Collections.sort(docs);//to sort by date
		courseName = sqlCon.getcoursename(currclassID);
		//System.out.println(request.getParameter("currclassID") + "cid");
	} else {
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

		<meta name="viewport" content="initial-scale=1.0, user-scalable=yes, width=device-width">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<link rel="shortcut icon" href="/Whiteboard/favicon.png">

		<link href="../css/forum.css" rel="stylesheet" type="text/css">
		<link href="../css/whiteboard.css" rel="stylesheet" type="text/css">
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
		<section class="tabs">
			<div class="tabs__wrapper">
				<h1><%= courseName %></h1>
				<ul class="tabs__container">
					<li><a href = "whiteboard.jsp?classID=<%=currclassID%>"><button class="tab__button">Whiteboard</button></a></li>
					<li><a href = "forum.jsp?classID=<%=currclassID%>"><button class="tab__button">Forum</button></a></li>
					<li><a href = "documents.jsp?classID=<%=currclassID%>"><button class="tab__button tab__button--selected">Docs</button></a></li>
				</ul>
			</div>
		</section>
		<div id="fileUpload">
			<p id="uploadTitle">Upload your own documents:</p>
			<form action="/Whiteboard/DocumentServlet" method="post" enctype="multipart/form-data">
				<input id="choosefile" type="file" name="file" size="50" />
				<input id="submitfile" type="submit" value="Upload File" />
			</form>
		</div>
		<div id="docTitle">Uploaded Documents</div>
		<%
			SQLConnection sql = new SQLConnection();
			sql.connect();
			
			String courseID = (String) session.getAttribute("currclassID");
			ArrayList<File> Documents = sql.getDocuments(courseID);
			String file = "file://";
			for(int i = 0; i < Documents.size(); i++) {
		%>
		<div id="doc">
			<a href="<%=Documents.get(i).getFilepath() %>" download><b><%=Documents.get(i).getFilename()%></b></a>
					<br>
					<div id="timestamp">Uploaded: <%=Documents.get(i).getTimestamp()%></div>
		</div>
		<%	
			}
		%>

		<!-- Scripts -->
		<script src="../js/forum.js" type="text/javascript"></script>
		<script type="text/javascript" src="js/bootstrap-filestyle.min.js"> </script>
	</body>
</html>