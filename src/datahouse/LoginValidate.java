package datahouse;
import java.sql.*;
import javax.servlet.*;

public class LoginValidate {
	
	public static boolean checkDetails(String email,String password){
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","Vipul","123");
			
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("select * from users where email='"+email+"' and password='"+password+"'");
			
			/*PreparedStatement pst=con.prepareStatement("select * from users where email=? and password=?");
			pst.setString(1, username);
			pst.setString(2, password);
			ResultSet rs=pst.executeQuery();*/

			if(rs.next()==true){
				return true;
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return false;
	}
	public static String name(String email){
		String name=null;
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","Vipul","123");
			
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("select name from users where email='"+email+"'");
			rs.next();
			name=rs.getString(1);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return name;
	}
	public static String designation(String email){
		String designation=null;
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","Vipul","123");
			
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("select designation from users where email='"+email+"'");
			rs.next();
			designation=rs.getString(1);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return designation;
	}
	public static String company(String email){
		String company=null;
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","Vipul","123");
			
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("select company from users where email='"+email+"'");
			rs.next();
			company=rs.getString(1);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return company;
	}
}
