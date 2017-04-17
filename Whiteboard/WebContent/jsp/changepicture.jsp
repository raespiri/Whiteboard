<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="sql.SQLConnection" %>
<%@ page import="content.Post, users.*" %>
<%@ page import="java.util.List, java.util.Collections" %>

<%	
	SQLConnection sqlCon = new SQLConnection();
	sqlCon.connect();
	
	String username =null;
	//System.out.println("here1");
	RegisteredUser curruser = (RegisteredUser) session.getAttribute("currUser");
	//System.out.println(curruser.getUsername());
	if(curruser != null){
		username = curruser.getUsername();
	}
	else{
		sqlCon.stop();
		response.sendRedirect("error.jsp");
		return;
	}
	String userID = curruser.getUserID();
	String password = curruser.getPassword();
	String currimgURL = curruser.getImage();
	
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
		<link href="../css/chat.css" rel="stylesheet" type="text/css">
		<link href="../css/font-awesome.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="../css/loginpage.css" />		
		<script>
	    	function validate() {
	    		document.getElementById("success").innerHTML = "";
	    		document.getElementById("error").innerHTML = ""
    			var url = "../ChangePictureServlet?newimgURL="+document.getElementById('newimgURLField').value;
    			console.log(url);
    			// create AJAX request
	    		var req = new XMLHttpRequest();
	    		req.open("GET", url, true);
	    		req.onreadystatechange = function () {
	    			if(req.readyState == 4 && req.status == 200) { 
	    				if(req.responseText === "noerror") { //if there is no error
	    					document.getElementById("success").innerHTML = "Success! Picture changed!";
	    				}
	    			}
	    		}
	    		req.send(null);
	    	}
    	</script>
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
						<li><a href="courses.jsp" class="navigation__courses">Courses</a></li>
						<li><a href="settings.jsp" class="navigation__settings">Settings</a></li>
						<li><a href="profile.jsp" class="navigation__settings">Profile</a></li>
					</ul>
				</div>
			</form>	
		</header>		
		<%if(!username.equals("guest")){%>
		<section class="tabs">
			<h1>Change Profile Picture</h1>
			<h1>Upload a new picture.</h1>
			<h1 id="success" style="color:#00DB92"></h1>
		</section>
		
		<div id="main">
      		<h5 style="margin-bottom: 2px; text-align: left; color: white;">Current Image URL:</h5>
      		<h5 style="margin-bottom: 2px; text-align: left; color: white; width:100px"><%=currimgURL %></h5>
			<br>
			<br>
			<h5 style="margin: 0; text-align: left; color: white;">Enter a new Image URL:</h5>
			<input style="margin-top: 7px; width: 100%;" type="text" id="newimgURLField"/> <br />
			<button style= "margin-top: 10px; width: 100%" type="submit" name="Submit" onclick="validate()">Change</button>
			<div id="error" style="color:red; font-size: 12px;"></div>
      	</div>
      	<div id="foot"></div>
		<%} %>
	</body>
</html>