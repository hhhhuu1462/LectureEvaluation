<%@page import="manager.ManagerDAO"%>
<%@page import="notice.PostDAO"%>
<%@page import="notice.Post"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String managerID = null;
		if(session.getAttribute("managerID") != null) {
			managerID = (String) session.getAttribute("managerID");
		}
		if(managerID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
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
		}
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
					<li class="active"><a href="noticeBoard.jsp" style="font-weight: bold;">공지사항</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" style="font-weight: bold;">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="./logoutAction.jsp">로그아웃</a></li>
							<li><a href="./managerModifyingInformation.jsp">정보수정</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?noticeID=<%=noticeID%>">
				<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글 수정 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="noticeTitle" maxlength="50" value="<%= post.getNoticeTitle() %>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="noticeContent" maxlength="2048" style="height : 350px;"><%= post.getNoticeContent() %></textarea></td>			
						</tr>
					</tbody>					
				</table>
				<label style="float:right">
					<input type="submit" class="btn btn-primary " value="글 수정" >
					<input onclick="location='noticeBoard.jsp'" type="submit" class="btn btn-danger "  value="수정취소" >
				</label>
			</form>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>