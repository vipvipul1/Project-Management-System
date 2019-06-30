package datahouse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/Register")
@MultipartConfig
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String email = request.getParameter("email");
		String company = request.getParameter("company");
		String oldpassword = request.getParameter("oldpassword");
		String designation = request.getParameter("designation");
		String gender = request.getParameter("gender");
		String name = request.getParameter("name");
		Part img = request.getPart("img");
		ServletContext context = getServletContext();
		String dname = context.getInitParameter("drivername");
		String dburl = context.getInitParameter("databaseurl");
		try {
			Class.forName(dname);
			Connection con = DriverManager.getConnection(dburl, "Vipul", "123");
			PreparedStatement pst = con.prepareStatement("Select * from users where email='" + email + "'");
			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				HttpSession session = request.getSession();
				session.setAttribute("message", "error");
				response.sendRedirect("signup.jsp");
			}
			pst = con.prepareStatement("Insert into users values(?,?,?,?,?,?)");
			pst.setString(1, email);
			pst.setString(2, oldpassword);
			pst.setString(3, company);
			pst.setString(4, designation);
			pst.setString(5, name);
			pst.setString(6, gender);
			int i = pst.executeUpdate();

			int j = 1;
			if (designation.equals("Employee")) {
				pst = con.prepareStatement("Insert into companystaffs values(?,?,?)");
				pst.setString(1, email);
				pst.setString(2, company);
				pst.setString(3, name);
				j = pst.executeUpdate();
			}
			String path = context.getRealPath("images");
			File f = new File(path);
			if (!f.exists())
				f.mkdir();
			File ff = new File(f, email + ".jpg");
			img.write(ff.getAbsolutePath());
			if (i != 0 && j != 0)
				response.sendRedirect("signupSuccess.jsp");
		} catch (Exception e) {
			out.println(e.getMessage());
		}
	}

}
