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
			EvaluationDAO evaluationDAO = new EvaluationDAO();	
			int result = evaluationDAO.delete(evaluationID);	
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>