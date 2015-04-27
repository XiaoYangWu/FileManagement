/*��Ϊ������������FileType�����ѯ���ݿ��ļ�������Ϣ��֮��ת���ļ��ϴ���ҳ��**/
package common;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.FileType;
import bean.User;

/**
 * Servlet implementation class FileOnloadSelect
 */
public class FileOnloadSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
  

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	    doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("user");
		if(user==null){
			response.sendRedirect("index.jsp");
			return;
		}
		ServletContext sc=getServletContext();
	    FileType ft=new FileType();
	    ft.fileInDatabase(sc);//��ѯ���ݿ�������Щ�ļ���𣬴���ft������
	    
	    session.setAttribute("ft",ft);//���ļ������Ϣ����session��
	    
	    RequestDispatcher rd=request.getRequestDispatcher("fileonload.jsp");//ת���ļ��ϴ���ҳ��
		rd.forward(request,response);
	
	
	}

}
