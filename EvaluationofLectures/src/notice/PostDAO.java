package notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class PostDAO {

	public String getDate() {
		String SQL = "select now()";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String SQL = "select noticeID from notice order by noticeID desc";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // db오류
	}

	public int write(String noticeTitle, String managerID, String noticeContent) {
		String SQL = "insert into notice values (?, ?, ?, ?, ?, ?)";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext());
			pstmt.setString(2,  noticeTitle.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3,  managerID.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(4,  getDate());
			pstmt.setString(5,  noticeContent.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setInt(6,  1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int setNotice() {
		String SQL = "set @cnt = 0; update notice set noticeID=@cnt:=@cnt+1;";
		// cnt를 0을 초기화 한 후 update 돌면서 cnt 1씩 증가 
		// 즉 번호 재정렬
		// @ : 프로시저가 끝나도 계속 유지되는 값

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // db오류
	}	
	
	public ArrayList<Post> getList(int pageNumber) {
		String SQL = "select * from notice where noticeID < ? and noticeAvailable = 1 order by noticeID desc limit 10";

		ArrayList<Post> list = new ArrayList<Post>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10); // getNext() : 다음으로 작성될 번호
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Post post = new Post();
				post.setNoticeID(rs.getInt(1));
				post.setNoticeTitle(rs.getString(2));
				post.setManagerID(rs.getString(3));
				post.setNoticeDate(rs.getString(4));
				post.setNoticeContent(rs.getString(5));
				post.setNoticeAvailable(rs.getInt(6));
				list.add(post);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean nextPage(int pageNumber) {
		// 페이징 처리를 위한 함수
		String SQL = "select * from notice where noticeID < ? and noticeAvailable = 1";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10); // getNext() : 다음으로 작성될 번호
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public Post getNotice(int noticeID) {
		String SQL = "select * from notice where noticeID = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  noticeID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Post post = new Post();
				post.setNoticeID(rs.getInt(1));
				post.setNoticeTitle(rs.getString(2));
				post.setManagerID(rs.getString(3));
				post.setNoticeDate(rs.getString(4));
				post.setNoticeContent(rs.getString(5));
				post.setNoticeAvailable(rs.getInt(6));
				return post;
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public int update(int noticeID, String noticeTitle, String noticeContent) {
		String SQL = "update notice set noticeTitle=?, noticeContent=? where noticeID=?";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  noticeTitle);
			pstmt.setString(2,  noticeContent);
			pstmt.setInt(3,  noticeID);		
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int noticeID) {
		String SQL = "delete from notice where noticeID=?";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  noticeID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int count() {
		int total = 0;
		
		String sql = "select count(*) from notice";
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();	
			if (rs.next()) {
				total = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) { e.printStackTrace(); }
		}
		return total;
	}
	
}
