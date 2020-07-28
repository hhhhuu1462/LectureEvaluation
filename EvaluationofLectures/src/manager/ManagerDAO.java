package manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.DatabaseUtil;

public class ManagerDAO {
	
	// 아이디와 비밀번호를 받아 로그인 시도
		public int login(String managerID, String managerPassword) {
			String sql = "select managerPassword from manager where managerID = ?";

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				conn = DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, managerID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					if(rs.getString(1).equals(managerPassword)) {
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
		
		// 사용자의 정보를 입력받아 회원가입
		public int join(ManagerDTO manager) {
			String sql = "insert into manager values (?, ?, ?, ?, ?, ?, ?, false)";

			Connection conn = null;
			PreparedStatement pstmt = null;

			try {
				conn = DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, manager.getManagerID());
				pstmt.setString(2, manager.getManagerPassword());
				pstmt.setString(3, manager.getManagerName());
				pstmt.setString(4, manager.getManagerGender());
				pstmt.setString(5, manager.getManagerEmail());
				pstmt.setString(6, manager.getPhoneNumber());
				pstmt.setString(7, manager.getManagerEmailHash());
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
		public ManagerDTO getData(String managerID) {
			ManagerDTO managerDTO = null;

			String sql = "select managerID, managerPassword, managerName, managerGender, managerEmail, phoneNumber from manager where managerID like ?";

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				conn = DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, managerID);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					managerDTO = new ManagerDTO();
					managerDTO.setManagerID(rs.getString("managerID"));
					managerDTO.setManagerPassword(rs.getString("managerPassword"));
					managerDTO.setManagerName(rs.getString("managerName"));
					managerDTO.setManagerGender(rs.getString("managerGender"));
					managerDTO.setManagerEmail(rs.getString("managerEmail"));
					managerDTO.setPhoneNumber(rs.getString("phoneNumber"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {if(conn != null) conn.close();} catch (Exception e) { e.printStackTrace(); }
				try {if(pstmt != null) pstmt.close();} catch (Exception e) { e.printStackTrace(); }
			}
			return managerDTO;
		}		

		// 회원정보 수정
		public int modifyData(ManagerDTO managerDTO) {
			String sql = "update manager set managerPassword=?, managerName=?, managerGender=?, managerEmail=?, phoneNumber=? where managerID=?";

			Connection conn = null;
			PreparedStatement pstmt = null;

			try {
				conn = DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,  managerDTO.getManagerPassword());
				pstmt.setString(2,  managerDTO.getManagerName());
				pstmt.setString(3,  managerDTO.getManagerGender());
				pstmt.setString(4,  managerDTO.getManagerEmail());
				pstmt.setString(5,  managerDTO.getPhoneNumber());
				pstmt.setString(6,  managerDTO.getManagerID());
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
		public boolean getManagerEmailChecked(String managerID) {
			String sql = "select managerEmailChecked from manager where managerID = ?";

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				conn = DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, managerID);			
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
		public String getManagerEmail(String managerID) {
			String sql = "select managerEmail from manager where managerID = ?";

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				conn = DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, managerID);			
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
		public boolean setManagerEmailChecked(String managerID) {
			String sql = "update manager set managerEmailChecked = true where managerID = ?";

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				conn = DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, managerID);			
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

}
