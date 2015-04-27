<!-- 本页面用来处理上传时文件大小超出限制的错误 -->
<%@page import="bean.User"%>
<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>文件上传错误</title>
<link href="mycss.css" rel="stylesheet" type="text/css">
</head>
<body id=style>
 <%
        User user=(User)session.getAttribute("user");
   
   if(user==null){
    	response.sendRedirect("index.jsp");
    	return;
    }
   %>
<table>
<tr id=titleempty><td></td></tr>
</table>
 
  <div class=left> 欢迎你,<%=user.getName() %>!</div>
 
  <table>
<tr id=welcomeempty><td></td></tr>
</table>
 
 
    <div id=top class=left>
  <table width="147" class=mybgcolor >
   
  <tr class="trheight"><td><a href="fileonload" class="left">上传文件</a></td>
  </tr>
  <tr class="trheight" >
    <td ><a href="filesearch.jsp" class="left">文件查询</a></td>
  </tr>
  <tr class="trheight"><td ><a href="showfiletype.jsp" class="left">文件类别管理</a></td>
  </tr>
  <tr  class="trheight"   ><td ><a href="modifyPassword.jsp" class="left">修改密码</a></td>
  </tr>
  <tr class="trheight"><td ><a href="UserLogout" class="left">退出登录</a></td>
  </tr>
 
  </table>
  </div>
  
  <div id=bottom>
  <div class=blackbold>
  您上传的文件大小超过了系统限制!
  </div>
  </div>
</body>
</html>