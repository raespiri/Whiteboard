<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Whiteboard</title>
	<link rel="stylesheet" type="text/css" href="../css/homepage.css"/>
	<link rel="stylesheet" href="../font-awesome-4.7.0/css/font-awesome.min.css">
	<script src="https://use.typekit.net/ofv3bwh.js"></script>
	<script>try{Typekit.load({ async: true });}catch(e){}</script>
</head>
<body>
	<ul>
		<li><img id="mainicon" src="../img/TextLogo@2x.png" style="width:200px"></img></li>
		<li><i class="fa fa-search" style="color:white"></i></li>
		<li><h3> Courses</h3></li>
		<li><h3>Settings</h3> </li>
	</ul>	
	
	<div id = "container">
	
		<div id="leftside">
			<div id="qbox">
				<form id="askquestion">
					<input type="text" id="questiontext" value="Ask a question...">
					<input type="submit">
				</form>	
			</div>
			<div id = "feed">
				<div>
					<h4>John Doe</h4>
					<p>Lorem ipsum dolor sit amet,
					consectetur adipiscing elit, sed do 
					eiusmod tempor incididunt ut labore et
					dolore magna aliqua. Ut enim ad minim veniam,
					</p>
				</div>
				
				<div>
					<h4>testtt</h4>
					<p>Lorem ipsum dolor sit amet,
					consectetur adipiscing elit, sed do 
					eiusmod tempor incididunt ut labore et
					dolore magna aliqua. Ut enim ad minim veniam,
					</p>
				</div>
			</div>
		</div>
		
		<div id = "rightside">
			<div id = "mycourses">
				<h1>My Courses</h1>
				<h3><a href = "../jsp/forum.jsp?classID=201">CSCI201</a></h3>
				
				<h1>Moderating</h1>
				<h3>CSCI270</h3>
			</div>
		</div>
	
	</div>
</body>
</html>