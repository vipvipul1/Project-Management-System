<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Add Members Success</title>
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
			String project = request.getParameter("proid");
			String[] ee = request.getParameterValues("members");
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				PreparedStatement pst = con.prepareStatement("insert into projectrequests values(?,?,?,?,?,?)");
				Statement st = con.createStatement();
				Statement st1 = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				ResultSet rs1 = st1.executeQuery("select startdate,enddate from projectrequests where manageremail='" + me + "' and project='" + project + "'");
				if (rs1.next() == false) {
					rs1 = st1.executeQuery("select startdate,enddate from projectmembers where manageremail='" + me + "' and project='" + project + "'");
					rs1.next();
				}
				for (int i = 0; i < ee.length; i++) {
					ResultSet rs = st.executeQuery("select name from users where email='" + ee[i] + "'");
					rs.next();
					pst.setString(1, me);
					pst.setString(2, ee[i]);
					pst.setString(3, rs.getString(1));
					pst.setString(4, project);
					pst.setDate(5, rs1.getDate(1));
					pst.setDate(6, rs1.getDate(2));
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