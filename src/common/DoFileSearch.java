/**
 * �����û��ύ�ı�����,�ж��û�ʹ����һ�ֲ�ѯ����Ϊ��ʾ��ѯ�����jspҳ��׼����װ�˲�ѯ������ݵ�Javabean����
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
		if(user==null){//��û��½������session����,�ص���ҳ��
			response.sendRedirect("index.jsp");
			return;
		}
		request.setCharacterEncoding("gb2312");  
		String searchType=request.getParameter("cond");//��ȡ�û�ʹ�õĲ�ѯ���
	     if(searchType==null){//������Ϊnull��ֱ�ӻص��û���¼��ҳ��,���������û�ֱ�ӷ���url
				//��û�д����������
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
	    	  rs=stmt.executeQuery("select * from file");//��ѯȫ����Ϣ
	    	 
	    	  
	      }
	      else if("filename".equals(searchType)){//���ļ�����ѯ
	    	  String filename=request.getParameter("filename");
	    	  rs=stmt.executeQuery("select * from file where name='"+filename+"'");
	      }
	      else if("keyword".equals(searchType)){//ģ����ѯ
	    	  String keyword=request.getParameter("keyword");
	    	  rs=stmt.executeQuery("select * from file where name like '%"+keyword+"%'");
	      }
	      else if("filetype".equals(searchType)){//���ļ�����ѯ
	    	  String filetype=request.getParameter("ffiletype");
	    	  rs=stmt.executeQuery("select * from file where type='"+filetype+"'");
	      }
	      else{//���ϴ��û���ѯ
	    	  String userid=request.getParameter("fileuserid");
	    	  rs=stmt.executeQuery("select * from file where id='"+userid+"'");
	      }
	     
    	 
    	  FileList fl=new FileList();
    	
   
    	 
    	  
    	  while(rs.next()){//����ѯ����ÿһ�м�¼���浽FileList������
    	    FileRecord fr=new FileRecord();
    	    
    	    fr.setId(rs.getString(2));
    		fr.setName(rs.getString(3));
    		fr.setPath(rs.getString(4));
    		fr.setFiletype(rs.getString(5));
    		
    		fl.getFr().add(fr);
    	  }
    	 
    	  session.setAttribute("fl",fl);//FileList���󱣴浽request��������,����ʾҳ�����
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
	      	  rd.forward(request, response);//ת����ʾҳ��
	        	
	     }
	}

}
