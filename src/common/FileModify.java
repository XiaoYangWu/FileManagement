/***用于处理用户修改文件名或修改文件类别*/
package common;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
 * Servlet implementation class FileModify
 */
public class FileModify extends HttpServlet {
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
		
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		Statement stmt=null;
		ResultSet rs=null;
		request.setCharacterEncoding("gb2312");//用户输入的信息可能有中文
		
		 ConnectDatabase.init(getServletContext());//初始化数据库
		conn=ConnectDatabase.connect();//连接数据库
		
		boolean flag=true;
		boolean flag2=true;
		
		
	    FileList fl=(FileList)session.getAttribute("fl");//得到文件列表的对象,保存了之前用户查询的文件信息
	    if(fl==null){//若FileList对象为null，直接回到用户登录后页面,用来处理用户直接访问url
			//还没有准备好FileList对象的情况
	    	response.sendRedirect("commonuser.jsp");
			return;
	    }
	    int count=fl.getFr().size();
	    try{
	    pstmt=conn.prepareStatement("UPDATE file SET name=? WHERE name=?");
	    pstmt2=conn.prepareStatement("UPDATE file SET type=? WHERE name=?");
	    stmt=conn.createStatement();
	    rs=stmt.executeQuery("select name from file");
	    for(int i=0;i<count;i++){
	    	String fname=fl.getFr().get(i).getName();//得到这条记录的文件名
        	
	    	
	    	
	    	String mfname="fn"+fname;//得到FileList第i条记录的修改文件名的文本框的名字
	    	String mtname="ft"+fname;//得到FileList第i条记录的修改文件类别的文本框的名字
	    	
	    	String mfilename=request.getParameter(mfname);//得到FileList第i条记录的修改文件名的文本框的值
	    	String mfiletype=request.getParameter(mtname);//得到FileList第i条记录的修改文件类别的文本框的值
	    	
	    	if(mfilename==null||mfiletype==null)
	    	{//若参数为null，直接回到用户登录后页面,用来处理用户直接访问url
				//没有传参数的情况
	    		response.sendRedirect("commonuser.jsp");
				return;
	    	}
	    	
	    	 if(!"".equals(mfiletype)){//若不为空,则用户修改了该条记录的文件类别,应进行处理
	            	
	            	//修改数据库中的记录值
		    		pstmt2.setString(1,mfiletype);
		    		pstmt2.setString(2, fname);
		    		pstmt2.executeUpdate();
		    		
		    		fl.getFr().get(i).setFiletype(mfiletype);//修改FileList对象中对应的值
		    		
	            	
		    	}
	    	
	    	
	    	
	    	if(!"".equals(mfilename)){//若不为空,则用户修改了该条记录的文件名,应进行处理
	    		
	    	    while(rs.next()){
	    	    	if(rs.getString(1).equals(mfilename)){
	    	    		flag=false;
	    	    		flag2=false;
	    	    		rs.beforeFirst();
	    	    		break;
	    	    	}
	    	    }
	    	    if(flag){
	    		//修改数据库中的记录值
	    		pstmt.setString(1,mfilename);
	    		pstmt.setString(2, fname);
	    		pstmt.executeUpdate();
	    		
	    		fl.getFr().get(i).setName(mfilename);//修改FileList对象中对应的值
	    	    }
	    	
	    	}
	    	
	    	
            flag=true;

	    }
	    if(flag2)
            response.sendRedirect("showfilesearch.jsp");//回到显示查询结果的界面
     	else
     		response.sendRedirect("showfilesearch.jsp?flag=true");//有文件名冲突
	    }
	    catch(SQLException se){se.printStackTrace();}
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
	    	if(pstmt!=null){
        		try{
        			pstmt.close();
        		}
        		catch(SQLException se){
        			se.printStackTrace();
        		}
        		pstmt=null;
        	}
	    	
	    	if(pstmt2!=null){
        		try{
        			pstmt2.close();
        		}
        		catch(SQLException se){
        			se.printStackTrace();
        		}
        		pstmt2=null;
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
