<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="css/signup.css"/>
<title>Register Form</title>
</head>
<body>
<form action="Register" method="post" enctype="multipart/form-data">
  	<table width="360" align="center" style="border-spacing:20px">
		<tr>
			<td width="200">Company Name:</td>
			<td width="250"><input type="text" name="company" required/></td>
		</tr>
		<tr>
			<td>Name:</td>
			<td><input type="text" name="name" required/></td>
		</tr>
		<tr>
			<td>Designation:</td>
			<td><input type="radio" name="designation" value="Manager" required>
			  Manager
		      <input type="radio" name="designation" value="Employee" required>
		      Employee</td>
		</tr>
		<tr>
			<td>Email:</td>
			<td><input type="email" name="email" required/></td>
		</tr>
		<tr>
			<td>Password:</td>
			<td><input type="password" name="oldpassword" required/></td>
		</tr>
		<tr>
			<td>Gender:</td>
			<td><input type="radio" name="gender" value="M" required>
			  Male
		      <input type="radio" name="gender" value="F">
		      Female</td>
		</tr>
		<tr>
			<td>User image</td><td><input type="file" name="img"></td>
		</tr>
		<tr>
			<td align="center"><input type="submit"/></td>
		</tr>
	</table>
</form>
<div style="position:relative;top:-42px;left:730px;"> 
	<form action="index.jsp" >
		<input type="submit" value="Back"/>
	</form>
</div>
<%String msg=(String)session.getAttribute("message");
if("error".equals(msg)){%>
	<div class="alert"><%="Email already registered!!"%></div>
	<%session.invalidate();
}%>
</body>
</html>