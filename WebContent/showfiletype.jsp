<!-- ��ҳ��������ʾ�ļ���� -->
<%@page import="bean.User"%>
<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
   
 <jsp:useBean id="ft" scope="session" class="bean.FileType"></jsp:useBean>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ļ�������</title>
<link href="mycss.css" rel="stylesheet" type="text/css">
<script language="javascript">
var index=0;
function mtype(findex){//�����޸��ļ������ı������ʾ������
	
	var fid=findex+"mtype";
	if(document.getElementById(fid).style.display=="none")
	{
		document.getElementById(fid).style.display="";//��֮ǰ���أ��������ʾ
		document.getElementById("rsform").style.display="";//���ú��ύ��ť��ʾ
	}
	else
	{	
		document.getElementById(fid).style.display="none";//֮ǰ��ʾ,�������
		dealrsform();//�ж����ú��ύ��ť�Ƿ�������
	   
	}
	
}

function addtype(){//ʵ�ֶ�̬������������ļ������ı���
	
	document.getElementById("rsform").style.display="";//���ú��ύ��ť��ʾ
	
	var typetable=document.getElementById("addtype").getElementsByTagName("table")[0];
	if(index==0){//��һ���ı�����ӵ��Ѿ������õĵ�һ�еڶ���
		var typetd=typetable.getElementsByTagName("tr")[0].getElementsByTagName("td")[1];
		typetd.innerHTML="<input type=text name=0addtype>";
		
		retd=document.createElement("td");
		retd.innerHTML="<a href=javascript:void(0) onclick=remove() class=blackbold>ɾ��</a>";
		typetable.getElementsByTagName("tr")[0].appendChild(retd);
	}
	else{//֮����ı����ڵ����½���һ����
		

		ttextvalue=index+"addtype";//�����ӵ��ı����nameֵ
	    
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
        
        dealrsform();//�ж����ú��ύ��ť�Ƿ�������
	}
	
}
function dealrsform(){//�ж����ú����ذ�ť�Ƿ�������,�������޸��ļ��������ı����
	var flag=true;    //�����ļ������ı�������ʱ,ִ�����ú��ύ��ť���ز���
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
if(0==ft.getTypes().size())//���FileType�ļ�¼����Ϊ0,���û���û�в�ѯ�����ݿ��е��ļ������Ϣ���Ȳ�ѯ���ݿ�������Щ�ļ���𣬴���FileType������
     ft.fileInDatabase(application);//��ѯ���ݿ�������Щ�ļ���𣬴���ft������
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
  
  <div id=bottom style="left:600px">
<form method=post action="TypeModify">
<center>
<%if("true".equals(request.getParameter("flag"))){ %>
<table><tr><td class=blackbold>������ͻ��</td></tr></table>
<br>
<%} %>

<%if(ft.getTypes().size()>0){ %>
<table border=1  cellspacing="0" bordercolor="#00CCCC">
<caption class=blackbold>�ļ����</caption>
<tr>
 <th width=100px>�ļ������</th>
 <th width=110px>�޸�</th>
 <th width=110px>ɾ��</th>
 </tr>
 
 <%
 int i=0;
 
 for( i=0;i<ft.getTypes().size();i++){
 %>
 
 <tr height=30px>
 <td align=center><%=ft.getTypes().get(i)%></td>
 <td align=center><a class=bluebold href="javascript:void(0)" onClick="mtype(<%=i%>)">�޸�����</a>
 <span id=<%=i+"mtype" %> style="display:none">:<input type=text name=<%=i+"mtype" %>></span>
 </td>
 <td align=center><a class=bluebold href="CancelType?name=<%=ft.getTypes().get(i) %>">ɾ�����</a></td>
 </tr>
 
 <%} %>
 
</table>
<%}
else{//û���ļ����ʱ
%>
 <div class=blackbold>
  û���ļ����
  </div>
 <%} %>
<br><br>
<div id="addtype">
<table >
<tr>
<td align=left width=130>
<a class=blackbold href="javascript:void(0)" onClick="addtype()">�����ļ����</a>
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
<input class=mybutton type=submit value=�ύ>
</td>
<td width=30px></td>
<td>
<input class=mybutton type=reset value=����>
</td>
</tr>
</table>
</div>

</center>
</form>  
</div>
</body>
</html>