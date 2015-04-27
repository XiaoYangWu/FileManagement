/*封装用户填写的表单和要上传的文件的信息**/
package bean;

public class FileUnloadForm {
    private String filename;//用户要存放在数据库中的文件名
    private String fileclass;
    private String userclass;
    private String path;
    private String actualFileName;//实际文件名
	public String getActualFileName() {
		return actualFileName;
	}
	public void setActualFileName(String actualFileName) {
		this.actualFileName = actualFileName;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFileclass() {
		return fileclass;
	}
	public void setFileclass(String fileclass) {
		this.fileclass = fileclass;
	}
	public String getUserclass() {
		return userclass;
	}
	public void setUserclass(String userclass) {
		this.userclass = userclass;
	}
}
