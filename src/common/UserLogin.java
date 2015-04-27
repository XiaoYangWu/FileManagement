/***�����û��ĵ�¼*/
package common;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.User;
import bean.UserCheck;

/**
 * Servlet implementation class UserLogin
 */
public class UserLogin extends HttpServlet {
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
	    String id=request.getParameter("id");
	    String password=request.getParameter("passwd");
	   
	    String action=request.getParameter("action");
	    ServletContext sc=getServletContext();
	    
	    if(!"login".equals(action)){//�����Ǵ���ҳ��½����,�ص���ҳ��д�����е�½,actionΪ��ҳ�����ı���
	    	gotoPage("index.jsp",request,response);
	    }
	    else{
	    	//����JavaBean������е�½��֤
	    	User user=new User();
	    	user.setId(id);
	    	user.setPassword(password);
	    	
	    	
	    	UserCheck uc=new UserCheck();
	    	uc.setUser(user);
	    	
	    	//��½��֤ͨ��,��session��¼�û�
	    	if(uc.validate(sc))
	    	{
	    		HttpSession session=request.getSession();
	    		
	    		session.setAttribute("user",user);//session�м�¼�û���Ϣ
	    		
	    		
	    		gotoPage("commonuser.jsp",request,response);
	    		
	    	}
	    	else{//��½�����������,�ص���ҳ
	    		request.setAttribute("status","error");
	    		gotoPage("index.jsp",request,response);
	    	}
	    	
	    	
	    	
	    }
	}

	//��������ָ����ҳ��
	private void gotoPage(String URL, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher rd=request.getRequestDispatcher(URL);
		rd.forward(request,response);
	}
	
	

}
