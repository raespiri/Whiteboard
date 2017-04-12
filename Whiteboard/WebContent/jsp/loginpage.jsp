<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  	<head>
    	<title>Login Menu</title>
    	<script src="https://use.typekit.net/ofv3bwh.js"></script>
		<script>try{Typekit.load({ async: true });}catch(e){}</script>
		<link href="../css/whiteboard.css" rel="stylesheet" type="text/css">
		<link href="../css/font-awesome.css" rel="stylesheet" type="text/css">
    	<link rel="stylesheet" type="text/css" href="../css/loginpage.css" />
    	<script>
	    	function validate() {
    			var url = "../LoginServlet?usernameField="+document.getElementById('usernameField').value+"&passwordField="+document.getElementById('passwordField').value;
    			// create AJAX request
	    		var req = new XMLHttpRequest();
	    		req.open("GET", url, true);
	    		req.onreadystatechange = function () {
	    			if(req.readyState == 4 && req.status == 200) { 
	    				if(req.responseText === "No Error") { //if there is no error
	    					approve(); //approve login credentials
	    				}
	    				else { //else print error
	    					document.getElementById("error").innerHTML = req.responseText;
	    				}
	    			}
	    		}
	    		req.send(null);
	    	}
	    	function approve() {
	    		var url = "homepage.jsp";
	    		document.location.href = url;
	    	}
    	</script>
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
				</ul>
			</div>
		</header>	
      	<div id="main">
      		<h5 style="margin-bottom: 2px; text-align: left; color: white;">Username</h5>
			<input style="margin-bottom: 7px; margin-top: 7px; width: 100%;" type="text" id="usernameField"/>
			<h5 style="margin: 0; text-align: left; color: white;">Password</h5>
			<input style="margin-top: 7px; width: 100%;" type="password" id="passwordField"/> <br />
			<button style= "margin-top: 10px; width: 100%" type="submit" name="login" onclick="validate()">Log In</button>
			<div id="error" style="color:red; font-size: 12px;"></div>
      	</div>
      	<div id="foot">
      	</div>
  	</body>
</html>