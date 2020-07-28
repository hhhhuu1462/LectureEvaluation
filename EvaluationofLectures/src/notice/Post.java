package notice;

public class Post {
		
	private int noticeID;
	private String noticeTitle;
	private String managerID;
	private String noticeDate;
	private String noticeContent;
	private int noticeAvailable;
	
	public int getNoticeID() {
		return noticeID;
	}
	public void setNoticeID(int noticeID) {
		this.noticeID = noticeID;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getManagerID() {
		return managerID;
	}
	public void setManagerID(String managerID) {
		this.managerID = managerID;
	}
	public String getNoticeDate() {
		return noticeDate;
	}
	public void setNoticeDate(String noticeDate) {
		this.noticeDate = noticeDate;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public int getNoticeAvailable() {
		return noticeAvailable;
	}
	public void setNoticeAvailable(int noticeAvailable) {
		this.noticeAvailable = noticeAvailable;
	}
	
	public Post() {
		// TODO Auto-generated constructor stub
	}
	public Post(int noticeID, String noticeTitle, String managerID, String noticeDate, String noticeContent,
			int noticeAvailable) {
		super();
		this.noticeID = noticeID;
		this.noticeTitle = noticeTitle;
		this.managerID = managerID;
		this.noticeDate = noticeDate;
		this.noticeContent = noticeContent;
		this.noticeAvailable = noticeAvailable;
	}
	
}
