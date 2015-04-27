/***���ڴ����û��޸��ļ������޸��ļ����*/
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
			if(user==null){//��û��½������session����,�ص���ҳ��
				response.sendRedirect("index.jsp");
				return;
			}
		
		
		Connection conn=null;
		
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		Statement stmt=null;
		ResultSet rs=null;
		request.setCharacterEncoding("gb2312");//�û��������Ϣ����������
		
		 ConnectDatabase.init(getServletContext());//��ʼ�����ݿ�
		conn=ConnectDatabase.connect();//�������ݿ�
		
		boolean flag=true;
		boolean flag2=true;
		
		
	    FileList fl=(FileList)session.getAttribute("fl");//�õ��ļ��б�Ķ���,������֮ǰ�û���ѯ���ļ���Ϣ
	    if(fl==null){//��FileList����Ϊnull��ֱ�ӻص��û���¼��ҳ��,���������û�ֱ�ӷ���url
			//��û��׼����FileList��������
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
	    	String fname=fl.getFr().get(i).getName();//�õ�������¼���ļ���
        	
	    	
	    	
	    	String mfname="fn"+fname;//�õ�FileList��i����¼���޸��ļ������ı��������
	    	String mtname="ft"+fname;//�õ�FileList��i����¼���޸��ļ������ı��������
	    	
	    	String mfilename=request.getParameter(mfname);//�õ�FileList��i����¼���޸��ļ������ı����ֵ
	    	String mfiletype=request.getParameter(mtname);//�õ�FileList��i����¼���޸��ļ������ı����ֵ
	    	
	    	if(mfilename==null||mfiletype==null)
	    	{//������Ϊnull��ֱ�ӻص��û���¼��ҳ��,���������û�ֱ�ӷ���url
				//û�д����������
	    		response.sendRedirect("commonuser.jsp");
				return;
	    	}
	    	
	    	 if(!"".equals(mfiletype)){//����Ϊ��,���û��޸��˸�����¼���ļ����,Ӧ���д���
	            	
	            	//�޸����ݿ��еļ�¼ֵ
		    		pstmt2.setString(1,mfiletype);
		    		pstmt2.setString(2, fname);
		    		pstmt2.executeUpdate();
		    		
		    		fl.getFr().get(i).setFiletype(mfiletype);//�޸�FileList�����ж�Ӧ��ֵ
		    		
	            	
		    	}
	    	
	    	
	    	
	    	if(!"".equals(mfilename)){//����Ϊ��,���û��޸��˸�����¼���ļ���,Ӧ���д���
	    		
	    	    while(rs.next()){
	    	    	if(rs.getString(1).equals(mfilename)){
	    	    		flag=false;
	    	    		flag2=false;
	    	    		rs.beforeFirst();
	    	    		break;
	    	    	}
	    	    }
	    	    if(flag){
	    		//�޸����ݿ��еļ�¼ֵ
	    		pstmt.setString(1,mfilename);
	    		pstmt.setString(2, fname);
	    		pstmt.executeUpdate();
	    		
	    		fl.getFr().get(i).setName(mfilename);//�޸�FileList�����ж�Ӧ��ֵ
	    	    }
	    	
	    	}
	    	
	    	
            flag=true;

	    }
	    if(flag2)
            response.sendRedirect("showfilesearch.jsp");//�ص���ʾ��ѯ����Ľ���
     	else
     		response.sendRedirect("showfilesearch.jsp?flag=true");//���ļ�����ͻ
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
