<!-- �����û��ϴ��ļ����� -->
<%@page import="bean.User"%>
<%@page import="bean.FileType"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.ConnectDatabase"%>
<%@ page contentType="text/html; charset=gb2312" language="java" %>
<%@ page import="java.util.*,com.jspsmart.upload.*" errorPage="" %>
  
<jsp:useBean id="ft" scope="session" class="bean.FileType"></jsp:useBean> 
<jsp:useBean id="fileform" scope="request" class="bean.FileUnloadForm"/>  
<html>
<head>
	<title>�ļ��ϴ�����ҳ��</title>
</head>
<body>
<%
        User user=(User)session.getAttribute("user");
   
   if(user==null){//��û��½�ص���ҳ
    	response.sendRedirect("index.jsp");
    	return;
    }
   %>
<%
if(0==ft.getTypes().size())//���FileType�ļ�¼����Ϊ0,���û���û�в�ѯ�����ݿ��е��ļ������Ϣ���Ȳ�ѯ���ݿ�������Щ�ļ���𣬴���FileType������
     ft.fileInDatabase(application);//��ѯ���ݿ�������Щ�ļ���𣬴���ft������
%>

	
  
	
	
	<%
	long maxSize=Long.parseLong(application.getInitParameter("MaxSize"));//��ȡ�����ϴ��ĵ����ļ��������
	
	long totalMaxSize=Long.parseLong(application.getInitParameter("TotalMaxSize"));//��ȡ�����ϴ����ļ��ܵ��������
	//����SmartUpload����ϴ��ļ�
	SmartUpload su = new SmartUpload();
	su.initialize(pageContext);
	// 1.����ÿ���ϴ��ļ�����󳤶�
		su.setMaxFileSize(maxSize);
	// 2.�������ϴ����ݵĳ���
		su.setTotalMaxFileSize(totalMaxSize);	
	    
	    try{
		// �ϴ��ļ�
		su.upload();
	    }catch(Exception e){//����ת�����ҳ����д���
	    	pageContext.forward("onloaderror.jsp");
	    	return;
	    }
		
		

    	Connection conn=null;
    	PreparedStatement pstmt=null;
    	PreparedStatement pstmt2=null;
    	PreparedStatement pstmt3=null;
    	PreparedStatement pstmt4=null;
    	ResultSet rs=null;

    	//�������ݿ�
    	ConnectDatabase.init(application);
		conn=ConnectDatabase.connect();
		
		pstmt=conn.prepareStatement("select * from file where name=?");
		pstmt2=conn.prepareStatement("INSERT INTO file (id,name,path,type) VALUES (?,?,?,?)");
		pstmt3=conn.prepareStatement("select * from file_type where type=?");
		pstmt4=conn.prepareStatement("INSERT INTO file_type (type) VALUES (?)");
		
		//��ȡ�ϴ��������ļ����ļ�����
		Files upFiles=su.getFiles();
		int count=upFiles.getCount();
		
		
		//��ȡ�������˴���ļ�·��
    	java.io.File serverPath=new File(application.getRealPath("/")+"/upload");
    	java.io.File []serverFiles=serverPath.listFiles();//��ȡ��������Ŀ¼�������ļ�
		
    	HashMap<String,String> status=new HashMap<String,String>();
    	
    	
    	try{
    	for(int i=0;i<count;i++){
    		if(upFiles.getFile(i).isMissing())
    			continue;
    		//��ȡ������
        	String fileclass=su.getRequest().getParameter(i+"fileclass");//�û�ѡ����ļ����
        	String filename=su.getRequest().getParameter(i+"fname");//׼����������ݿ��е��ļ���
        	String userclass=su.getRequest().getParameter(i+"userclass");//�û��Զ�����ļ����
        	String actualFileName=upFiles.getFile(i).getFileName();//�ļ�ʵ���ļ���
        	String path="/upload/"+actualFileName;//���������ļ�·��
        	if("".equals(filename))
        		filename=actualFileName;
		    //out.println(actualFileName+"<br>");
		    //out.println(fileclass+"<br>");
		    //out.println(filename+"<br>");
		    //out.println(userclass+"<br>");
    	    boolean flag=true;
        	for(int j=0;j<serverFiles.length;j++){
        		if(serverFiles[j].getName().equals(actualFileName))
        		{    //����⵽���������������ļ�����תҳ�棬��ʾ�û�����ѡ���ļ�
        			 status.put(actualFileName,"�ϴ�ʧ��,�ļ��ڷ��������Ѵ���,�������ϴ����ļ���");
        		     flag=false;
        		     break;
        		}
        	}
        	//out.println(flag);
        	if(!flag)
    	         continue;
        	//�����ݿ��в�ѯ�û��ύ���ļ����Ƿ��ظ������ظ����ر�ҳ��
			pstmt.setString(1, filename);
    		rs=pstmt.executeQuery();
            if(rs.next()){
                 //���ݿ����ļ������ظ�
            	status.put(actualFileName,"�ϴ�ʧ��,�ļ��������ݿ����Ѵ���,�������ϴ����ļ���");
    		     
            }
            else{

            	// ���ϴ��ļ�ȫ�����浽ָ��Ŀ¼
                
        		upFiles.getFile(i).saveAs(path,com.jspsmart.upload.File.SAVEAS_VIRTUAL);
        		
            	
            	//���ϴ��ļ�����Ϣ���浽���ݿ���
        		if("".equals(userclass)){//�û�ʹ���Ѵ��ڵ��ļ����
        			 
        			
        		     pstmt2.setString(1,user.getId());
        			 pstmt2.setString(2,filename);
        			 pstmt2.setString(3,path);
        			 pstmt2.setString(4,fileclass);
        			 pstmt2.executeUpdate();
        			 
        		}
        		
        		else
        		{//�û�ʹ���Զ����ļ����
        			//�Ȱ��û��Զ�����ļ��������ļ����ͱ���
        			pstmt3.setString(1, userclass);
        			rs=pstmt3.executeQuery();
        		    if(!rs.next())//������ݿ��Ѵ��ڵ��ļ������û���û�����ģ����û�������ļ����������ݿ�
        			{
        		       
        			   pstmt4.setString(1,userclass);
        			   pstmt4.executeUpdate();
        			
        			   //���û�����ӵ��ļ�������session��
        			   ft.getTypes().add(userclass);
        			}
        			//���ϴ��ļ���Ϣ�����ݿ���
        			
       			    pstmt2.setString(1,user.getId());
       			    pstmt2.setString(2,filename);
       			    pstmt2.setString(3,path);
       			    pstmt2.setString(4,userclass);
       			    pstmt2.executeUpdate();
        		}
        	}
    	
    	}
    	request.setAttribute("statuss",status);
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
        	if(pstmt3!=null){
        		try{
        			pstmt3.close();
        		}
        		catch(SQLException se){
        			se.printStackTrace();
        		}
        		pstmt3=null;
        	}
        	if(pstmt4!=null){
        		try{
        			pstmt4.close();
        		}
        		catch(SQLException se){
        			se.printStackTrace();
        		}
        		pstmt4=null;
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
        	
        	pageContext.forward("fileonload.jsp");
    	}
	%>
</body>
</html>