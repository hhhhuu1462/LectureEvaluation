package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import user.UserDTO;
import util.DatabaseUtil;

public class EvaluationDAO {
	// 강의평가와 관련된 db
	
	// 현재 날짜
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
	
	// 게시판 등록 번호
	public int getNext() {
		String SQL = "select evaluationID from evaluation order by evaluationID desc";

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
	
	// 번호 자동 정렬
	public int setNotice() {
		String SQL = "set @cnt = 0; update evaluation set evaluationID=@cnt:=@cnt+1;";
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

	// 글 쓰기
	public int write(String userID, String lectureName, String professorName, String lectureYear, String semesterDivide, String lectureDivide,
							String evaluationTitle, String evaluationContent, String totalScore, String creditScore, String comfortableScore, String lectureScore) {
		String sql = "insert into evaluation values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,  getNext());
			pstmt.setString(2, userID.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3, lectureName.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(4, professorName.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(5, lectureYear.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(6, semesterDivide.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(7, lectureDivide.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(8, evaluationTitle.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(9, getDate());
			pstmt.setString(10, evaluationContent.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(11, totalScore.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(12, creditScore.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(13, comfortableScore.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(14, lectureScore.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setInt(15, 0);
			pstmt.setInt(16, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) { e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) { e.printStackTrace(); }
		}
		return -1; //db 오류
	}		
	
	
	
	public int update(int evaluationID, String lectureName, String professorName, String lectureYear, String semesterDivide, String lectureDivide, 
			String evaluationTitle, String evaluationContent	, String totalScore, String creditScore, String comfortableScore, String lectureScore) {
		String SQL = "update evaluation set lectureName=?, professorName=?, lectureYear=?, semesterDivide=?, lectureDivide=?, evaluationTitle=?"
				+ "			, evaluationContent=?, totalScore=?, creditScore=?, comfortableScore=?, lectureScore=? where evaluationID=?";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  lectureName.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(2,  professorName.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3,  lectureYear.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(4,  semesterDivide.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(5,  lectureDivide.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(6,  evaluationTitle.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(7,  evaluationContent.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(8,  totalScore.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(9,  creditScore.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(10,  comfortableScore.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(11,  lectureScore.replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
			pstmt.setInt(12,  evaluationID);		
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 검색함수
	public ArrayList<EvaluationDTO> getSort(String lectureDivide, String searchType, String search, int pageNumber) {
		if(lectureDivide.equals("전체")) {
			lectureDivide = "";
		}
		ArrayList<EvaluationDTO> evaluationList = null;
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		String sql = "";
		try {
			if(searchType.equals("최신순")) {
				sql = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " +5;
			} else if(searchType.equals("추천순")) {
				sql = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + 5;
			}
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + lectureDivide + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			evaluationList = new ArrayList<EvaluationDTO>();
			while(rs.next()) {
				EvaluationDTO evaluation = new EvaluationDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11),
						rs.getString(12),
						rs.getString(13),
						rs.getString(14),
						rs.getInt(15),
						rs.getInt(16)
						);
				evaluationList.add(evaluation);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return evaluationList;
	}

	// 좋아요
	public int like(String evaluationID) {
		String sql = "update evaluation set likeCount = likeCount + 1 where evaluationID = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(evaluationID));				
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

	// 게시글 삭제
	public int delete(int evaluationID) {
		String sql = "delete from evaluation where evaluationID = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, evaluationID);			
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
	
	public int delete_user(String userID) {
		String sql = "delete from evaluation where userID = ?";

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
	
	public EvaluationDTO getindex(int evaluationID) {
		String SQL = "select * from evaluation where evaluationID = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  evaluationID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				EvaluationDTO evaluationDTO = new EvaluationDTO();
				evaluationDTO.setEvaluationID(rs.getInt(1));
				evaluationDTO.setUserID(rs.getString(2));
				evaluationDTO.setLectureName(rs.getString(3));
				evaluationDTO.setProfessorName(rs.getString(4));
				evaluationDTO.setLectureYear(rs.getString(5));
				evaluationDTO.setSemesterDivide(rs.getString(6));
				evaluationDTO.setLectureDivide(rs.getString(7));
				evaluationDTO.setEvaluationTitle(rs.getString(8));
				evaluationDTO.setEvaluationDate(rs.getString(9));
				evaluationDTO.setEvaluationContent(rs.getString(10));
				evaluationDTO.setTotalScore(rs.getString(11));
				evaluationDTO.setCreditScore(rs.getString(12));
				evaluationDTO.setComfortableScore(rs.getString(13));
				evaluationDTO.setLectureScore(rs.getString(14));
				evaluationDTO.setLikeCount(rs.getInt(15));
				evaluationDTO.setEvaluationAvailable(rs.getInt(16));
				return evaluationDTO;
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 강의평 작성자 ID 가져오기
	public String getUserID(String evaluationID) {
		String sql = "select userID from evaluation where evaluationID = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(evaluationID));			
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
		return null; // 존재하지 않는 ID
	}
	
	public int count() {
		int total = 0;
		
		String sql = "select count(*) from evaluation";
	
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
	
	public int count_index(String userID) {
		int total = 0;
		
		String sql = "select count(userID) from evaluation where userID=?";
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);			
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
	
	public int sum_likeCount(String userID) {
		int total = 0;
		
		String sql = "select sum(likeCount) from evaluation where userID=?";
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);			
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
