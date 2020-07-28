package user;

public class UserDTO {
	private int userNo;
	private String userId;
	private String userPassword;
	private String userName;
	private String userGender;
	private String userEmail;
	private String phoneNumber;
	private String userEmailHash;
	private boolean userEmailChecked;
	private int reportCount;
	
	public int getReportCount() {
		return reportCount;
	}
	public void setReportCount(int reportCount) {
		this.reportCount = reportCount;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}	
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserEmailHash() {
		return userEmailHash;
	}
	public void setUserEmailHash(String userEmailHash) {
		this.userEmailHash = userEmailHash;
	}
	public boolean isUserEmailChecked() {
		return userEmailChecked;
	}
	public void setUserEmailChecked(boolean userEmailChecked) {
		this.userEmailChecked = userEmailChecked;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
		
	public UserDTO() {
		
	}
	public UserDTO(int userNo, String userId, String userPassword, String userName, String userGender, String userEmail, String phoneNumber,
			String userEmailHash, boolean userEmailChecked, int reportCount) {
		super();
		this.userNo = userNo;
		this.userId = userId;
		this.userPassword = userPassword;
		this.userName = userName;
		this.userGender = userGender;
		this.userEmail = userEmail;
		this.phoneNumber = phoneNumber;
		this.userEmailHash = userEmailHash;
		this.userEmailChecked = userEmailChecked;
		this.reportCount = reportCount;
	}
	
}
