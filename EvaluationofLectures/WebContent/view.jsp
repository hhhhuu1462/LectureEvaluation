<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@page import="notice.*"%>
<%@page import="user.*"%>
<%@page import="manager.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		String managerID = null;
		if(session.getAttribute("managerID") != null) {
			managerID = (String) session.getAttribute("managerID");
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
	%>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="main.jsp">강의 평가 웹 사이트</a>
			</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="main.jsp" style="font-weight: bold;">메인</a></li>
					<li><a href="index.jsp" style="font-weight: bold;">게시판</a></li>
					<%
						if(managerID != null) {
							boolean emailChecked = new ManagerDAO().getManagerEmailChecked(managerID);
							if (emailChecked == false) {
								PrintWriter script = response.getWriter();
								script.println("<script>");
								script.println("location.href = 'managerEmailSendConfirm.jsp'");
								script.println("</script>");
								script.close();
								return;
							}
					%>
							<li><a href="./memberManagement.jsp" style="font-weight: bold;">회원관리</a></li>
					<%
						}
					%>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li  class="active"><a href="noticeBoard.jsp" style="font-weight: bold;">공지사항</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" style="font-weight: bold;">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
						<% if(userID == null && managerID == null) { %>
						 		<li><a href="./userLogin.jsp">학생로그인</a></li>
								<li><a href="managerLogin.jsp">관리자로그인</a></li>
								<li class="divider"></li>
								<li><a href="./userRegister.jsp">회원가입</a></li>
								<li><a href="./managerRegister.jsp">관리자 등록</a></li>
						<% } else if (userID != null) { 
								boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
								if (emailChecked == false) {
									PrintWriter script = response.getWriter();
									script.println("<script>");
									script.println("location.href = 'emailSendConfirm.jsp'");
									script.println("</script>");
									script.close();
									return;
								}
						%>
								<li><a href="./logoutAction.jsp">로그아웃</a></li>
								<li><a href="./modifyingInformation.jsp">정보수정</a></li>
						<%
								} else if (managerID != null) { 
									boolean emailChecked = new ManagerDAO().getManagerEmailChecked(managerID);
									if (emailChecked == false) {
										PrintWriter script = response.getWriter();
										script.println("<script>");
										script.println("location.href = 'managerEmailSendConfirm.jsp'");
										script.println("</script>");
										script.close();
										return;
									}
						%>
								<li><a href="./logoutAction.jsp">로그아웃</a></li>
								<li><a href="./managerModifyingInformation.jsp">정보수정</a></li>
						<%
								}
						%>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="row">			
			<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color:#eeeeee; text-align:center;">공지사항</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:20%;">글 제목</td>
						<td colspan="2"><%=post.getNoticeTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %> </td>
					</tr>		
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=post.getManagerID() %> </td>
					</tr>					
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%=post.getNoticeDate().substring(0, 11) + post.getNoticeDate().substring(11, 13) + "시" + post.getNoticeDate().substring(14, 16) + "분" %></td>
					</tr>		
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%=post.getNoticeContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %> </td>
					</tr>		
				</tbody>					
			</table>
			<a href="noticeBoard.jsp" class="btn btn-primary">목록</a>
			<%
				if(managerID != null && managerID.equals(post.getManagerID())) {
			%>
					<a href="update.jsp?noticeID=<%= noticeID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?noticeID=<%=noticeID %>" class="btn btn-danger">삭제</a>
			<%
				}
			%>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>