/**�����������ݿ�,���еķ��������Զ��Ǿ�̬��,�õ�Connection����
*/

package bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.UnavailableException;


public class ConnectDatabase {
	 private static String url;
	 private static String user;
	 private static String password;
	
	 public static String getUrl() {
		return url;
	}
	public static void setUrl(String url) {
		ConnectDatabase.url = url;
	}
	public static String getUser() {
		return user;
	}
	public static void setUser(String user) {
		ConnectDatabase.user = user;
	}
	public static String getPassword() {
		return password;
	}
	public static void setPassword(String password) {
		ConnectDatabase.password = password;
	}
	
	/**�������ݿ�����
	@param sc ���̵�Servlet�����Ķ���
	*/
	public static void init(ServletContext sc) throws UnavailableException{
           
	        String driverClass=sc.getInitParameter("driverClass");
			url=sc.getInitParameter("url");
			user=sc.getInitParameter("user");
			password=sc.getInitParameter("password");
			try{
				Class.forName(driverClass);
			}
			catch(ClassNotFoundException ce){
				throw new UnavailableException("�������ݿ�����ʧ��");
			}
	 }
	 
	/**�������ݿ�,����Connection����
	@return ����һ��Connection����
	*/
	public static Connection connect(){
		Connection conn=null;
		 try{
			conn=DriverManager.getConnection(url,user,password);
	       
	        
	     }
		 catch(SQLException se){se.printStackTrace();}
		 finally{
			 return conn;
		 }
		
	 }
	
	/**������һ������,��Ҫ�����Ƿ��Զ��ύʱʹ��
	@param ���÷��ص�Connection�Ƿ��Զ��ύ��
	@return ����һ��Connection����
	*/
	 public static 	Connection connect(boolean bool){
		 Connection conn=null;
		 try{
			conn=DriverManager.getConnection(url,user,password);
			conn.setAutoCommit(bool);
	       
	        
	     }
		 catch(SQLException se){se.printStackTrace();}
		 finally{
			 return conn;
		 }
		
	 }
}
