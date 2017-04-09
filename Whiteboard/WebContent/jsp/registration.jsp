<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Registration</title>
		<link rel="stylesheet" type="text/css" href="../css/Registration.css"/>
	</head>
	<body>
    	<div class="wrapper">
      		<div id="header">
				<h5 style="padding-bottom: 1cm;">Please enter your information.</h5>
      		</div>
      	</div>
      	<div id="main">
			<input style="margin-bottom: 7px; margin-top: 7px; width: 100%;" type="text" id="fullname" onfocus="if (this.value=='Full Name') this.value = ''" value="Full Name"/>
			<input style="margin-bottom: 7px; margin-top: 7px; width: 100%;" type="text" id="username" onfocus="if (this.value=='Username') this.value = ''" value="Username"/>
			<input style="margin-bottom: 7px; margin-top: 7px; width: 100%;" type="text" id="password" onfocus="if (this.value=='Password') this.value = ''" value="Password"/>
			<input style="margin-bottom: 7px; margin-top: 7px; width: 100%;" type="text" id="imageurl" onfocus="if (this.value=='Image URL') this.value = ''" value="Image URL"/>
			<button style= "margin-top: 10px; width: 100%; color: black;" type="submit" name="signup" onclick="validate()">Sign Up</button>
			<div id="error" style="color:red; font-size: 12px;"> </div>
      	</div>
  	</body>
</html>