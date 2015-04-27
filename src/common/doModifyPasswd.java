/**
 * 处理用户修改密码的请求
 * **/
package common;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.ConnectDatabase;
import bean.User;

/**
 * Servlet implementation class doModifyPasswd
 */
public class doModifyPasswd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	     doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("user");
		if(user==null){//若没登陆过或者session过期,回到主页面
			response.sendRedirect("index.jsp");
			return;
		}
	     String id=user.getId();//用户学号
	     String oldPasswd=user.getPassword();//用户实际的原密码
	     
	     Connection conn=null;
	     Statement stmt=null;
	     
	     String checkPasswd=request.getParameter("old");//用户输入的原密码
	     String newPasswd=request.getParameter("new");//用户要改为的新密码
	     if(checkPasswd==null||newPasswd==null){//若参数为null，直接回到用户登录后页面,用来处理用户直接访问url
				//没有传参数的情况
	    	 response.sendRedirect("commonuser.jsp");
				return;
	     }
	     if(oldPasswd.equals(checkPasswd)){//验证成功,修改
	    	 
	    	 user.setPassword(newPasswd);
	    	try{
	    	 ConnectDatabase.init(getServletContext());
	    	 conn=ConnectDatabase.connect();
	    	 stmt=conn.createStatement();
	    	 stmt.executeUpdate("UPDATE user SET password='"+newPasswd+"' WHERE id='"+id+"'");
	    	 response.sendRedirect("resultModifyPasswd.jsp?result=true");
	    	}
	    	catch(SQLException se){se.printStackTrace();}
	    	finally{
	    		if(stmt!=null){
	        		try{
	        			stmt.close();
	        		}
	        		catch(SQLException se){
	        			se.printStackTrace();
	        		}
	        		stmt=null;
	        	}
	        	if(conn!=null){
	        		try{
	        			conn.close();
	        		}
	        		catch(SQLException se){
	        			se.printStackTrace();
	        		}
	        		conn=null;
	        	}
	    	 
	    	}
	     }
	     else{//验证没成功,回到结果页面并用参数提醒修改密码失败
	    	 response.sendRedirect("resultModifyPasswd.jsp?result=false");
	     }
	}

}
