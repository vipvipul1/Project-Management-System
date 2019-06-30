<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Remove Members</title>
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
	<div class="projectDetails">
		<p>
			<u>Members:</u>
		</p>
	</div>
	<%
		String se = (String) session.getAttribute("email");
			String project = request.getParameter("proid");
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select employeeemail,employeename from projectmembers where manageremail='" + se + "' and project='" + project + "'");
	%>
	<form action="removeMembersSuccess.jsp">
		<table style="width: 20%">
			<tr>
				<td><input type="hidden" name="proid" value="<%=project%>" /></td>
			</tr>
			<%
				while (rs.next()) {
			%>
			<tr>
				<td><input type="checkbox" name="members" value="<%=rs.getString(1)%>" /><%=rs.getString(2) + " - " + rs.getString(1)%></td>
			</tr>
			<%
				}
			%>
			<tr>
				<td align="center"><input type="submit" value="Remove" /></td>
			</tr>
		</table>
	</form>
	<%
		con.close();
				st.close();
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		}
	%>
</body>
</html>