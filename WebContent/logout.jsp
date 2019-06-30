<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="css/index.css"/>
	<title>Logout</title>
</head>
<body>
	<%session.invalidate();
	RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
	rd.include(request,response);
	%>
<div class="alert">Logged Out Successfully!!</div>
</body>
</html>