package Servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

import Dao.BaseDao;


@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=utf-8");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
//		System.out.println(username + "," + password);
		Object [] param = new Object[]{username};
		List<Map<String, Object>> result = BaseDao.select("select * from ausertable where aname = ?",param);
		if(result.size() != 0) {
			
		}else {
			response.getWriter().print("账户不存在");
		}
		/*		if(rs.next()) {
		System.out.println(rs.getString("aname") + "," + rs.getString("apwd"));
		if(password.equals(rs.getString("apwd"))) {
			response.getWriter().print("登录成功");
		}else{
			response.getWriter().print("密码错误");
		}
	}else {
		
	}
* */
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
