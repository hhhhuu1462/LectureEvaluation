<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ page import="notice.*"%>
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
		String managerID = null;
		if (session.getAttribute("managerID") != null) {
			managerID = (String) session.getAttribute("managerID");
		}
		if (managerID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 하세요!')");
			script.println("location.href='managerLogin.jsp'");
			script.println("</script>");
		} 
		int noticeID = 0;
		if(request.getParameter("noticeID") != null) {
			noticeID = Integer.parseInt(request.getParameter("noticeID"));
		}
		if(noticeID==0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='noticeBoard.jsp'");
			script.println("</script>");
		}
		Post post = new PostDAO().getNotice(noticeID);
		if(!managerID.equals(post.getManagerID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이 글에 대한 권한이 없습니다')");
			script.println("location.href='noticeBoard.jsp'");
			script.println("</script>");
		} else {
			if (request.getParameter("noticeTitle") == null || request.getParameter("noticeContent") == null
						|| request.getParameter("noticeTitle").equals("") || request.getParameter("noticeContent").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PostDAO postDAO = new PostDAO();
	
				int result = postDAO.update(noticeID, request.getParameter("noticeTitle"), request.getParameter("noticeContent"));
	
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'noticeBoard.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>