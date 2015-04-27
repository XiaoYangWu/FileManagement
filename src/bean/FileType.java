/*用来表示文件所有类别的信息**/
package bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.UnavailableException;

public class FileType {
     private ArrayList<String> types=new ArrayList<String>();
  
	public ArrayList<String> getTypes() {
		return types;
	}

	public void setTypes(ArrayList<String> types) {
		this.types = types;
	}

	public void fileInDatabase(ServletContext sc) throws UnavailableException{
		Connection conn=null;
    	Statement stmt=null;
    	ResultSet rs=null;
    	
    	//连接数据库
    	ConnectDatabase.init(sc);
    	conn=ConnectDatabase.connect();
    	int index=0;
    	
    	try{
    		stmt=conn.createStatement();
    	    rs=stmt.executeQuery("select * from file_type");
    	    
    	    while(rs.next()){
    	    	types.add(rs.getString(1));
    	    	
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
	}
}
