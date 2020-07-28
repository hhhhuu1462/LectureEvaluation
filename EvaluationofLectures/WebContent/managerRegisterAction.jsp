<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="manager.*"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("utf-8");
	String managerID = null;
	String managerPassword = null;
	String managerEmail = null;
	String managerName = null;
	String managerGender = null;
	String phoneNumber = null;

	if (request.getParameter("managerID") != null) {
		managerID = (String) request.getParameter("managerID");
	}
	if (request.getParameter("managerPassword") != null) {
		managerPassword = (String) request.getParameter("managerPassword");
	}
	if (request.getParameter("managerName") != null) {
		managerName = (String) request.getParameter("managerName");
	}
	if (request.getParameter("managerEmail") != null) {
		managerEmail = (String) request.getParameter("managerEmail");
	}
	if (request.getParameter("phoneNumber") != null) {
		phoneNumber = (String) request.getParameter("phoneNumber");
	}
	managerGender = (String) request.getParameter("managerGender");
	
	if (managerID == null || managerPassword == null || managerEmail == null || managerName == null || phoneNumber == null || managerID.equals("") || managerPassword.equals("")
					|| managerEmail.equals("") || managerName.equals("") || phoneNumber.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력사항을 다시 한 번 확인해 주세요');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	} else {
		ManagerDAO managerDAO = new ManagerDAO();
		int result = managerDAO.join(new ManagerDTO(managerID, managerPassword, managerName, managerGender, managerEmail, phoneNumber, SHA256.getSHA256(managerEmail), false));
	
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자 계정은 하나 이상 만들 수 없습니다');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		} else {
			session.setAttribute("managerID", managerID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='managerEmailSendAction.jsp'");
			script.println("</script>");
			script.close();
		}
	}
%>