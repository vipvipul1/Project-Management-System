<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Progress History</title>
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
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select progress,time from progresshistory where company='" + company + "' and project='" + project + "' and task='" + task + "'");
	%>
	<table>
		<tr>
			<th>Progress(%)</th>
			<th>Time</th>
		</tr>
		<%
			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString(1)%></td>
			<td><%=rs.getString(2)%></td>
		</tr>
		<%
			}
					con.close();
					st.close();
				} catch (Exception e) {
					out.println(e.getMessage());
				}
		%>
	</table>
	<%
		}
	%>
</body>
</html>