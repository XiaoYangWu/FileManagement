<!-- �û��޸���������д�ı�ҳ�� -->
<%@page import="bean.User"%>
<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�޸�����</title>
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
  
  
  <div id=bottom style="left:590px">
  <table><tr height=80px><td></td></tr></table>
  <form id="mopass" method=post action="doModifyPasswd" onClick="return checkPasswd()">
  <table>
 	  <tr><td>ԭ����:</td><td><input type=password name=old></td></tr>
 	  <tr><td>������:</td><td><input type=password name=new onBlur="checkPasswd()"></td><td style="display:none"><font color=red>(���벻��Ϊ��!)</font></td></tr>
 	  <tr><td>�ظ��µ�����:</td><td><input type=password name=again onBlur="checkPasswd()"></td><td style="display:none"><font color=red>(�����������벻һ��!)</font></td></tr>
 	  <tr><th><input name="�ύ" type=submit value=ȷ���޸�></th><th><input name="����" type=reset value=���� ></th>
      
 </table>
 </form>
 </div>
</body>
</html>