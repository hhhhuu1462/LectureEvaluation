package manager;

public class ManagerDTO {

	private String managerID;
	private String managerPassword;
	private String managerName;
	private String managerGender;
	private String managerEmail;
	private String phoneNumber;
	private String managerEmailHash;
	private boolean managerEmailChecked;
	
	public String getManagerID() {
		return managerID;
	}
	public void setManagerID(String managerID) {
		this.managerID = managerID;
	}
	public String getManagerPassword() {
		return managerPassword;
	}
	public void setManagerPassword(String managerPassword) {
		this.managerPassword = managerPassword;
	}
	public String getManagerName() {
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	public String getManagerGender() {
		return managerGender;
	}
	public void setManagerGender(String managerGender) {
		this.managerGender = managerGender;
	}
	public String getManagerEmail() {
		return managerEmail;
	}
	public void setManagerEmail(String managerEmail) {
		this.managerEmail = managerEmail;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getManagerEmailHash() {
		return managerEmailHash;
	}
	public void setManagerEmailHash(String managerEmailHash) {
		this.managerEmailHash = managerEmailHash;
	}
	public boolean isManagerEmailChecked() {
		return managerEmailChecked;
	}
	public void setManagerEmailChecked(boolean managerEmailChecked) {
		this.managerEmailChecked = managerEmailChecked;
	}
	
	public ManagerDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public ManagerDTO(String managerID, String managerPassword, String managerName, String managerGender,
			String managerEmail, String phoneNumber, String managerEmailHash, boolean managerEmailChecked) {
		super();
		this.managerID = managerID;
		this.managerPassword = managerPassword;
		this.managerName = managerName;
		this.managerGender = managerGender;
		this.managerEmail = managerEmail;
		this.phoneNumber = phoneNumber;
		this.managerEmailHash = managerEmailHash;
		this.managerEmailChecked = managerEmailChecked;
	}	
	
}
