<!-- 用户上传文件所填写的表单页面 -->
<%@page import="bean.User"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>

 <jsp:useBean id="ft" scope="session" class="bean.FileType"></jsp:useBean> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>上传文件</title>
<link href="mycss.css" rel="stylesheet" type="text/css">
<script language="javascript">

var index=1;

function fadd(){//添加一个上传文件所需填写的表格
	if(index==1)
		document.getElementById("fcancel").style.display="";//第一次添加时让删除按钮显示
    
	var fdiv=document.getElementById("fonload");//获取表单所在的div元素
	var fDivTable=fdiv.getElementsByTagName("div")[0];//获取第一个表格
	
	var newDivTable=fDivTable.cloneNode(true);//复制得新的表格
	
	//修改新表格的各表单元素的属性
	var ftable=newDivTable.getElementsByTagName("table")[0];
	var moattr0=ftable.getElementsByTagName("tr")[0].getElementsByTagName("td")[1].getElementsByTagName("input")[0];
	var moattr1=ftable.getElementsByTagName("tr")[1].getElementsByTagName("td")[1].getElementsByTagName("input")[0];
	var moattr2=ftable.getElementsByTagName("tr")[2].getElementsByTagName("td")[1].getElementsByTagName("select")[0];
	var moattr3=ftable.getElementsByTagName("tr")[3].getElementsByTagName("td")[1].getElementsByTagName("input")[0];
	
	moattr0.setAttribute("name",index+"file"); 
	moattr1.setAttribute("name",index+"fname"); 
	moattr2.setAttribute("name",index+"fileclass"); 
	moattr3.setAttribute("name",index+"userclass"); 
	
	
	  fdiv.appendChild(newDivTable);//添加新的表格
	  index++;
}

function fremove(){//删除一个上传文件所需填写的表格
	index--;
	var fDivTable=document.getElementById("fonload").getElementsByTagName("div")[index];
	fDivTable.parentNode.removeChild(fDivTable);
	if(index==1)
		document.getElementById("fcancel").style.display="none";//只剩一个上传文件表格时删除按钮隐藏

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
  
  <div id=bottom>
   <%
  
    //获取存储文件失败信息的对象
    HashMap<String,String> status=(HashMap<String,String>)request.getAttribute("statuss");
    
    if(status!=null){
    
       if(status.size()==0){
   %>
   
   <div class=blackbold style="font-weight:bold">
   您的文件已上传成功,欢迎继续上传！
   
   </div>
   
   <%}
       else{//在屏幕显示出错文件的信息
    	   for(Map.Entry<String, String> entry : status.entrySet()) {
    		  String filename=entry.getKey();  
    		   String failType=entry.getValue();
    %>
        
        <div class=blackbold style="font-weight:bold" >
         
         <%=filename+failType %>
        
        </div>
        
    <% 	   
    	   
    	   }
    	  
       }
    }
   
   %>
   
  
  
	 <br>
  
  <div >
  
  <div>
  <table width=330>
  <tr>
  <td align=left>
  <a href="javascript:void(0)" onClick="fadd()" class=blackbold>增加</a>
  <a  id=fcancel href="javascript:void(0)" onClick="fremove()" style="display:none" class=blackbold>删除</a>  </td>
  </tr>
  </table>
  </div>
  
  <form  method=post action="doFileOnload.jsp" enctype="multipart/form-data">
  
  <div id=fonload>
  
  <div>
  <table>
  
  <tr>
  <td>选择文件:</td>
  <td><input type=file name=0file size=15></td>
  </tr>
  
  <tr>
  <td>文件名</td>
  <td><input type=text name=0fname size=15>(<font color=red>若需要请填写</font>)</td>
  </tr>
  
  <tr>
  <td>文件类别</td>
  <td><select name=0fileclass >
  <%
      for(int i=0;i<ft.getTypes().size();i++){
   %>
      <option value=<%= ft.getTypes().get(i)%>><%= ft.getTypes().get(i) %></option>
   
   <% 	  
      }
      
  %>
      
  </select></td>
  </tr>
    
  <tr>
  <td>自定义类别:</td>
  <td><input type=text name=0userclass size=15>(<font color=red>若需要请填写</font>)</td>
  </tr>
  </table>
  <br>
  </div>
  </div>
  
  
  <table>
  <tr>
  <td width=40px></td>
  <td><input class=mybutton name="提交" type=submit value=上传></td>
  <td width=40px></td>
  <td><input class=mybutton name="重置" type=reset value=重新选择></td>
  </tr>
  </table>
  </form>
  </div>
  </div>
</body>
</html>

