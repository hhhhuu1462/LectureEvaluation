<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("utf-8");
	String userID = null;
	String userPassword = null;
	String userEmail = null;
	String userName = null;
	String userGender = null;
	String phoneNumber = null;

	if (request.getParameter("userID") != null) {
		userID = (String) request.getParameter("userID");
	}
	if (request.getParameter("userPassword") != null) {
		userPassword = (String) request.getParameter("userPassword");
	}
	if (request.getParameter("userName") != null) {
		userName = (String) request.getParameter("userName");
	}
	if (request.getParameter("userEmail") != null) {
		userEmail = (String) request.getParameter("userEmail");
	}
	if (request.getParameter("phoneNumber") != null) {
		phoneNumber = (String) request.getParameter("phoneNumber");
	}
	userGender = (String) request.getParameter("userGender");

	if (userID == null || userPassword == null || userEmail == null || userName == null || phoneNumber == null
			|| userID.equals("") || userPassword.equals("") || userEmail.equals("") || userName.equals("") || phoneNumber.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력사항을 다시 한 번 확인해 주세요');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	} else {
		UserDAO userDAO = new UserDAO();
		int result = userDAO.modifyData(userID, userPassword, userName, userGender, userEmail, phoneNumber);

		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디 입니다');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		} else {
			session.setAttribute("userID", userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원정보 수정이 완료되었습니다.');");
			script.println("location.href='main.jsp'");
			script.println("</script>");
			script.close();
		}
	}
%>