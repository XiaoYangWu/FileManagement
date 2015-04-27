/***处理用户的登录*/
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
	    
	    if(!"login".equals(action)){//若不是从主页登陆过来,回到主页填写表单进行登陆,action为主页隐藏文本框
	    	gotoPage("index.jsp",request,response);
	    }
	    else{
	    	//声明JavaBean对象进行登陆验证
	    	User user=new User();
	    	user.setId(id);
	    	user.setPassword(password);
	    	
	    	
	    	UserCheck uc=new UserCheck();
	    	uc.setUser(user);
	    	
	    	//登陆验证通过,在session记录用户
	    	if(uc.validate(sc))
	    	{
	    		HttpSession session=request.getSession();
	    		
	    		session.setAttribute("user",user);//session中记录用户信息
	    		
	    		
	    		gotoPage("commonuser.jsp",request,response);
	    		
	    	}
	    	else{//登陆名或密码错误,回到主页
	    		request.setAttribute("status","error");
	    		gotoPage("index.jsp",request,response);
	    	}
	    	
	    	
	    	
	    }
	}

	//将请求导向指定的页面
	private void gotoPage(String URL, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher rd=request.getRequestDispatcher(URL);
		rd.forward(request,response);
	}
	
	

}
