/**当用户删除文件时,该servlet进行相应处理,之后返回显示查询结果页面*/
package common;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.ConnectDatabase;
import bean.FileList;
import bean.User;

/**
 * Servlet implementation class DeleteFileRecord
 */
public class DeleteFileRecord extends HttpServlet {
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
		Connection conn=null;
		Statement stmt=null;
		
		request.setCharacterEncoding("gb2312");
		if(request.getParameter("name")==null){//若name为null，直接回到用户登录后页面,用来处理用户直接访问url
			//没有传参数的情况
			response.sendRedirect("commonuser.jsp");
			return;
		}
		String filename=new String(request.getParameter("name").getBytes("iso-8859-1"),"gb2312");
		
		 ConnectDatabase.init(getServletContext());
		conn=ConnectDatabase.connect();
		
		try{
		   stmt=conn.createStatement();//删除数据库中记录
		  stmt.executeUpdate("DELETE FROM file WHERE name='"+filename+"'");
		   FileList fl=(FileList)session.getAttribute("fl");
		   response.getWriter().println(fl==null);
		   if(fl!=null){//删除FileList中对应记录
				for(int i=0;i<fl.getFr().size();i++){
					if(fl.getFr().get(i).getName().equals(filename))
					{
						
						fl.getFr().remove(i);
						
						break;
					}
					   
				}
			}
				
		
			
			response.sendRedirect("showfilesearch.jsp");
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

}
