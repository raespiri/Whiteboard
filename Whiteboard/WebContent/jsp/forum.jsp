<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Whiteboard</title>

	<script src="https://use.typekit.net/ofv3bwh.js"></script>
	<script>try{Typekit.load({ async: true });}catch(e){}</script>

	<link href="../css/whiteboard.css" rel="stylesheet" type="text/css">
	<link href="../css/font-awesome.css" rel="stylesheet" type="text/css">
	<script>
    	function validate() {
			console.log("validating...");
    		if(document.getElementById('title').value === "" || document.getElementById('body').value === "") {
    			document.getElementById('error').innerHTML = "ERROR: One or more of the requested fields is empty";
    		}
    		else {
    			var url = "../ForumServlet?title="+document.getElementById('title').value+"&body="+document.getElementById('body').value;
    			// create AJAX request
	    		var req = new XMLHttpRequest();
	    		req.open("GET", url, true);
	    		req.onreadystatechange = function () {
	    			if(req.readyState == 4 && req.status == 200) { 
	    				if(req.responseText === "") {
	    					console.log("noError");
	    				}
	    				else {
	    					console.log(req.responseText);
	    					document.getElementById('error').innerHTML = req.responseText;
	    				}
	    			}
	    		}
	    		req.send(null);
    		}
    	}
   	</script>
</head>
<body>
<header>
	<div class="header__wrapper">
		<div class="header__logo-container">
			<div class="logo-container__logo"></div>
		</div>
		<ul class="header__navigation-container">
			<li><button class="navigation__search"><i class="fa fa-search"></i></button></li>
			<li><a class="navigation__courses">Courses</a></li>
			<li><a class="navigation__settings">Settings</a></li>
		</ul>
	</div>
</header>
<section class="tabs">
	<h1>CSCI 201</h1>
	<ul class="tabs__container">
		<li><button class="tab__button">Whiteboard</button></li>
		<li><button class="tab__button tab__button--selected">Forum</button></li>
		<li><button class="tab__button">Docs</button></li>
	</ul>
</section>
<ul style = "list-style: none;">
	<li>
		Post Title
		<div><input type = "text" id = "title"/></div>
		Post Body
		<div><input type="text" id="body" /></div>
		<input type="submit" name="submit" onclick="validate()"/>
	</li>
	<li><div id="error" style="color:red; font-size: 12px;"> </div></li>
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