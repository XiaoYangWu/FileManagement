/**用于连接数据库,所有的方法和属性都是静态的,得到Connection对象
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
	
	/**加载数据库驱动
	@param sc 工程的Servlet上下文对象，
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
				throw new UnavailableException("加载数据库驱动失败");
			}
	 }
	 
	/**连接数据库,返回Connection对象
	@return 返回一个Connection对象
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
	
	/**重载上一个方法,需要设置是否自动提交时使用
	@param 设置返回的Connection是否自动提交。
	@return 返回一个Connection对象
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
