<!-- �����û������ز��� -->
<%@page import="bean.User"%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="com.jspsmart.upload.*" %>
<%
   //��û��½����session���ڻص���ҳ��
   User user=(User)session.getAttribute("user");

   if(user==null){
      response.sendRedirect("index.jsp");
      return;
   }

   request.setCharacterEncoding("gb2312");
   if(request.getParameter("path")==null)//����½����path����Ϊ�շ����û���¼��ҳ��,���û�ֱ����url����û�����������
   {
	   response.sendRedirect("commonuser.jsp");
	      return;
   }
   String path=new String(request.getParameter("path").getBytes("iso-8859-1"),"gb2312");
   String name=new String(request.getParameter("name").getBytes("iso-8859-1"),"gb2312");
    // �½�һ��SmartUpload����
	SmartUpload su = new SmartUpload();
	// ��ʼ��
	su.initialize(pageContext);
	// �趨contentDispositionΪnull�Խ�ֹ������Զ����ļ�
	su.setContentDisposition(null);
	// �����ļ�
	try{
	su.downloadFile(path,"text/html;charset=gb2312",name);
	}
	catch(Exception e){//������ص��û���¼��ҳ��
		 response.sendRedirect("commonuser.jsp");
	      return;
	}
%>

