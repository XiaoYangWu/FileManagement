/*对数据库中文件表中的一行记录进行抽象**/
package bean;

public class FileRecord {
    private String id;//提交该文件用户的学号
    private String name;//文件名
    private String path;
    private String filetype;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getFiletype() {
		return filetype;
	}
	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}
    
    
}
