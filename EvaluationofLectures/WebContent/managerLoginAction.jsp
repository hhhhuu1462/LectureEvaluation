<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="manager.*"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("utf-8");
	String managerID = null;
	String managerPassword = null;
	
	if (request.getParameter("managerID") != null) {
		managerID = (String) request.getParameter("managerID");
	}
	if (request.getParameter("managerPassword") != null) {
		managerPassword = (String) request.getParameter("managerPassword");
	}
	
	if (managerID == null || managerPassword == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력사항을 다시 한 번 확인해 주세요');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	ManagerDAO managerDAO = new ManagerDAO();
	int result = managerDAO.login(managerID, managerPassword);

	if (result == 1) {
		session.setAttribute("managerID", managerID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
		script.close();
		return;
	} else if (result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else if (result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>