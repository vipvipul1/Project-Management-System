<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Members</title>
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
			String desig = (String) session.getAttribute("designation");
			String email = (String) session.getAttribute("email");
	%>
	<div class="members">
		<u>Members:</u>
		<%
			if ("Manager".equals(desig)) {
		%>
		<a href="addMembers.jsp?proid=<%=project%>">Add Members</a> <a href="removeMembers.jsp?proid=<%=project%>">Remove Members</a>
		<%
			}
		%>
	</div>
	<%
		try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				Statement st = con.createStatement();
				Statement st1 = con.createStatement();
				ResultSet rs = null;
				ResultSet rs1;
				if ("Employee".equals(desig)) {
					rs = st.executeQuery("select pm.manageremail,u.name from projectmembers pm,users u where pm.employeeemail='" + email + "' and u.email=pm.manageremail");
					rs.next();
					rs1 = st1.executeQuery("select employeename,employeeemail from projectmembers where manageremail='" + rs.getString(1) + "' and project='" + project + "'");
				} else {
					rs = st.executeQuery("select pm.manageremail,u.name from projectmembers pm,users u where pm.manageremail='" + email + "' and u.email=pm.manageremail");
					rs.next();
					rs1 = st1.executeQuery("select employeename,employeeemail from projectmembers where manageremail='" + email + "' and project='" + project + "'");
				}
	%>
	<table>
		<tr>
			<th>Name</th>
			<th>Email</th>
		</tr>
		<tr>
			<td><%=rs.getString(2) + " (manager)"%></td>
			<td><%=rs.getString(1)%></td>
		</tr>
		<%
			while (rs1.next()) {
		%>
		<tr>
			<td><%=rs1.getString(1)%></td>
			<td><%=rs1.getString(2)%></td>
		</tr>
		<%
			}
		%>
	</table>
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