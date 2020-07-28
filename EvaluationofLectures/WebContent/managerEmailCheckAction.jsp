<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="manager.*"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("utf-8");

	String code = null;
	if (request.getParameter("code") != null) {
		code = (String) request.getParameter("code");
	}
	ManagerDAO managerDAO = new ManagerDAO();
	String managerID = null;
	if (session.getAttribute("managerID") != null) {
		managerID = (String) session.getAttribute("managerID");
	}
	if (managerID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요');");
		script.println("location.href='managerLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	String managerEmail = managerDAO.getManagerEmail(managerID);
	boolean isRight = (new SHA256().getSHA256(managerEmail).equals(code)) ? true : false;
	if(isRight == true) {
		managerDAO.setManagerEmailChecked(managerID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('인증에 성공했습니다.');");
		script.println("location.href='main.jsp'");
		script.println("</script>");
		script.close();
		return;
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 코드입니다.');");
		script.println("location.href='main.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>