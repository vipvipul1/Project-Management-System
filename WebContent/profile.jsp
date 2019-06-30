<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/profile.css" />
<title>Profile</title>
<script type="text/javascript" src="scripts/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
    function submitForm() {
        f = document.forms[0];

        $.post("editProfile.jsp", {
            email : f.email.value,
            oldpassword : f.oldpassword.value,
            newpassword : f.newpassword.value,
            designation : f.designation.value
        },

        function (data) {
            alert("Message: " + data);
        });
    }
</script>
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
	<div class="alert">You are not logged in! Please Login!</div>
	<%
		} else {
	%>
	<%@ include file="main.jsp"%>
	<%
		String s = (String) session.getAttribute("email");
			try {
				Class.forName(dname);
				Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select * from users where email='" + s + "'");
				rs.next();
	%>
	<div class="profileDetails">
		<span><u>Profile Info:</u></span>
	</div>
	<form action="editProfile.jsp" onsubmit="submitForm(); return false;">
		<table style="width: 30%">
			<tr>
				<th>Email:</th>
				<td><input type="email" name="email" value="<%=rs.getString(1)%>" required /></td>
			</tr>
			<tr>
				<th>Old Password:</th>
				<td><input type="text" name="oldpassword" required /></td>
			</tr>
			<tr>
				<th>New Password:</th>
				<td><input type="text" name="newpassword" required /></td>
			</tr>
			<tr>
				<th>Designation:</th>
				<td><input type="text" name="designation" value="<%=rs.getString(4)%>" readonly /></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="Update" /></td>
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