<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<jsp:useBean id="pro" class="datahouse.UserData" scope="session" />
<jsp:setProperty property="email" name="pro" />
<jsp:setProperty property="oldpassword" name="pro" />
<jsp:setProperty property="newpassword" name="pro" />
<jsp:setProperty property="designation" name="pro" />

<%
	String email = pro.getEmail();
	String oldpass = pro.getOldpassword();
	String newpass = pro.getNewpassword();
	String desig = pro.getDesignation();
	String se = (String) session.getAttribute("email");
	String sd = (String) session.getAttribute("designation");
	ServletContext context = getServletContext();
	String dname = context.getInitParameter("drivername");
	String dburl = context.getInitParameter("databaseurl");
	try {
		Class.forName(dname);
		Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
		Statement st = con.createStatement();
		Statement st1 = con.createStatement();
		ResultSet rs = st.executeQuery("select email from users where email='" + email + "'");
		ResultSet rs1 = st1.executeQuery("select password from users where email='" + se + "'");
		rs1.next();
		if (rs.next() == true && se.equals(email) == false) {
%>
<%="Email Already Registered!!"%>
<%
	return;
		}
		if (oldpass.equals(rs1.getString(1)))
			oldpass = newpass;
		else {
%>
<%="Old Password is Wrong!!"%>
<%
	return;
		}
		if (desig.equals(sd) == false) {
			st.executeUpdate("delete from companystaffs where email='" + se + "'");
			st.executeUpdate("delete from projectmembers where employeeemail='" + se + "'");
			st.executeUpdate("delete from projectrequests where employeeemail='" + se + "'");
		}
		st.executeUpdate("update users set email='" + email + "',password='" + oldpass + "',designation='" + desig + "' where email='" + se + "'");
		st.executeUpdate("update companystaffs set email='" + email + "' where email='" + se + "'");
		if ("Employee".equals(sd)) {
			st.executeUpdate("update projectmembers set employeeemail='" + email + "' where employeeemail='" + se + "'");
			st.executeUpdate("update projectrequests set employeeemail='" + email + "' where employeeemail='" + se + "'");
		} else if ("Manager".equals(sd)) {
			st.executeUpdate("update projectmembers set manageremail='" + email + "' where manageremail='" + se + "'");
			st.executeUpdate("update projectrequests set manageremail='" + email + "' where manageremail='" + se + "'");
		}

		if (!se.equals(email)) {
			String path = getServletContext().getRealPath("images");
%>
<%
	File oldimg = new File(path + "/" + se + ".jpg");
			File newimg = new File(path + "/" + email + ".jpg");
			oldimg.renameTo(newimg);
		}
		session.setAttribute("email", email);
		session.setAttribute("designation", desig);
%>
<%="Updated Successfully!!"%>
<%
	con.close();
		st.close();
	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>