<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ page import="notice.*"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<jsp:useBean id="notice" class="notice.Post" scope="page"></jsp:useBean>
<jsp:setProperty name="notice" property="noticeTitle" />
<jsp:setProperty name="notice" property="noticeContent" />
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
		} else {
			if (notice.getNoticeTitle() == null || notice.getNoticeContent() == null) {
				if(request.getParameter("cancle") != null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("noticeBoard.jsp");
					script.println("</script>");
				} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
				}
			} else {
				PostDAO postDAO = new PostDAO();
				
				String cancle = (String) request.getParameter("cancle");
				
				int result = postDAO.write(notice.getNoticeTitle(), managerID, notice.getNoticeContent());
	
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
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