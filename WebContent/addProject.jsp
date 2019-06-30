<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/project.css" />
<title>Add Project</title>
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
			String s = (String) session.getAttribute("email");
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				PreparedStatement st = con.prepareStatement("select name,email from companystaffs where company='" + c + "'", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
				ResultSet rs = st.executeQuery();
	%>
	<div class="projectDetails">
		<p>
			<u>Add Project:</u>
		</p>
	</div>
	<form action="addProjectSuccess.jsp">
		<table style="width: 30%">
			<tr>
				<th>Project Name:</th>
				<td><input type="text" name="project" required /></td>
			</tr>
			<tr>
				<th>Select Members:</th>
				<td><select name="members" multiple required>
						<%
							while (rs.next()) {
						%>
						<option value="<%=rs.getString(2)%>"><%=rs.getString(1) + " - " + rs.getString(2)%></option>
						<%
							}
									if (rs.first() == false) {
						%>
						<option>(no members)</option>
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
				<%
					if (rs.first() == false) {
				%>
				<td colspan="2" align="center"><input type="submit" value="Add" disabled /></td>
				<%
					} else {
				%>
				<td colspan="2" align="center"><input type="submit" value="Add" /></td>
				<%
					}
				%>
			</tr>
		</table>
	</form>
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