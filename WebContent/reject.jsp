<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Reject</title>
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
			String name = (String) session.getAttribute("name");
			String company = (String) session.getAttribute("company");
			String pro = request.getParameter("pro");
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				PreparedStatement pst = con.prepareStatement("insert into companystaffs values(?,?,?)");
				pst.setString(1, se);
				pst.setString(2, company);
				pst.setString(3, name);
				int i = pst.executeUpdate();

				Statement st = con.createStatement();
				int j = st.executeUpdate("delete from projectrequests where employeeemail='" + se + "'and project='" + pro + "'");

				if (i != 0 && j != 0) {
	%>
	<div class="alert"><%="Request Rejected!!"%></div>
	<%
		}
				con.close();
				st.close();
				pst.close();
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		}
	%>
</body>
</html>