/*对于用户登陆时填写的信息进行验证**/

package bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.UnavailableException;

public class UserCheck {
    private User user;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
    public boolean validate(ServletContext sc) throws UnavailableException{//验证用户输入的用户名密码是否正确
    	String id=user.getId();
	    String password=user.getPassword();
	    
    	
	    Connection conn=null;
    	Statement stmt=null;
    	ResultSet rs=null;
    	
    	//连接数据库
    	ConnectDatabase.init(sc);
    	conn=ConnectDatabase.connect();
    	
    	try{
    		stmt=conn.createStatement();
    		
    	    	rs=stmt.executeQuery("select * from user where id='"+id+"'");
    		   if(!rs.next()){
        		   return false;//结果集中为空,用户输入的用户名不正确 
        	   }
    		   else if(password.equals(rs.getString(3)))//用户名存在且密码正确
       		   {
       			   user.setName(rs.getString(2));//验证通过,将数据库中用户姓名保存到user对象中
    			   return true;
       		   }
       		   else
       		   {
       			   return false;//用户名存在但密码输入错误
       		   }
    		   
    	    
    	    
    		
    			
    	 
    	}
    	catch(SQLException se){}
    	finally{
    		
        	if(rs!=null){
        		try{
        			rs.close();
        		}
        		catch(SQLException se){
        			se.printStackTrace();
        		}
        		rs=null;
        	}
        	if(stmt!=null){
        		try{
        			stmt.close();
        		}
        		catch(SQLException se){
        			se.printStackTrace();
        		}
        		stmt=null;
        	}
        	if(conn!=null){
        		try{
        			conn.close();
        		}
        		catch(SQLException se){
        			se.printStackTrace();
        		}
        		conn=null;
        	}
    	}
    	return false;
    }
}
