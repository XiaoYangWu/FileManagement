/*��װ�û���д�ı���Ҫ�ϴ����ļ�����Ϣ**/
package bean;

public class FileUnloadForm {
    private String filename;//�û�Ҫ��������ݿ��е��ļ���
    private String fileclass;
    private String userclass;
    private String path;
    private String actualFileName;//ʵ���ļ���
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
