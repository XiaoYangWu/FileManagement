<!-- 处理用户上传文件操作 -->
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
	<title>文件上传处理页面</title>
</head>
<body>
<%
        User user=(User)session.getAttribute("user");
   
   if(user==null){//若没登陆回到主页
    	response.sendRedirect("index.jsp");
    	return;
    }
   %>
<%
if(0==ft.getTypes().size())//如果FileType的记录个数为0,则用户还没有查询过数据库中的文件类别信息，先查询数据库中有哪些文件类别，存入FileType对象中
     ft.fileInDatabase(application);//查询数据库中有哪些文件类别，存入ft对象中
%>

	
  
	
	
	<%
	long maxSize=Long.parseLong(application.getInitParameter("MaxSize"));//获取允许上传的单个文件最大容量
	
	long totalMaxSize=Long.parseLong(application.getInitParameter("TotalMaxSize"));//获取允许上传的文件总的最大容量
	//利用SmartUpload组件上传文件
	SmartUpload su = new SmartUpload();
	su.initialize(pageContext);
	// 1.限制每个上传文件的最大长度
		su.setMaxFileSize(maxSize);
	// 2.限制总上传数据的长度
		su.setTotalMaxFileSize(totalMaxSize);	
	    
	    try{
		// 上传文件
		su.upload();
	    }catch(Exception e){//出错转向出错页面进行处理
	    	pageContext.forward("onloaderror.jsp");
	    	return;
	    }
		
		

    	Connection conn=null;
    	PreparedStatement pstmt=null;
    	PreparedStatement pstmt2=null;
    	PreparedStatement pstmt3=null;
    	PreparedStatement pstmt4=null;
    	ResultSet rs=null;

    	//连接数据库
    	ConnectDatabase.init(application);
		conn=ConnectDatabase.connect();
		
		pstmt=conn.prepareStatement("select * from file where name=?");
		pstmt2=conn.prepareStatement("INSERT INTO file (id,name,path,type) VALUES (?,?,?,?)");
		pstmt3=conn.prepareStatement("select * from file_type where type=?");
		pstmt4=conn.prepareStatement("INSERT INTO file_type (type) VALUES (?)");
		
		//获取上传的所有文件及文件个数
		Files upFiles=su.getFiles();
		int count=upFiles.getCount();
		
		
		//获取服务器端存放文件路径
    	java.io.File serverPath=new File(application.getRealPath("/")+"/upload");
    	java.io.File []serverFiles=serverPath.listFiles();//获取服务器端目录下所有文件
		
    	HashMap<String,String> status=new HashMap<String,String>();
    	
    	
    	try{
    	for(int i=0;i<count;i++){
    		if(upFiles.getFile(i).isMissing())
    			continue;
    		//获取表单数据
        	String fileclass=su.getRequest().getParameter(i+"fileclass");//用户选择的文件类别
        	String filename=su.getRequest().getParameter(i+"fname");//准备存放在数据库中的文件名
        	String userclass=su.getRequest().getParameter(i+"userclass");//用户自定义的文件类别
        	String actualFileName=upFiles.getFile(i).getFileName();//文件实际文件名
        	String path="/upload/"+actualFileName;//服务器端文件路径
        	if("".equals(filename))
        		filename=actualFileName;
		    //out.println(actualFileName+"<br>");
		    //out.println(fileclass+"<br>");
		    //out.println(filename+"<br>");
		    //out.println(userclass+"<br>");
    	    boolean flag=true;
        	for(int j=0;j<serverFiles.length;j++){
        		if(serverFiles[j].getName().equals(actualFileName))
        		{    //若检测到服务器端有重名文件则跳转页面，提示用户重新选择文件
        			 status.put(actualFileName,"上传失败,文件在服务器端已存在,请重新上传该文件！");
        		     flag=false;
        		     break;
        		}
        	}
        	//out.println(flag);
        	if(!flag)
    	         continue;
        	//从数据库中查询用户提交的文件名是否重复，若重复返回表单页面
			pstmt.setString(1, filename);
    		rs=pstmt.executeQuery();
            if(rs.next()){
                 //数据库中文件名有重复
            	status.put(actualFileName,"上传失败,文件名在数据库中已存在,请重新上传该文件！");
    		     
            }
            else{

            	// 将上传文件全部保存到指定目录
                
        		upFiles.getFile(i).saveAs(path,com.jspsmart.upload.File.SAVEAS_VIRTUAL);
        		
            	
            	//把上传文件的信息保存到数据库中
        		if("".equals(userclass)){//用户使用已存在的文件类别
        			 
        			
        		     pstmt2.setString(1,user.getId());
        			 pstmt2.setString(2,filename);
        			 pstmt2.setString(3,path);
        			 pstmt2.setString(4,fileclass);
        			 pstmt2.executeUpdate();
        			 
        		}
        		
        		else
        		{//用户使用自定义文件类别
        			//先把用户自定义的文件类别存入文件类型表中
        			pstmt3.setString(1, userclass);
        			rs=pstmt3.executeQuery();
        		    if(!rs.next())//如果数据库已存在的文件类别中没有用户输入的，则将用户输入的文件类别加入数据库
        			{
        		       
        			   pstmt4.setString(1,userclass);
        			   pstmt4.executeUpdate();
        			
        			   //将用户新添加的文件类别加入session中
        			   ft.getTypes().add(userclass);
        			}
        			//再上传文件信息至数据库中
        			
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