<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ page import="evaluation.*"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<jsp:useBean id="evaluation" class="evaluation.EvaluationDTO" scope="page"></jsp:useBean>
<jsp:setProperty name="evaluation" property="evaluationTitle" />
<jsp:setProperty name="evaluation" property="evaluationContent" />
<jsp:setProperty name="evaluation" property="lectureName" />
<jsp:setProperty name="evaluation" property="professorName" />
<jsp:setProperty name="evaluation" property="lectureYear" />
<jsp:setProperty name="evaluation" property="semesterDivide" />
<jsp:setProperty name="evaluation" property="lectureDivide" />
<jsp:setProperty name="evaluation" property="totalScore" />
<jsp:setProperty name="evaluation" property="creditScore" />
<jsp:setProperty name="evaluation" property="comfortableScore" />
<jsp:setProperty name="evaluation" property="lectureScore" />
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
		} else {
			if (evaluation.getEvaluationTitle() == null || evaluation.getEvaluationContent() == null) {
				if(request.getParameter("cancle") != null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("index.jsp");
					script.println("</script>");
				} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
				}
			} else {
				EvaluationDAO evaluationDAO = new EvaluationDAO();
				
				String cancle = (String) request.getParameter("cancle");
				
				int result = evaluationDAO.write(userID, evaluation.getLectureName(), evaluation.getProfessorName(), evaluation.getLectureYear(), evaluation.getSemesterDivide(), evaluation.getLectureDivide(),
														evaluation.getEvaluationTitle(), evaluation.getEvaluationContent(), evaluation.getTotalScore(), evaluation.getCreditScore(), evaluation.getComfortableScore(), evaluation.getLectureScore());
	
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
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