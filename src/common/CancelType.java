/**本类处理用户删除文件类别的操作,之后回到显示文件类别页面*/
package common;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.ConnectDatabase;
import bean.FileList;
import bean.FileType;
import bean.User;

/**
 * Servlet implementation class CancelType
 */
public class CancelType extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    

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
		PreparedStatement pstmt=null;
		request.setCharacterEncoding("gb2312");
		if(request.getParameter("name")==null)//若name为null，没有要删除的文件类别,直接回到用户登录后页面,用来处理用户直接访问url
			//没有传参数的情况
		{
			response.sendRedirect("commonuser.jsp");
			return;
		}
		String filetype=new String(request.getParameter("name").getBytes("iso-8859-1"),"gb2312");
	
		 ConnectDatabase.init(getServletContext());
		conn=ConnectDatabase.connect();
		try{
			   FileType ft=(FileType)session.getAttribute("ft");
				if(ft==null)//存储数据库中文件类别的信息,若为空则初始化读取数据库信息
				{
					ft=new FileType();
					ft.fileInDatabase(getServletContext());
				}
			
			
			stmt=conn.createStatement();//删除数据库中记录
			  stmt.executeUpdate("DELETE FROM file_type WHERE type='"+filetype+"'");
			  
			  pstmt=conn.prepareStatement("DELETE FROM file WHERE type=?");
			  
			  pstmt.setString(1, filetype);
			  pstmt.executeUpdate();
			  
			  
			
				//删除FileType对象中记录
				for(int i=0;i<ft.getTypes().size();i++){
					if(ft.getTypes().get(i).equals(filetype))
					{
						ft.getTypes().remove(i);
						break;
						
					}
					   
				}
				response.sendRedirect("showfiletype.jsp");
				
			}
			catch(SQLException se){se.printStackTrace();}
			finally{
				
				if(pstmt!=null){
	        		try{
	        			pstmt.close();
	        		}
	        		catch(SQLException se){
	        			se.printStackTrace();
	        		}
	        		pstmt=null;
	        	}
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
