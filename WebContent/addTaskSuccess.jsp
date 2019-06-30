<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="css/project.css"/>
<title>Add Task Success</title>
</head>
<body>
	<%response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Expires","0");
	response.setDateHeader("Expires",-1);
	if(session.getAttribute("email")==null){
		RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
		rd.include(request,response);%>
		<div class="logoutalert">You are not logged in! Please Login!</div>
	<%}else{%>
		<%@ include file="main.jsp" %>
		<%String email=(String)session.getAttribute("email");
		String company=(String)session.getAttribute("company");
		String project=request.getParameter("proid");
		String task=request.getParameter("task");
		java.sql.Date startdate=java.sql.Date.valueOf(request.getParameter("startdate"));
		java.sql.Date enddate=java.sql.Date.valueOf(request.getParameter("enddate"));
		int progress=Integer.parseInt(request.getParameter("progress"));
		String[] ee=request.getParameterValues("members");
		java.util.Date dt=new java.util.Date();
		SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy 'at' hh:mm a");
		String date=sdf.format(dt);
		try{
			Class.forName(dname);
			Connection con=DriverManager.getConnection(dburl,"Vipul","123");
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("select task from tasks where company='"+company+"' and project='"+project+"' and task='"+task+"'");
			if(rs.next()){
				session.setAttribute("msg", "error");
				RequestDispatcher rd=request.getRequestDispatcher("addTask.jsp");
				rd.forward(request, response);
				return;
			}
			rs=st.executeQuery("select name from users where email='"+email+"'");
			rs.next();
			PreparedStatement pst=con.prepareStatement("insert into tasks values(?,?,?,?,?,?,?,?)");
			pst.setString(1, project);
			pst.setString(2, company);
			pst.setString(3, task);
			pst.setString(4, rs.getString(1));
			
			rs=st.executeQuery("select name from users where email='"+ee[0]+"'");
			rs.next();
			String s=rs.getString(1);
			for(int i=0;i<ee.length-1;i++){
				rs=st.executeQuery("select name from users where email='"+ee[i+1]+"'");
				rs.next();
				s=s.concat(','+rs.getString(1));
			}
			
			pst.setString(5, s);
			pst.setDate(6, startdate);
			pst.setDate(7, enddate);
			pst.setInt(8, progress);
			int i=pst.executeUpdate();
			
			pst=con.prepareStatement("insert into progresshistory values(?,?,?,?,?)");
			pst.setString(1, company);
			pst.setString(2, project);
			pst.setString(3, task);
			pst.setInt(4, progress);
			pst.setString(5, date);
			int j=pst.executeUpdate();

			if(i!=0 && j!=0){%>
				<div class="alert"><%="Task Added Successfully!!"%></div>
			<%}

			con.close();
			st.close();
			pst.close();
		}catch(Exception e){
			out.println(e.getMessage());
		}
	}%>
</body>
</html>