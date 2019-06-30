<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Remove Members Success</title>
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
			String company = (String) session.getAttribute("company");
			String project = request.getParameter("proid");
			String[] ee = request.getParameterValues("members");
			String s = null;
			String s1 = null;
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				Statement st = con.createStatement();
				ResultSet rs;
				ResultSet rs1;
				for (int i = 0; i < ee.length; i++) {
					PreparedStatement pst = con.prepareStatement("insert into companystaffs values(?,?,?)");
					st.executeUpdate("delete from projectmembers where employeeemail='" + ee[i] + "' and project='" + project + "'");
					rs = st.executeQuery("select name from users where email='" + ee[i] + "'");
					rs.next();
					pst.setString(1, ee[i]);
					pst.setString(2, company);
					pst.setString(3, rs.getString(1));
					pst.executeUpdate();

					s = rs.getString(1);
					rs = st.executeQuery("select responsible,task from tasks where company='" + company + "' and project='" + project + "'");
					while (rs.next()) {
						if (rs.getString(1).indexOf(s + ',') != -1) {
							s1 = rs.getString(1).replace(s + ',', "");
							pst = con.prepareStatement("update tasks set responsible='" + s1 + "' where responsible='" + rs.getString(1) + "' and company='" + company + "' and project='" + project + "'");
							pst.executeUpdate();
						} else if (rs.getString(1).indexOf(',' + s) != -1) {
							s1 = rs.getString(1).replace(',' + s, "");
							pst = con.prepareStatement("update tasks set responsible='" + s1 + "' where responsible='" + rs.getString(1) + "' and company='" + company + "' and project='" + project + "'");
							pst.executeUpdate();
						} else if (rs.getString(1).indexOf(s) != -1) {
							Statement st1 = con.createStatement();
							st1.executeUpdate("delete from tasks where responsible='" + rs.getString(1) + "' and company='" + company + "' and project='" + project + "'");
							st1.executeUpdate("delete from progresshistory where company='" + company + "' and project='" + project + "' and task='" + rs.getString(2) + "'");
						}
					}
				}
	%>

	<!-- RequestDispatcher rd=request.getRequestDispatcher();
			rd.include(request,response);
			<div class="alert"><%="Selected Members Removed!!"%></div> -->

	<%
		RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
				rd.forward(request, response);
				con.close();
				st.close();
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		}
	%>
</body>
</html>