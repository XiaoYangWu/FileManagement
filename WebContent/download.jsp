<!-- 处理用户的下载操作 -->
<%@page import="bean.User"%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="com.jspsmart.upload.*" %>
<%
   //若没登陆或者session过期回到主页面
   User user=(User)session.getAttribute("user");

   if(user==null){
      response.sendRedirect("index.jsp");
      return;
   }

   request.setCharacterEncoding("gb2312");
   if(request.getParameter("path")==null)//若登陆过但path参数为空返回用户登录后页面,即用户直接用url访问没传参数的情况
   {
	   response.sendRedirect("commonuser.jsp");
	      return;
   }
   String path=new String(request.getParameter("path").getBytes("iso-8859-1"),"gb2312");
   String name=new String(request.getParameter("name").getBytes("iso-8859-1"),"gb2312");
    // 新建一个SmartUpload对象
	SmartUpload su = new SmartUpload();
	// 初始化
	su.initialize(pageContext);
	// 设定contentDisposition为null以禁止浏览器自动打开文件
	su.setContentDisposition(null);
	// 下载文件
	try{
	su.downloadFile(path,"text/html;charset=gb2312",name);
	}
	catch(Exception e){//若出错回到用户登录后页面
		 response.sendRedirect("commonuser.jsp");
	      return;
	}
%>

