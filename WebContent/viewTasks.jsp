<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>View Tasks</title>
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
		String email = (String) session.getAttribute("email");
			String name = (String) session.getAttribute("name");
			String company = (String) session.getAttribute("company");
			String project = request.getParameter("proid");
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				Statement st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				ResultSet rs = st.executeQuery("select * from tasks where project='" + project + "' and company='" + company + "'");
				if (!rs.next()) {
	%>
	<div class="tasks">
		No Tasks Added! <a href="addTask.jsp?proid=<%=project%>">Add Task</a>
	</div>
	<%
		return;
				}
	%>
	<div class="tasks">
		Tasks: <a href="addTask.jsp?proid=<%=project%>">Add Task</a>
	</div>
	<table>
		<tr>
			<th>Tasks</th>
			<th>Created By</th>
			<th>Responsible</th>
			<th>Start Date</th>
			<th>End Date</th>
			<th>Progress(%)</th>
		</tr>
		<%
			do {
		%>
		<tr>
			<td><%=rs.getString(3)%></td>
			<td><%=rs.getString(4)%></td>
			<td><%=rs.getString(5)%></td>
			<td><%=rs.getDate(6)%></td>
			<td><%=rs.getDate(7)%></td>
			<td align="center" id="progress"><%=rs.getInt(8)%></td>
			<%
				int begindex = 0;
							int endindex;
							char[] mem = rs.getString(5).toCharArray();
							for (endindex = 0; endindex < mem.length; endindex++) {
								while (endindex < mem.length && mem[endindex] != ',')
									endindex++;
								if (rs.getString(5).substring(begindex, endindex).equals(name) && rs.getInt(8) != 100) {
			%>
			<td><a href="updateProgress.jsp?proid=<%=project%>&task=<%=rs.getString(3)%>">Update</a></td>
			<%
				break;
								}
								begindex = endindex + 1;
							}
			%>
			<td><a href="progressHistory.jsp?proid=<%=project%>&task=<%=rs.getString(3)%>">History</a></td>
		</tr>
		<%
			} while (rs.next());
					if ("success".equals(session.getAttribute("msg"))) {
		%>
		<div class="alert"><%="Updated Successfully!"%></div>
		<%
			session.setAttribute("msg", "");
					}
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