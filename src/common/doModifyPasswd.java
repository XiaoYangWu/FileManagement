/**
 * �����û��޸����������
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
		if(user==null){//��û��½������session����,�ص���ҳ��
			response.sendRedirect("index.jsp");
			return;
		}
	     String id=user.getId();//�û�ѧ��
	     String oldPasswd=user.getPassword();//�û�ʵ�ʵ�ԭ����
	     
	     Connection conn=null;
	     Statement stmt=null;
	     
	     String checkPasswd=request.getParameter("old");//�û������ԭ����
	     String newPasswd=request.getParameter("new");//�û�Ҫ��Ϊ��������
	     if(checkPasswd==null||newPasswd==null){//������Ϊnull��ֱ�ӻص��û���¼��ҳ��,���������û�ֱ�ӷ���url
				//û�д����������
	    	 response.sendRedirect("commonuser.jsp");
				return;
	     }
	     if(oldPasswd.equals(checkPasswd)){//��֤�ɹ�,�޸�
	    	 
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
	     else{//��֤û�ɹ�,�ص����ҳ�沢�ò��������޸�����ʧ��
	    	 response.sendRedirect("resultModifyPasswd.jsp?result=false");
	     }
	}

}
