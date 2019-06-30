<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Requests Received</title>
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
		String se = (String) session.getAttribute("email");
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				Statement st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				Statement st1 = con.createStatement();
				ResultSet rs = st.executeQuery("select u.name,pr.manageremail from users u,projectrequests pr where pr.employeeemail='" + se + "' and pr.manageremail=u.email");
				if (rs.next() == false) {
	%>
	<div class="alert"><%="No manager added you to any project!!"%></div>
	<%
		return;
				}
				rs.first();
	%>
	<div class="requests">
		<p>
			<u>Requests:</u>
		</p>
	</div>
	<table style="width: 40%">
		<%
			ResultSet rs1 = st1.executeQuery("select project,startdate,enddate from projectrequests where manageremail='" + rs.getString(2) + "' and employeeemail='" + se + "'");
					while (rs1.next()) {
		%>
		<tr>
			<td><%=rs.getString(1) + " has invited you to work on project " + rs1.getString(1)%></td>
			<td><a href="accept.jsp?memail=<%=rs.getString(2)%>&pro=<%=rs1.getString(1)%>&sdate=<%=rs1.getDate(2)%>&edate=<%=rs1.getDate(3)%>">Accept</a></td>
			<td><a href="reject.jsp?pro=<%=rs1.getString(1)%>">Reject</a></td>
		</tr>
		<%
			}
		%>
	</table>
	<%
		con.close();
				st.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
	%>
</body>
</html>