<!-- ��ҳ��������ʾ�û������ļ���ѯ�Ľ�� -->
<%@page import="bean.User"%>
<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>

<jsp:useBean id="fl"   scope="session" class="bean.FileList"/>
<jsp:useBean id="ft" scope="session" class="bean.FileType"></jsp:useBean> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ѯ���</title>
<link href="mycss.css" rel="stylesheet" type="text/css">
<script language="javascript">

function dealfile(findex){//�����޸��ļ������ı������ʾ������
	
	var fid=findex+"mftext";
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

function dealtype(ffindex){//�����޸��ļ��������������ʾ������
	
	var ffid=ffindex+"mttext";
	if(document.getElementById(ffid).style.display=="none")
	{		
		document.getElementById(ffid).style.display="";//��֮ǰ���أ��������ʾ
		document.getElementById("rsform").style.display="";//���ú��ύ��ť��ʾ
	}
	else
	{
		document.getElementById(ffid).style.display="none";//֮ǰ��ʾ,�������
	
	
	    dealrsform();//�ж����ú��ύ��ť�Ƿ�������
	}
}

function dealrsform(){//�ж����ú����ذ�ť�Ƿ�������,�������޸��ļ������ı����
	var flag=true;    //�޸��ļ���������������ʱ,ִ�����ú��ύ��ť���ز���
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
  
  <div id=bottom style="left:420px">
   <center>
 <%if(fl.getFr().size()>0){//�����ѯ���ļ������м�¼,����ʾ��¼ҳ�� %> 
 
 <form method="post" action="FileModify">

 <%if("true".equals(request.getParameter("flag"))){ %>
<table><tr><td class=blackbold>�ļ�����ͻ��</td></tr></table>
<br>
<%} %>
 <table border=1  cellspacing="0" bordercolor="#00CCCC">
 <caption class=blackbold>��ѯ���</caption>
 <tr>
 <th width=80px>�ϴ��û�</td>
 <th width=210>�ļ���</td>
 <th>�ļ�·��</td>
 <th width=120>�ļ����</td>
 <th width=80px>����</td>
 <th width=80px>ɾ��</td>
 </tr>
 
 <%
 
 for(int i=0;i<fl.getFr().size();i++){
 %>
 <tr height=50px>
 <td align=center><%= fl.getFr().get(i).getId() %></td>
 
 <td align=center>
 <%= fl.getFr().get(i).getName() %>
 <div>
 <a  class=bluebold href="javascript:void" onClick="dealfile(<%=i%>)">�޸�</a>
 <span id=<%=i+"mftext" %> style="display:none">:<input type=text name=<%="fn"+fl.getFr().get(i).getName() %>></span>
 </div>
 </td>
 
 <td align=center><%= fl.getFr().get(i).getPath() %></td>
 
 <td align=center>
 <%= fl.getFr().get(i).getFiletype() %>
 <div>
 <a  class=bluebold href="javascript:void" onClick="dealtype(<%=i%>)">�޸�</a>
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
 
 <td align=center><a class=bluebold href="download.jsp?path=<%= fl.getFr().get(i).getPath()   %>&&name=<%=fl.getFr().get(i).getName()%>">�����ļ�</a></td>
 <td align=center><a class=bluebold href="deletefilerecord?name=<%= fl.getFr().get(i).getName()   %>">ɾ����¼</a></td>
 </tr>
 
 <%} %>
 
 <tr id="rsform" style="display:none">
 <td align=center colspan=3><input name="�ύ" type=submit value=�޸�></td>
 <td align=center colspan=3><input name="����" type=reset value=����></td>
 </tr>
 </table>

 </form>
 <%}
 else{//���ļ���ѯ�������û�м�¼ʱ,��ʾ�û�
 
%>
  <div class=blackbold>
  û�в鵽�����������ļ���
  </div>
  <%} %>
  </center>
  </div>
</body>
</html>