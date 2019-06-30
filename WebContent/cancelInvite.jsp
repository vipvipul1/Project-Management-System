<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Cancel Invite</title>
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
		String eid = request.getParameter("eid");
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				PreparedStatement pst = con.prepareStatement("delete from projectrequests where employeeemail='" + eid + "'");
				pst.executeUpdate();
				Statement st1 = con.createStatement();
				ResultSet rs1 = st1.executeQuery("select email,company,name from users where email='" + eid + "'");
				rs1.next();
				PreparedStatement pst1 = con.prepareStatement("insert into companystaffs values(?,?,?)");
				pst1.setString(1, rs1.getString(1));
				pst1.setString(2, rs1.getString(2));
				pst1.setString(3, rs1.getString(3));
				pst1.executeUpdate();

				con.close();
				pst.close();
			} catch (Exception e) {
				out.println(e.getMessage());
			}
	%>
	<div class="alert"><%="Invitation Canceled!!"%></div>
	<%
		}
	%>
</body>
</html>