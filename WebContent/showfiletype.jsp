<!-- 本页面用来显示文件类别 -->
<%@page import="bean.User"%>
<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
   
 <jsp:useBean id="ft" scope="session" class="bean.FileType"></jsp:useBean>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>文件类别管理</title>
<link href="mycss.css" rel="stylesheet" type="text/css">
<script language="javascript">
var index=0;
function mtype(findex){//控制修改文件类别的文本框的显示和隐藏
	
	var fid=findex+"mtype";
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

function addtype(){//实现动态添加用来增加文件类别的文本框
	
	document.getElementById("rsform").style.display="";//重置和提交按钮显示
	
	var typetable=document.getElementById("addtype").getElementsByTagName("table")[0];
	if(index==0){//第一个文本框添加到已经创建好的第一行第二列
		var typetd=typetable.getElementsByTagName("tr")[0].getElementsByTagName("td")[1];
		typetd.innerHTML="<input type=text name=0addtype>";
		
		retd=document.createElement("td");
		retd.innerHTML="<a href=javascript:void(0) onclick=remove() class=blackbold>删除</a>";
		typetable.getElementsByTagName("tr")[0].appendChild(retd);
	}
	else{//之后的文本框在单独新建的一行中
		

		ttextvalue=index+"addtype";//所增加的文本框的name值
	    
        typetr=document.createElement("tr");
		
		
		
		typetr.innerHTML="<td width=130></td><td width=130><input type=text name="+ttextvalue+"></td>";
		
	
		
		typetable.appendChild(typetr);
		
		
	    
		
	}
	
	index++;
}

function remove(){
	index--;
	
	if(index>0){
		var retr=document.getElementById("addtype").getElementsByTagName("table")[0].getElementsByTagName("tr")[index];
		retr.parentNode.removeChild(retr);

	}
	else{
		var retr=document.getElementById("addtype").getElementsByTagName("table")[0].getElementsByTagName("tr")[index];
        
		var retd=retr.getElementsByTagName("td")[2];
        var inputtd=retr.getElementsByTagName("td")[1];
        
        inputtd.innerHTML="";
        retd.parentNode.removeChild(retd);
        
        dealrsform();//判断重置和提交按钮是否需隐藏
	}
	
}
function dealrsform(){//判断重置和隐藏按钮是否需隐藏,当所有修改文件类名的文本框和
	var flag=true;    //增加文件类别的文本框都隐藏时,执行重置和提交按钮隐藏操作
	for(x=0;x<<%=ft.getTypes().size()%>;x++){
		if(document.getElementById(x+"mtype").style.display==""){
			flag=false;
			break;
		}
	}
	if(document.getElementById("addtype").getElementsByTagName("table")[0].getElementsByTagName("tr")[0].getElementsByTagName("td")[1].innerHTML!="")
		flag=false;
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
  
  <div id=bottom style="left:600px">
<form method=post action="TypeModify">
<center>
<%if("true".equals(request.getParameter("flag"))){ %>
<table><tr><td class=blackbold>类名冲突！</td></tr></table>
<br>
<%} %>

<%if(ft.getTypes().size()>0){ %>
<table border=1  cellspacing="0" bordercolor="#00CCCC">
<caption class=blackbold>文件类别</caption>
<tr>
 <th width=100px>文件类别名</th>
 <th width=110px>修改</th>
 <th width=110px>删除</th>
 </tr>
 
 <%
 int i=0;
 
 for( i=0;i<ft.getTypes().size();i++){
 %>
 
 <tr height=30px>
 <td align=center><%=ft.getTypes().get(i)%></td>
 <td align=center><a class=bluebold href="javascript:void(0)" onClick="mtype(<%=i%>)">修改类名</a>
 <span id=<%=i+"mtype" %> style="display:none">:<input type=text name=<%=i+"mtype" %>></span>
 </td>
 <td align=center><a class=bluebold href="CancelType?name=<%=ft.getTypes().get(i) %>">删除类别</a></td>
 </tr>
 
 <%} %>
 
</table>
<%}
else{//没有文件类别时
%>
 <div class=blackbold>
  没有文件类别！
  </div>
 <%} %>
<br><br>
<div id="addtype">
<table >
<tr>
<td align=left width=130>
<a class=blackbold href="javascript:void(0)" onClick="addtype()">增加文件类别</a>
</td>
<td width=130 ></td>
</tr>
</table>
</div>


<br><br><br>

<div>
<table id=rsform style="display:none">
<tr>
<td>
<input class=mybutton type=submit value=提交>
</td>
<td width=30px></td>
<td>
<input class=mybutton type=reset value=重填>
</td>
</tr>
</table>
</div>

</center>
</form>  
</div>
</body>
</html>