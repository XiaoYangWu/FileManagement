<!--�ṩ�ļ���ѯ�ı�  -->
<%@page import="bean.User"%>
<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>

<jsp:useBean id="ft" scope="session" class="bean.FileType"></jsp:useBean> <!-- �ļ�������� -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ļ���ѯ</title>
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
  <div id=bottom style="left:680px">
  <form name="searchForm" action="" method="post" onClick="fsubmit()">
       <input type="radio" name="rcond" onClick="hideall()">�鿴�����ļ�<p>
       
       <input type="radio" name="rcond" onClick="showname()">���ļ�������<p>
       <table id=fname style="DISPLAY: none">
          <tr>
             <td>�ļ���:</td>
             <td><input type="text" name="filename"></td>
          </tr>
       </table><p>
       
       <input type="radio" name="rcond" onClick="showkey()">�ļ���ģ������<p>
        <table id=fkey style="DISPLAY: none">
          <tr>
             <td>������ؼ���:</td>
             <td><input type="text" name="keyword"></td>
          </tr>
       </table><p>
       
       <input type="radio" name="rcond" onClick="showtype()">���ļ�������<p>
        
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
       
        <input type="radio" name="rcond" onClick="showuser()">���ϴ��û�����<p>
        <table id=fuserid style="DISPLAY: none">
          <tr>
             <td>������ѧ��:</td>
             <td><input type="text" name="fileuserid"></td>
          </tr>
       </table><p>
       
       <input class=mybutton name="�ύ" type="submit" value="����">
       <input class=mybutton name="����" type="reset" value="��������">
   </form> 
</div>
</body>
</html>