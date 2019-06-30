<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Add Project Info</title>
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
		String me = (String) session.getAttribute("email");
			String company = (String) session.getAttribute("company");
			String project = request.getParameter("project");
			String[] ee = request.getParameterValues("members");
			Date sdate = Date.valueOf(request.getParameter("startdate"));
			Date edate = Date.valueOf(request.getParameter("enddate"));
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				PreparedStatement pst = con.prepareStatement("insert into projectrequests values(?,?,?,?,?,?)");
				Statement st = con.createStatement();
				Statement st1 = con.createStatement();
				ResultSet rs1 = st1.executeQuery("select p.project from projectrequests p,users u where p.manageremail=u.email and u.company='" + company + "' and p.project='" + project + "'");
				if (rs1.next() == false) {
					rs1 = st1.executeQuery("select p.project from projectmembers p,users u where p.manageremail=u.email and u.company='" + company + "' and p.project='" + project + "'");
					if (rs1.next() == true) {
	%>
	<div class="alert"><%="Project Name already taken! Choose another!"%></div>
	<%
		return;
					}
				} else {
	%>
	<div class="alert"><%="Project Name already taken! Choose another!"%></div>
	<%
		return;
				}
				for (int i = 0; i < ee.length; i++) {
					ResultSet rs = st.executeQuery("select name from users where email='" + ee[i] + "'");
					rs.next();
					pst.setString(1, me);
					pst.setString(2, ee[i]);
					pst.setString(3, rs.getString(1));
					pst.setString(4, project);
					pst.setDate(5, sdate);
					pst.setDate(6, edate);
					pst.executeUpdate();

					PreparedStatement pst1 = con.prepareStatement("delete from companystaffs where email='" + ee[i] + "'");
					pst1.executeUpdate();
				}
	%>
	<div class="alert"><%="Request sent to the Members selected!!"%></div>
	<%
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