/*�����û���½ʱ��д����Ϣ������֤**/

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
    public boolean validate(ServletContext sc) throws UnavailableException{//��֤�û�������û��������Ƿ���ȷ
    	String id=user.getId();
	    String password=user.getPassword();
	    
    	
	    Connection conn=null;
    	Statement stmt=null;
    	ResultSet rs=null;
    	
    	//�������ݿ�
    	ConnectDatabase.init(sc);
    	conn=ConnectDatabase.connect();
    	
    	try{
    		stmt=conn.createStatement();
    		
    	    	rs=stmt.executeQuery("select * from user where id='"+id+"'");
    		   if(!rs.next()){
        		   return false;//�������Ϊ��,�û�������û�������ȷ 
        	   }
    		   else if(password.equals(rs.getString(3)))//�û���������������ȷ
       		   {
       			   user.setName(rs.getString(2));//��֤ͨ��,�����ݿ����û��������浽user������
    			   return true;
       		   }
       		   else
       		   {
       			   return false;//�û������ڵ������������
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
