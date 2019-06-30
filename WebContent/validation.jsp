<%@ page import="datahouse.*"%>

<jsp:useBean id="vip" class="datahouse.UserData" scope="session" />
<jsp:setProperty property="email" name="vip" />
<jsp:setProperty property="oldpassword" name="vip" />

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="index.css" />
<title>Welcome</title>
</head>
<body>
	<%
		if (LoginValidate.checkDetails(vip.getEmail(), vip.getOldpassword()) == true) {
			session.setAttribute("name", LoginValidate.name(vip.getEmail()));
			session.setAttribute("email", vip.getEmail());
			session.setAttribute("company", LoginValidate.company(vip.getEmail()));
			session.setAttribute("designation", LoginValidate.designation(vip.getEmail()));
			session.setMaxInactiveInterval(10 * 60);
			response.sendRedirect("welcome.jsp");
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.include(request, response);
	%>
	<div class="alert">Invalid user name or password!!</div>
	<%
		}
	%>
</body>
</html>