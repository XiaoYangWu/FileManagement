<!-- �û��ϴ��ļ�����д�ı�ҳ�� -->
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
<title>�ϴ��ļ�</title>
<link href="mycss.css" rel="stylesheet" type="text/css">
<script language="javascript">

var index=1;

function fadd(){//���һ���ϴ��ļ�������д�ı��
	if(index==1)
		document.getElementById("fcancel").style.display="";//��һ�����ʱ��ɾ����ť��ʾ
    
	var fdiv=document.getElementById("fonload");//��ȡ�����ڵ�divԪ��
	var fDivTable=fdiv.getElementsByTagName("div")[0];//��ȡ��һ�����
	
	var newDivTable=fDivTable.cloneNode(true);//���Ƶ��µı��
	
	//�޸��±��ĸ���Ԫ�ص�����
	var ftable=newDivTable.getElementsByTagName("table")[0];
	var moattr0=ftable.getElementsByTagName("tr")[0].getElementsByTagName("td")[1].getElementsByTagName("input")[0];
	var moattr1=ftable.getElementsByTagName("tr")[1].getElementsByTagName("td")[1].getElementsByTagName("input")[0];
	var moattr2=ftable.getElementsByTagName("tr")[2].getElementsByTagName("td")[1].getElementsByTagName("select")[0];
	var moattr3=ftable.getElementsByTagName("tr")[3].getElementsByTagName("td")[1].getElementsByTagName("input")[0];
	
	moattr0.setAttribute("name",index+"file"); 
	moattr1.setAttribute("name",index+"fname"); 
	moattr2.setAttribute("name",index+"fileclass"); 
	moattr3.setAttribute("name",index+"userclass"); 
	
	
	  fdiv.appendChild(newDivTable);//����µı��
	  index++;
}

function fremove(){//ɾ��һ���ϴ��ļ�������д�ı��
	index--;
	var fDivTable=document.getElementById("fonload").getElementsByTagName("div")[index];
	fDivTable.parentNode.removeChild(fDivTable);
	if(index==1)
		document.getElementById("fcancel").style.display="none";//ֻʣһ���ϴ��ļ����ʱɾ����ť����

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
  
  <div id=bottom>
   <%
  
    //��ȡ�洢�ļ�ʧ����Ϣ�Ķ���
    HashMap<String,String> status=(HashMap<String,String>)request.getAttribute("statuss");
    
    if(status!=null){
    
       if(status.size()==0){
   %>
   
   <div class=blackbold style="font-weight:bold">
   �����ļ����ϴ��ɹ�,��ӭ�����ϴ���
   
   </div>
   
   <%}
       else{//����Ļ��ʾ�����ļ�����Ϣ
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
  <a href="javascript:void(0)" onClick="fadd()" class=blackbold>����</a>
  <a  id=fcancel href="javascript:void(0)" onClick="fremove()" style="display:none" class=blackbold>ɾ��</a>  </td>
  </tr>
  </table>
  </div>
  
  <form  method=post action="doFileOnload.jsp" enctype="multipart/form-data">
  
  <div id=fonload>
  
  <div>
  <table>
  
  <tr>
  <td>ѡ���ļ�:</td>
  <td><input type=file name=0file size=15></td>
  </tr>
  
  <tr>
  <td>�ļ���</td>
  <td><input type=text name=0fname size=15>(<font color=red>����Ҫ����д</font>)</td>
  </tr>
  
  <tr>
  <td>�ļ����</td>
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
  <td>�Զ������:</td>
  <td><input type=text name=0userclass size=15>(<font color=red>����Ҫ����д</font>)</td>
  </tr>
  </table>
  <br>
  </div>
  </div>
  
  
  <table>
  <tr>
  <td width=40px></td>
  <td><input class=mybutton name="�ύ" type=submit value=�ϴ�></td>
  <td width=40px></td>
  <td><input class=mybutton name="����" type=reset value=����ѡ��></td>
  </tr>
  </table>
  </form>
  </div>
  </div>
</body>
</html>

