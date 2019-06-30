<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Update Progress</title>
</head>
<body>
	<%
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Expires", "0");
		response.setDateHeader("Expires", -1);
		if (session.getAttribute("email") == null) {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.include(request, response);
	%>
	<div class="logoutalert">You are not logged in! Please Login!</div>
	<%
		} else {
	%>
	<%@ include file="main.jsp"%>
	<%
		String project = request.getParameter("proid");
			String task = request.getParameter("task");
			String company = (String) session.getAttribute("company");
			String[] ee = request.getParameterValues("members");
			String s = null;
			String s1 = null;
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
	%>
	<form action="updateProgressSuccess.jsp">
		<table>
			<tr>
				<td><b>Enter Progress(%):</b></td>
				<td><input type="text" name="progress" required></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit"></td>
			</tr>
			<tr>
				<td><input type="hidden" value="<%=project%>" name="proid"></td>
				<td><input type="hidden" value="<%=task%>" name="task"></td>
			</tr>
		</table>
	</form>
	<%
		con.close();
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		}
	%>
</body>
</html>