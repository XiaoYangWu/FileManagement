
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="bean.User"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>国关文件管理系统</title>

<style type="text/css">
<!--
.STYLE2 {
	font-family: "新宋体";
	font-weight: bold;
	color: #FFFFFF;
}
-->
</style>
</head>


<% 
//判断是否登陆过，若在同一次会话中登陆过直接跳转到登陆后页面，否则显示登陆表单
if(session.getAttribute("user")!=null)
{
	
	
	pageContext.forward("commonuser.jsp");//跳转到用户登陆后页面
	
}
else
{
%>
<body background="loginbg.jpg">




 
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  
  <table>
<tr height=175><td></td></tr>
</table>

<div align="center">
<div class=loginfont id="again" style="color: #FFFFFF">
用户名或密码错误，请重新输入</div >
<div> 
  <form action="UserLogin" method="post">
    <div >
      
      <p>&nbsp;</p>
      <table>
    <tr>
      <td width="68"><input type="hidden" name="action" value="login"></td>
    </tr>
    <tr>
      <td ><span class="STYLE2">用户名：</span></td>
    <td width="168"><input type="text" name="id"></td>
    </tr>
    <tr>
      <td ><span class="STYLE2">密码: </span></td>
    <td><input type="password" name="passwd"></td>
    </tr>
    <tr height=20>
      <td></td>
    <td></td>
    </tr>
  </table>
  <table width="143">
    <tr>
	
      <td><input name="提交" type="submit" value="登陆" class="STYLE1"></td>
	  <td width=100px></td>
    <td><input name="重置" type="reset" value="重新输入" class="STYLE1"></td>
    </tr>
  </table>
    </div>
  </form>
</div>
</div>

<script type="text/javascript">
<% if("error".equals(request.getAttribute("status"))){  %>
	document.getElementById("again").style.display="";//当用户名不存在或者密码错误时输出提示字样
<%}
else{
%>	
    document.getElementById("again").style.display="none";
<%
}
%>
</script>
</body>
<% } %>
</html> 