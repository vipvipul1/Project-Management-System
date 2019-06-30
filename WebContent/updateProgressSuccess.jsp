<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Update Progress Success</title>
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
			String task = request.getParameter("task");
			String company = (String) session.getAttribute("company");
			int progress = Integer.parseInt(request.getParameter("progress"));
			Date dt = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy 'at' hh:mm:ss a");
			String date = sdf.format(dt);
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				PreparedStatement pst = con.prepareStatement("insert into progresshistory values(?,?,?,?,?)");
				pst.setString(1, company);
				pst.setString(2, project);
				pst.setString(3, task);
				pst.setInt(4, progress);
				pst.setString(5, date);
				int i = pst.executeUpdate();

				pst = con.prepareStatement("update tasks set progress='" + progress + "' where company='" + company + "' and project='" + project + "' and task='" + task + "'");
				int j = pst.executeUpdate();

				if (i != 0 && j != 0) {
					session.setAttribute("msg", "success");
					RequestDispatcher rd = request.getRequestDispatcher("viewTasks.jsp");
					rd.forward(request, response);
				}
				con.close();
				pst.close();
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		}
	%>
</body>
</html>