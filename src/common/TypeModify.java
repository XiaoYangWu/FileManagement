/*���ദ���û��޸��ļ������������ļ������Ĳ���**/
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
		if(user==null){//��û��½������session����,�ص���ҳ��
			response.sendRedirect("index.jsp");
			return;
		}
		
		
		Connection conn=null;
		
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		
		
		request.setCharacterEncoding("gb2312");//�û��������Ϣ����������
		
		 ConnectDatabase.init(getServletContext());//��ʼ�����ݿ�
		conn=ConnectDatabase.connect();//�������ݿ�
		
       boolean flag=true;
		

	    FileType ft=(FileType)session.getAttribute("ft");//�õ��ļ��б�Ķ���,������֮ǰ�û���ѯ���ļ���Ϣ
	    if(ft==null){
	    	ft=new FileType();
	    	ft.fileInDatabase(getServletContext());
	    }
	    int count=ft.getTypes().size();
	    try{
	    pstmt=conn.prepareStatement("UPDATE file_type SET type=? WHERE type=?");
	    pstmt2=conn.prepareStatement("UPDATE file SET type=? WHERE type=?");
	    for(int i=0;i<count;i++){
	    	String tname=ft.getTypes().get(i);//�õ�������¼��ԭ���ļ�����
        	
	    	
	    	
	    	String mtname=i+"mtype";//�õ�FileType��i����¼���޸��ļ��������ı��������
	    	
	    	
	    	
	    	String mtype=request.getParameter(mtname);//�õ�FileList��i����¼���޸��ļ��������ı����ֵ
	    	if(mtname==null){
	    		continue;
	    	}
	    	
	    	 if(!"".equals(mtype)){//����Ϊ��,���û��޸��˸�����¼���ļ������,Ӧ���д���
	            if(!ft.getTypes().contains(mtype)){//��ԭ��û���������,�޸�
	            	//�޸����ݿ���file_type��ļ�¼ֵ
		    		pstmt.setString(1,mtype);
		    		pstmt.setString(2,tname);
		    		pstmt.executeUpdate();
		    		
		    		//�޸����ݿ���file��ļ�¼ֵ
		    		pstmt2.setString(1,mtype);
		    		pstmt2.setString(2,tname);
		    		pstmt2.executeUpdate();
		    		
		    		ft.getTypes().set(i, mtype);//�޸�FileType�����ж�Ӧ��ֵ
	    	      }
	            else{//������ͻ
	            	flag=false;
	            }
	            	
		    	}
	    	
	    	}
	    
	       //���洦���û�����ӵ��ļ����
	       int index=0;
	       pstmt=conn.prepareStatement("INSERT INTO file_type (type) VALUES (?)");
	       
	       while(request.getParameter(index+"addtype")!=null){//ѭ��ȡ��ÿһ������ļ������ı����ֵ
	    	   String newType=request.getParameter(index+"addtype");
	    	  
	    	   if(!"".equals(newType)){//�������ݲ�Ϊ��,����ӵ����ݿ��FileType��
	    		   
	    		   if(!ft.getTypes().contains(newType))//���ԭ��û��������,�����
	    		   {
	                  pstmt.setString(1,newType);
	    		      pstmt.executeUpdate();
	    		      ft.getTypes().add(newType);
	    		   }
	    		   else{
	    			   flag=false;//������ͻ,���ʧ��
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
                response.sendRedirect("showfiletype.jsp");//�ص���ʾ��ѯ����Ľ���
        	else
        		 response.sendRedirect("showfiletype.jsp?flag=true");
	    }
	
	
	
	
	
	}

}
