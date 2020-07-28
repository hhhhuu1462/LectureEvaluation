package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {

	public static Connection getConnection() {
		try {
			// characterEncoding=UTF_8로 설정
			String dbURL = "jdbc:mysql://localhost:3306/LectureEvaluation?characterEncoding=UTF-8";
			
			String dbID = "root";
			String dbPassword = "1234";

			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
