<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Accept</title>
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
			String memail = request.getParameter("memail");
			Date sdate = Date.valueOf(request.getParameter("sdate"));
			Date edate = Date.valueOf(request.getParameter("edate"));
			String pro = request.getParameter("pro");
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				PreparedStatement pst = con.prepareStatement("insert into projectmembers values(?,?,?,?,?,?)");
				pst.setString(1, memail);
				pst.setString(2, se);
				pst.setString(3, name);
				pst.setString(4, pro);
				pst.setDate(5, sdate);
				pst.setDate(6, edate);
				int i = pst.executeUpdate();

				Statement st = con.createStatement();
				int j = st.executeUpdate("delete from projectrequests where manageremail='" + memail + "' and project='" + pro + "' and employeeemail='" + se + "'");
				if (i != 0 && j != 0) {
	%>
	<!--RequestDispatcher rd=request.getRequestDispatcher("main.jsp");
				rd.include(request,response);%>-->
	<div class="alert"><%="You are now a member of " + pro + " project!!"%></div>
	<%
		RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
					rd.forward(request, response);
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