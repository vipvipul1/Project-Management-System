<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/main.css" />
<script src="scripts/jquery-3.1.0.min.js"></script>
<!-- <script src="scripts/main.js"></script>  -->
</head>
<body>
	<%
		String dname = application.getInitParameter("drivername");
		String dburl = application.getInitParameter("databaseurl");
		try {
			Class.forName(dname);
			Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
			Statement st = con.createStatement();
			Statement st1 = con.createStatement();
			ResultSet rs = st.executeQuery("select distinct project from projectmembers where manageremail='" + session.getAttribute("email") + "' or employeeemail='" + session.getAttribute("email") + "'");
			ResultSet rs1 = st1.executeQuery("select gender from users where email='" + session.getAttribute("email") + "'");
			rs1.next();
	%>
	<div class="projectName"><%=session.getAttribute("company")%></div>
	<h1 class="heading">Project Management System</h1>
	<div class="sideMenu">
		<ul>
			<li><a href="welcome.jsp" style="color: #16a085;">Home</a></li>
			<li><span style="color: #16a085;">Projects</span></li>
			<ul class='proNameOuter'>
				<%
					while (rs.next()) {
				%>
				<li><%=rs.getString(1)%></li>
				<ul class='proNameInner'>
					<li><a href="members.jsp?proid=<%=rs.getString(1)%>" style="color: #8e44ad;">Members</a></li>
					<li><a href="viewTasks.jsp?proid=<%=rs.getString(1)%>" style="color: #8e44ad;">Tasks</a></li>
				</ul>
				<%
					}
						if ("Manager".equals(session.getAttribute("designation"))) {
				%>
				<li><a href="addProject.jsp">Add Project</a></li>
				<%
					}
				%>
			</ul>
			<li><a href="chatzone.jsp" style="color: #16a085;">Chat Zone</a></li>
			<li><a href="notice.jsp" style="color: #16a085;">Notice</a></li>
		</ul>
	</div>
	<%!String salut;%>
	<%
		if ("M".equals(rs1.getString(1)))
				salut = "Mr. ";
			else
				salut = "Ms. ";

			con.close();
			st.close();
		} catch (Exception e) {
			out.println(e.getMessage());
		}
	%>
	<div class="rightMenu">
		<div class="profilePic">
			<img src="images/<%=session.getAttribute("email") + ".jpg"%>" />
			<h4><%="Welcome " + salut + session.getAttribute("name")%></h4>
		</div>
		<div class="clear"></div>
		<div class="menu">
			<ul>
				<%
					if ("Manager".equals(session.getAttribute("designation"))) {
				%>
				<li><a href="invite.jsp">Invitations Sent</a></li>
				<%
					} else {
				%>
				<li><a href="requests.jsp">Requests Received</a></li>
				<%
					}
				%>
				<li><a href="profile.jsp">Profile</a></li>
				<li><a href="logout.jsp">Logout</a></li>
			</ul>
		</div>
	</div>
</body>
</html>