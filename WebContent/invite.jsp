<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Invitaions</title>
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
	<!-- <%!int i = 1;%> -->
	<%
		String se = (String) session.getAttribute("email");
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				Statement st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				ResultSet rs = st.executeQuery("select employeename,project,employeeemail from projectrequests where manageremail='" + se + "'");
				if (rs.next() == false) {
	%>
	<div class="alert"><%="No invitations sent!!"%></div>
	<%
		return;
				} else {
	%>
	<div class="invitation">
		<p>
			<u>Invitations Sent:</u>
		</p>
	</div>
	<table>
		<tr>
			<!-- <th>Sl. No.</th> -->
			<th>Employee Name</th>
			<th>Project</th>
			<th>Email-ID</th>
			<th>Action</th>
		</tr>
		<%
			rs.first();
					}
					do {
		%>
		<tr>
			<!-- <td align="center"><%=i + "."%></td> -->
			<td><%=rs.getString(1)%></td>
			<td><%=rs.getString(2)%></td>
			<td><%=rs.getString(3)%></td>
			<td><a href="cancelInvite.jsp?eid=<%=rs.getString(3)%>">Cancel</a></td>
		</tr>
		<!-- <%i++;%> -->
		<%
			} while (rs.next());
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