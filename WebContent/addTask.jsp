<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Add Task</title>
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
		String c = (String) session.getAttribute("company");
			String email = (String) session.getAttribute("email");
			String designation = (String) session.getAttribute("designation");
			String project = request.getParameter("proid");
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				Statement st = con.createStatement();
				ResultSet rs;
				if ("Employee".equals(designation)) {
					rs = st.executeQuery("select manageremail from projectmembers where employeeemail='" + email + "'");
					rs.next();
					email = rs.getString(1);
				}
				rs = st.executeQuery("select u.name,pm.employeeemail from users u,projectmembers pm where pm.manageremail='" + email + "' and pm.project='" + project + "' and u.email=pm.employeeemail");
	%>
	<div class="projectDetails">
		<p>
			<u>Add Task:</u>
		</p>
	</div>
	<form action="addTaskSuccess.jsp">
		<table>
			<tr>
				<td colspan="2"><input type="hidden" name="proid" value="<%=project%>"></td>
			</tr>
			<tr>
				<th>Task Name:</th>
				<td><input type="text" name="task" required /></td>
			</tr>
			<tr>
				<th>Responsible:</th>
				<td><select name="members" multiple required>
						<%
							while (rs.next()) {
						%>
						<option value="<%=rs.getString(2)%>"><%=rs.getString(1) + " - " + rs.getString(2)%></option>
						<%
							}
						%>
					</select></td>
			</tr>
			<tr>
				<th>Start Date:</th>
				<td><input type="date" name="startdate" required /></td>
			</tr>
			<tr>
				<th>End Date:</th>
				<td><input type="date" name="enddate" required /></td>
			</tr>
			<tr>
				<th>Progress:</th>
				<td><input type="text" name="progress" required /></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="Add"></td>
			</tr>
		</table>
	</form>
	<%
		if ("error".equals(session.getAttribute("msg"))) {
	%>
	<div class="alert"><%="Task name already taken! Choose another!"%></div>
	<%
		session.setAttribute("msg", "");
				}

				con.close();
				st.close();
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		}
	%>
</body>
</html>