/*作为控制器，定义FileType对象查询数据库文件类别的信息，之后转向文件上传表单页面**/
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
	    ft.fileInDatabase(sc);//查询数据库中有哪些文件类别，存入ft对象中
	    
	    session.setAttribute("ft",ft);//将文件类别信息加入session中
	    
	    RequestDispatcher rd=request.getRequestDispatcher("fileonload.jsp");//转向文件上传表单页面
		rd.forward(request,response);
	
	
	}

}
