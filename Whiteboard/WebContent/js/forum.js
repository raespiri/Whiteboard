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
function validate() {
	console.log("validating...");
	if(document.getElementById('title').value === "" || document.getElementById('body').value === "") {
		document.getElementById('error').innerHTML = "ERROR: One or more of the requested fields is empty";
	}
	else {
		var url = "../ForumServlet?title="+document.getElementById('title').value+"&body="
				+document.getElementById('body').value+"&type=submit"+"&classID="+GetURLParameter("classID");
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