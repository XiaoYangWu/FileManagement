<!-- 用户修改密码所填写的表单页面 -->
<%@page import="bean.User"%>
<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改密码</title>
<link href="mycss.css" rel="stylesheet" type="text/css">
<script language="javascript">

function checkPasswd(){
	
	var firsttr=document.getElementById("mopass").getElementsByTagName("table")[0].getElementsByTagName("tr")[1];
	var secondtr=document.getElementById("mopass").getElementsByTagName("table")[0].getElementsByTagName("tr")[2];
	var firstPass=firsttr.getElementsByTagName("td")[1].getElementsByTagName("input")[0].value;
	var secondPass=secondtr.getElementsByTagName("td")[1].getElementsByTagName("input")[0].value;
	
	 if(firstPass==""){
		   firsttr.getElementsByTagName("td")[2].style.display="";
		   return false;
	   }
	 else{
		 firsttr.getElementsByTagName("td")[2].style.display="none";
	 }
	   if(firstPass!=secondPass){
		   secondtr.getElementsByTagName("td")[2].style.display="";
		   return false;
	   }
	   else{
		   secondtr.getElementsByTagName("td")[2].style.display="none";
		   return true;
	   }
}

</script>
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
  
  
  <div id=bottom style="left:590px">
  <table><tr height=80px><td></td></tr></table>
  <form id="mopass" method=post action="doModifyPasswd" onClick="return checkPasswd()">
  <table>
 	  <tr><td>原密码:</td><td><input type=password name=old></td></tr>
 	  <tr><td>新密码:</td><td><input type=password name=new onBlur="checkPasswd()"></td><td style="display:none"><font color=red>(密码不能为空!)</font></td></tr>
 	  <tr><td>重复新的密码:</td><td><input type=password name=again onBlur="checkPasswd()"></td><td style="display:none"><font color=red>(两次密码输入不一致!)</font></td></tr>
 	  <tr><th><input name="提交" type=submit value=确认修改></th><th><input name="重置" type=reset value=重填 ></th>
      
 </table>
 </form>
 </div>
</body>
</html>