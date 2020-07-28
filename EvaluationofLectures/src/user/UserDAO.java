package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import notice.Post;
import util.DatabaseUtil;

public class UserDAO {

	// 아이디와 비밀번호를 받아 로그인 시도
	public int login(String userID, String userPassword) {
		String sql = "select userPassword from user where userID = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				} else {
					return 0; // 비밀번호 틀림
				}
			}
			return -1; // 아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) { e.printStackTrace(); }
		}
		return -2; //db 오류
	}

	public int getNext() {
		String SQL = "select userNo from user order by userNo desc";

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

	
	// 사용자의 정보를 입력받아 회원가입
	public int join(String userID, String userPassword, String userName, String userGender, String userEmail, String phoneNumber, String userEmailHash) {
		String sql = "insert ignore into user values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,  getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, userPassword);
			pstmt.setString(4, userName);
			pstmt.setString(5, userGender);
			pstmt.setString(6, userEmail);
			pstmt.setString(7, phoneNumber);
			pstmt.setString(8, userEmailHash);
			pstmt.setBoolean(9, false);
			pstmt.setInt(10, 0);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) { e.printStackTrace(); }
		}
		return -1; // 회원가입 실패
	}
	// 사용자의 정보를 불러오기
	public UserDTO getData(String userID) {
		UserDTO userDTO = null;

		String sql = "select userNo, userID, userPassword, userName, userGender, userEmail, phoneNumber from user where userID like ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userDTO = new UserDTO();
				userDTO.setUserNo(Integer.parseInt(rs.getString("userNo")));
				userDTO.setUserId(rs.getString("userID"));
				userDTO.setUserPassword(rs.getString("userPassword"));
				userDTO.setUserName(rs.getString("userName"));
				userDTO.setUserGender(rs.getString("userGender"));
				userDTO.setUserEmail(rs.getString("userEmail"));
				userDTO.setPhoneNumber(rs.getString("phoneNumber"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) { e.printStackTrace(); }
		}
		return userDTO;
	}		

	// 회원정보 수정
	public int modifyData(String userID, String userPassword, String userName, String userGender, String userEmail, String phoneNumber) {
		String sql = "update user set userID=?, userPassword=?, userName=?, userGender=?, userEmail=?, phoneNumber=? where userID=?";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  userID);
			pstmt.setString(2,  userPassword);
			pstmt.setString(3,  userName);
			pstmt.setString(4,  userGender);
			pstmt.setString(5,  userEmail);
			pstmt.setString(6,  phoneNumber);
			pstmt.setString(7,  userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) { e.printStackTrace(); }
		}
		return -1; // 회원가입 실패
	}	

	// 사용자가 이메일 인증을 했는지에 대한 여부
	public boolean getUserEmailChecked(String userID) {
		String sql = "select userEmailChecked from user where userID = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getBoolean(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) { e.printStackTrace(); }
		}
		return false; // db 오류
	}

	// 사용자의 아이디값을 받아 그 사용자의 이메일 반환
	public String getUserEmail(String userID) {
		String sql = "select userEmail from user where userID = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) { e.printStackTrace(); }
		}
		return null; // db 오류
	}

	// 특정한 사용자의 이메일 인증 시행
	public boolean setUserEmailChecked(String userID) {
		String sql = "update user set userEmailChecked = true where userID = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);			
			pstmt.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) { e.printStackTrace(); }
		}
		return false; // db 오류
	}

	public int count() {
		int total = 0;
		
		String sql = "select count(*) from user";
	
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
	
	public int report(String reportTarget) {
		String sql = "update user set reportCount = reportCount + 1 where userID = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,reportTarget);				
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) { e.printStackTrace(); }
		}
		return -1; // db 오류
	}
	
	public int setNotice() {
		String SQL = "set @cnt = 0; update user set userNo=@cnt:=@cnt+1;";
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
	
	public ArrayList<UserDTO> getList() {
		String SQL = "select userNo, userName, userID, phoneNumber from user"; 

		ArrayList<UserDTO> list = new ArrayList<UserDTO>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				UserDTO userDTO = new UserDTO();
				userDTO.setUserNo(rs.getInt(1));
				userDTO.setUserName(rs.getString(2));
				userDTO.setUserId(rs.getString(3));		
				userDTO.setPhoneNumber(rs.getString(4));				
				list.add(userDTO);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int sum_reportCount(String reportTarget) {
		int total = 0;
		
		String sql = "select reportCount from user where userID = ?";
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reportTarget);			
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
	
	public int delete_user(String userID) {
		String sql = "delete from user where userID = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) { e.printStackTrace(); }
		}
		return -1; // db 오류
	}

}
