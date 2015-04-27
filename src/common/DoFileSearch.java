/**
 * 处理用户提交的表单数据,判断用户使用哪一种查询，并为显示查询结果的jsp页面准备封装了查询结果数据的Javabean对象
 */
package common;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.ConnectDatabase;
import bean.FileList;
import bean.FileRecord;
import bean.User;


public class DoFileSearch extends HttpServlet {
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
		request.setCharacterEncoding("gb2312");  
		String searchType=request.getParameter("cond");//获取用户使用的查询类别
	     if(searchType==null){//若参数为null，直接回到用户登录后页面,用来处理用户直接访问url
				//且没有传参数的情况
	    	 response.sendRedirect("commonuser.jsp");
				return;
	     }
		Connection conn=null;
	      Statement stmt=null;
	      ResultSet rs=null;
	      ConnectDatabase.init(getServletContext());
	      conn=ConnectDatabase.connect();
	     try{
	      stmt=conn.createStatement();
	      if("all".equals(searchType)){
	    	  rs=stmt.executeQuery("select * from file");//查询全部信息
	    	 
	    	  
	      }
	      else if("filename".equals(searchType)){//按文件名查询
	    	  String filename=request.getParameter("filename");
	    	  rs=stmt.executeQuery("select * from file where name='"+filename+"'");
	      }
	      else if("keyword".equals(searchType)){//模糊查询
	    	  String keyword=request.getParameter("keyword");
	    	  rs=stmt.executeQuery("select * from file where name like '%"+keyword+"%'");
	      }
	      else if("filetype".equals(searchType)){//按文件类别查询
	    	  String filetype=request.getParameter("ffiletype");
	    	  rs=stmt.executeQuery("select * from file where type='"+filetype+"'");
	      }
	      else{//按上传用户查询
	    	  String userid=request.getParameter("fileuserid");
	    	  rs=stmt.executeQuery("select * from file where id='"+userid+"'");
	      }
	     
    	 
    	  FileList fl=new FileList();
    	
   
    	 
    	  
    	  while(rs.next()){//将查询到的每一行记录保存到FileList对象中
    	    FileRecord fr=new FileRecord();
    	    
    	    fr.setId(rs.getString(2));
    		fr.setName(rs.getString(3));
    		fr.setPath(rs.getString(4));
    		fr.setFiletype(rs.getString(5));
    		
    		fl.getFr().add(fr);
    	  }
    	 
    	  session.setAttribute("fl",fl);//FileList对象保存到request的属性中,供显示页面调用
	     }
	     catch(SQLException se){}
	     finally{
	    	 if(rs!=null){
	        		try{
	        			rs.close();
	        		}
	        		catch(SQLException se){
	        			se.printStackTrace();
	        		}
	        		rs=null;
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
	        	
	        	
	        	
	          
	      	  RequestDispatcher rd=request.getRequestDispatcher("showfilesearch.jsp");
	      	  rd.forward(request, response);//转到显示页面
	        	
	     }
	}

}
