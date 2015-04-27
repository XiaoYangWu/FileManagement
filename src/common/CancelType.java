/**���ദ���û�ɾ���ļ����Ĳ���,֮��ص���ʾ�ļ����ҳ��*/
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
		if(user==null){//��û��½������session����,�ص���ҳ��
			response.sendRedirect("index.jsp");
			return;
		}
		Connection conn=null;
		Statement stmt=null;
		PreparedStatement pstmt=null;
		request.setCharacterEncoding("gb2312");
		if(request.getParameter("name")==null)//��nameΪnull��û��Ҫɾ�����ļ����,ֱ�ӻص��û���¼��ҳ��,���������û�ֱ�ӷ���url
			//û�д����������
		{
			response.sendRedirect("commonuser.jsp");
			return;
		}
		String filetype=new String(request.getParameter("name").getBytes("iso-8859-1"),"gb2312");
	
		 ConnectDatabase.init(getServletContext());
		conn=ConnectDatabase.connect();
		try{
			   FileType ft=(FileType)session.getAttribute("ft");
				if(ft==null)//�洢���ݿ����ļ�������Ϣ,��Ϊ�����ʼ����ȡ���ݿ���Ϣ
				{
					ft=new FileType();
					ft.fileInDatabase(getServletContext());
				}
			
			
			stmt=conn.createStatement();//ɾ�����ݿ��м�¼
			  stmt.executeUpdate("DELETE FROM file_type WHERE type='"+filetype+"'");
			  
			  pstmt=conn.prepareStatement("DELETE FROM file WHERE type=?");
			  
			  pstmt.setString(1, filetype);
			  pstmt.executeUpdate();
			  
			  
			
				//ɾ��FileType�����м�¼
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
