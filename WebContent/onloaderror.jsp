<!-- ��ҳ�����������ϴ�ʱ�ļ���С�������ƵĴ��� -->
<%@page import="bean.User"%>
<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ļ��ϴ�����</title>
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
 
  <div class=left> ��ӭ��,<%=user.getName() %>!</div>
 
  <table>
<tr id=welcomeempty><td></td></tr>
</table>
 
 
    <div id=top class=left>
  <table width="147" class=mybgcolor >
   
  <tr class="trheight"><td><a href="fileonload" class="left">�ϴ��ļ�</a></td>
  </tr>
  <tr class="trheight" >
    <td ><a href="filesearch.jsp" class="left">�ļ���ѯ</a></td>
  </tr>
  <tr class="trheight"><td ><a href="showfiletype.jsp" class="left">�ļ�������</a></td>
  </tr>
  <tr  class="trheight"   ><td ><a href="modifyPassword.jsp" class="left">�޸�����</a></td>
  </tr>
  <tr class="trheight"><td ><a href="UserLogout" class="left">�˳���¼</a></td>
  </tr>
 
  </table>
  </div>
  
  <div id=bottom>
  <div class=blackbold>
  ���ϴ����ļ���С������ϵͳ����!
  </div>
  </div>
</body>
</html>