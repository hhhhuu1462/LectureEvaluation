<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ page import="evaluation.*"%>
<%@ page import="user.*"%>
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
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 하세요!')");
			script.println("location.href='userLogin.jsp'");
			script.println("</script>");
		} 
		int evaluationID = 0;
		if(request.getParameter("evaluationID") != null) {
			evaluationID = Integer.parseInt(request.getParameter("evaluationID"));
		}
		if(evaluationID==0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		}
		EvaluationDTO evaluationDTO = new EvaluationDAO().getindex(evaluationID);
		if(!userID.equals(evaluationDTO.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이 글에 대한 권한이 없습니다')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		} else {
			if (request.getParameter("lectureName").equals("") || request.getParameter("professorName").equals("")
						|| request.getParameter("lectureYear").equals("") || request.getParameter("semesterDivide").equals("")
						|| request.getParameter("lectureDivide").equals("") || request.getParameter("evaluationTitle").equals("")
						|| request.getParameter("evaluationContent").equals("") || request.getParameter("totalScore").equals("")
						|| request.getParameter("creditScore").equals("") || request.getParameter("comfortableScore").equals("")
						|| request.getParameter("lectureScore").equals("")
						|| request.getParameter("lectureName") == null || request.getParameter("professorName") == null
						|| request.getParameter("lectureYear") == null || request.getParameter("semesterDivide") == null
						|| request.getParameter("lectureDivide") == null || request.getParameter("evaluationTitle") == null
						|| request.getParameter("evaluationContent") == null || request.getParameter("totalScore") == null
						|| request.getParameter("creditScore") == null || request.getParameter("comfortableScore") == null
						|| request.getParameter("lectureScore") == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				EvaluationDAO evaluationDAO = new EvaluationDAO();
	
				int result = evaluationDAO.update(evaluationID, request.getParameter("lectureName"), request.getParameter("professorName")
															, request.getParameter("lectureYear"), request.getParameter("semesterDivide"), request.getParameter("lectureDivide")
															, request.getParameter("evaluationTitle"), request.getParameter("evaluationContent"), request.getParameter("totalScore")
															, request.getParameter("creditScore"), request.getParameter("comfortableScore"), request.getParameter("lectureScore")
															);
	
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'index.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>