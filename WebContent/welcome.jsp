<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="css/profile.css"/>
	<title>Welcome</title>
</head>
<body>
	<%response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Expires","0");
	response.setDateHeader("Expires",-1);
	if(session.getAttribute("email")==null){
		RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
		rd.include(request,response);%>
		<div class="alert">You are not logged in! Please Login!</div>
	<%}else{%>
		<%@ include file="main.jsp" %>
	<%}%>
</body>
</html>