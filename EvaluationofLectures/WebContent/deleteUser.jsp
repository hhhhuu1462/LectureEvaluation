<%@page import="user.UserDAO"%>
<%@page import="report.ReportDAO"%>
<%@page import="likey.LikeyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ page import="evaluation.*"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
		if (request.getParameter("userID") != null) {
			userID = (String) request.getParameter("userID");
		}
		
		EvaluationDAO evaluationDAO = new EvaluationDAO();
		LikeyDAO likeyDAO = new LikeyDAO();
		ReportDAO reportDAO = new ReportDAO();
		UserDAO userDAO = new UserDAO();
		
		int result_evaluation = evaluationDAO.delete_user(userID);
		int result_likey = likeyDAO.delete_user(userID);
		int result_report = reportDAO.delete_user(userID);
		int result_user = userDAO.delete_user(userID);
		if (result_evaluation == -1 && result_likey == -1 && result_report == -1 && result_user == -1 ) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원정보 삭제에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원정보가 삭제되었습니다.')");
			script.println("location.href = 'memberManagement.jsp'");
			script.println("</script>");
		}
		
	%>
</body>
</html>