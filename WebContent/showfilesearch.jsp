<!-- 本页面用来显示用户进行文件查询的结果 -->
<%@page import="bean.User"%>
<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>

<jsp:useBean id="fl"   scope="session" class="bean.FileList"/>
<jsp:useBean id="ft" scope="session" class="bean.FileType"></jsp:useBean> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>查询结果</title>
<link href="mycss.css" rel="stylesheet" type="text/css">
<script language="javascript">

function dealfile(findex){//控制修改文件名的文本框的显示和隐藏
	
	var fid=findex+"mftext";
	if(document.getElementById(fid).style.display=="none")
	{
		document.getElementById(fid).style.display="";//若之前隐藏，点击后显示
		document.getElementById("rsform").style.display="";//重置和提交按钮显示
	}
	else
	{	
		document.getElementById(fid).style.display="none";//之前显示,点击隐藏
	
	    dealrsform();//判断重置和提交按钮是否需隐藏
	}
	
}

function dealtype(ffindex){//控制修改文件类别的下拉框的显示和隐藏
	
	var ffid=ffindex+"mttext";
	if(document.getElementById(ffid).style.display=="none")
	{		
		document.getElementById(ffid).style.display="";//若之前隐藏，点击后显示
		document.getElementById("rsform").style.display="";//重置和提交按钮显示
	}
	else
	{
		document.getElementById(ffid).style.display="none";//之前显示,点击隐藏
	
	
	    dealrsform();//判断重置和提交按钮是否需隐藏
	}
}

function dealrsform(){//判断重置和隐藏按钮是否需隐藏,当所有修改文件名的文本框和
	var flag=true;    //修改文件类别的下拉框都隐藏时,执行重置和提交按钮隐藏操作
	for(x=0;x<<%=fl.getFr().size()%>;x++){
		if(document.getElementById(x+"mttext").style.display==""){
			flag=false;
			break;
		}
		if(document.getElementById(x+"mftext").style.display==""){
			flag=false;
			break;
		}
	}
	if(flag)
		document.getElementById("rsform").style.display="none";
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
  
  <div id=bottom style="left:420px">
   <center>
 <%if(fl.getFr().size()>0){//如果查询的文件集中有记录,则显示记录页面 %> 
 
 <form method="post" action="FileModify">

 <%if("true".equals(request.getParameter("flag"))){ %>
<table><tr><td class=blackbold>文件名冲突！</td></tr></table>
<br>
<%} %>
 <table border=1  cellspacing="0" bordercolor="#00CCCC">
 <caption class=blackbold>查询结果</caption>
 <tr>
 <th width=80px>上传用户</td>
 <th width=210>文件名</td>
 <th>文件路径</td>
 <th width=120>文件类别</td>
 <th width=80px>下载</td>
 <th width=80px>删除</td>
 </tr>
 
 <%
 
 for(int i=0;i<fl.getFr().size();i++){
 %>
 <tr height=50px>
 <td align=center><%= fl.getFr().get(i).getId() %></td>
 
 <td align=center>
 <%= fl.getFr().get(i).getName() %>
 <div>
 <a  class=bluebold href="javascript:void" onClick="dealfile(<%=i%>)">修改</a>
 <span id=<%=i+"mftext" %> style="display:none">:<input type=text name=<%="fn"+fl.getFr().get(i).getName() %>></span>
 </div>
 </td>
 
 <td align=center><%= fl.getFr().get(i).getPath() %></td>
 
 <td align=center>
 <%= fl.getFr().get(i).getFiletype() %>
 <div>
 <a  class=bluebold href="javascript:void" onClick="dealtype(<%=i%>)">修改</a>
 <span id=<%=i+"mttext" %> style="display:none">:
<select name=<%="ft"+fl.getFr().get(i).getName() %> >
  <option value="" checked></option>
  <%
      for(int j=0;j<ft.getTypes().size();j++){
   %>
      <option value=<%= ft.getTypes().get(j)%> >
      <%= ft.getTypes().get(j) %>
      </option>
   
   <% 	  
      }
  %>
     
  </select>
 
 </span>
 </div>
 </td>
 
 <td align=center><a class=bluebold href="download.jsp?path=<%= fl.getFr().get(i).getPath()   %>&&name=<%=fl.getFr().get(i).getName()%>">下载文件</a></td>
 <td align=center><a class=bluebold href="deletefilerecord?name=<%= fl.getFr().get(i).getName()   %>">删除记录</a></td>
 </tr>
 
 <%} %>
 
 <tr id="rsform" style="display:none">
 <td align=center colspan=3><input name="提交" type=submit value=修改></td>
 <td align=center colspan=3><input name="重置" type=reset value=重设></td>
 </tr>
 </table>

 </form>
 <%}
 else{//当文件查询结果集中没有记录时,提示用户
 
%>
  <div class=blackbold>
  没有查到符合条件的文件！
  </div>
  <%} %>
  </center>
  </div>
</body>
</html>