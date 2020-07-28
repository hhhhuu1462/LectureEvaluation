package report;

public class ReportDTO {
	private String userID;
	private String userIP;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserIP() {
		return userIP;
	}
	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}
	
	public ReportDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public ReportDTO(String userID, String userIP) {
		super();
		this.userID = userID;
		this.userIP = userIP;
	}	
	
}
