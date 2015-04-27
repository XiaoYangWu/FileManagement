<!--提供文件查询的表单  -->
<%@page import="bean.User"%>
<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>

<jsp:useBean id="ft" scope="session" class="bean.FileType"></jsp:useBean> <!-- 文件类别数据 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>文件查询</title>
<link href="mycss.css" rel="stylesheet" type="text/css">

<script language="javascript">

function fsubmit()
{
	if(searchForm.rcond[0].checked)
	{
	    searchForm.action="dofilesearch?cond=all"
	}
	 else if(searchForm.rcond[1].checked)
	 {
	    searchForm.action="dofilesearch?cond=filename"	
	 }
	 else if(searchForm.rcond[2].checked)
	 {
	    searchForm.action="dofilesearch?cond=keyword"	
	 }
	 else if(searchForm.rcond[3].checked)
	 {
	    searchForm.action="dofilesearch?cond=filetype"	
	 }
	
	  else 
	 {
	    searchForm.action="dofilesearch?cond=fileuserid"
	 }
}
	function hideall()
	{
			
		    fname.style.display="none";
		    fkey.style.display="none";
		    ftype.style.display="none";
		    fuserid.style.display="none";
	    
	}
	function showname()
	{
		
			 fname.style.display="";
			 fkey.style.display="none";
			 ftype.style.display="none";
			 fuserid.style.display="none";
		
		
	}
	function showkey()
	{
		
			 fkey.style.display="";
			 fname.style.display="none";
			 ftype.style.display="none";
			 fuserid.style.display="none";
		
	}
	function showtype()
	{
		
		    ftype.style.display="";
		    fkey.style.display="none";
			 fname.style.display="none";
			 
			 fuserid.style.display="none";
	}
	function showuser()
	{
		
			 fkey.style.display="none";
			 fname.style.display="none";
			 ftype.style.display="none";
			 fuserid.style.display="";
		
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
<%
if(0==ft.getTypes().size())//如果FileType的记录个数为0,则用户还没有查询过数据库中的文件类别信息，先查询数据库中有哪些文件类别，存入FileType对象中
     ft.fileInDatabase(application);//查询数据库中有哪些文件类别，存入ft对象中
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
  <div id=bottom style="left:680px">
  <form name="searchForm" action="" method="post" onClick="fsubmit()">
       <input type="radio" name="rcond" onClick="hideall()">查看所有文件<p>
       
       <input type="radio" name="rcond" onClick="showname()">按文件名查找<p>
       <table id=fname style="DISPLAY: none">
          <tr>
             <td>文件名:</td>
             <td><input type="text" name="filename"></td>
          </tr>
       </table><p>
       
       <input type="radio" name="rcond" onClick="showkey()">文件名模糊查找<p>
        <table id=fkey style="DISPLAY: none">
          <tr>
             <td>请输入关键字:</td>
             <td><input type="text" name="keyword"></td>
          </tr>
       </table><p>
       
       <input type="radio" name="rcond" onClick="showtype()">按文件类别查找<p>
        
             <select name=ffiletype style="DISPLAY: none" id=ftype> 
  				<%
     			 for(int j=0;j<ft.getTypes().size();j++){
   				%>
                    <option value=<%= ft.getTypes().get(j)%>><%= ft.getTypes().get(j) %></option>
   
   				<% 	  
     			}
  				%>
  				 
             </select>   
         <p>
       
        <input type="radio" name="rcond" onClick="showuser()">按上传用户查找<p>
        <table id=fuserid style="DISPLAY: none">
          <tr>
             <td>请输入学号:</td>
             <td><input type="text" name="fileuserid"></td>
          </tr>
       </table><p>
       
       <input class=mybutton name="提交" type="submit" value="查找">
       <input class=mybutton name="重置" type="reset" value="重新输入">
   </form> 
</div>
</body>
</html>