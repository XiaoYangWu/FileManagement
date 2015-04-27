/*本类处理用户修改文件类名和增加文件类名的操作**/
package common;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.ConnectDatabase;
import bean.FileType;
import bean.User;

/**
 * Servlet implementation class TypeModify
 */
public class TypeModify extends HttpServlet {
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
		
		
		request.setCharacterEncoding("gb2312");//用户输入的信息可能有中文
		
		 ConnectDatabase.init(getServletContext());//初始化数据库
		conn=ConnectDatabase.connect();//连接数据库
		
       boolean flag=true;
		

	    FileType ft=(FileType)session.getAttribute("ft");//得到文件列表的对象,保存了之前用户查询的文件信息
	    if(ft==null){
	    	ft=new FileType();
	    	ft.fileInDatabase(getServletContext());
	    }
	    int count=ft.getTypes().size();
	    try{
	    pstmt=conn.prepareStatement("UPDATE file_type SET type=? WHERE type=?");
	    pstmt2=conn.prepareStatement("UPDATE file SET type=? WHERE type=?");
	    for(int i=0;i<count;i++){
	    	String tname=ft.getTypes().get(i);//得到这条记录的原来文件类名
        	
	    	
	    	
	    	String mtname=i+"mtype";//得到FileType第i条记录的修改文件类名的文本框的名字
	    	
	    	
	    	
	    	String mtype=request.getParameter(mtname);//得到FileList第i条记录的修改文件类名的文本框的值
	    	if(mtname==null){
	    		continue;
	    	}
	    	
	    	 if(!"".equals(mtype)){//若不为空,则用户修改了该条记录的文件类别名,应进行处理
	            if(!ft.getTypes().contains(mtype)){//若原来没有这个类名,修改
	            	//修改数据库中file_type表的记录值
		    		pstmt.setString(1,mtype);
		    		pstmt.setString(2,tname);
		    		pstmt.executeUpdate();
		    		
		    		//修改数据库中file表的记录值
		    		pstmt2.setString(1,mtype);
		    		pstmt2.setString(2,tname);
		    		pstmt2.executeUpdate();
		    		
		    		ft.getTypes().set(i, mtype);//修改FileType对象中对应的值
	    	      }
	            else{//类名冲突
	            	flag=false;
	            }
	            	
		    	}
	    	
	    	}
	    
	       //下面处理用户新添加的文件类别
	       int index=0;
	       pstmt=conn.prepareStatement("INSERT INTO file_type (type) VALUES (?)");
	       
	       while(request.getParameter(index+"addtype")!=null){//循环取得每一个添加文件类型文本框的值
	    	   String newType=request.getParameter(index+"addtype");
	    	  
	    	   if(!"".equals(newType)){//若表单内容不为空,则添加到数据库和FileType中
	    		   
	    		   if(!ft.getTypes().contains(newType))//如果原来没有这个类别,则添加
	    		   {
	                  pstmt.setString(1,newType);
	    		      pstmt.executeUpdate();
	    		      ft.getTypes().add(newType);
	    		   }
	    		   else{
	    			   flag=false;//类名冲突,添加失败
	    		   }
	    	   }
	    	   index++;
	       }
	    
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
        	if(flag)
                response.sendRedirect("showfiletype.jsp");//回到显示查询结果的界面
        	else
        		 response.sendRedirect("showfiletype.jsp?flag=true");
	    }
	
	
	
	
	
	}

}
