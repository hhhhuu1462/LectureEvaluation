<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="util.Gmail" %>
<%@ page import="java.util.Properties" %>
<%@ page import="manager.*"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	ManagerDAO managerDAO = new ManagerDAO();
	String managerID = null;
	if(session.getAttribute("managerID") != null) {
		managerID = (String) session.getAttribute("managerID");
	}
	if(managerID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해 주세요');");
		script.println("location.href='managerLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}	
	boolean emailChecked = managerDAO.getManagerEmailChecked(managerID);
%>
<!doctype html>
<html>
  <head>
    <title>강의평가 웹 사이트</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- 부트스트랩 CSS 추가하기 -->
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <!-- 커스텀 CSS 추가하기 -->
    <link rel="stylesheet" href="./css/custom.css">
  </head>
  <body>
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
					<li class="active"><a href="main.jsp" style="font-weight: bold;">메인</a></li>
					<li><a href="index.jsp" style="font-weight: bold;">게시판</a></li>
					<%
						if(managerID != null) {
							emailChecked = new ManagerDAO().getManagerEmailChecked(managerID);
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
				<form class="navbar-form navbar-left" role="search">
					<div class="form-group">
						<input type="text" name="search" class="form-control mr-sm-2" placeholder="내용을 입력하세요." aria-label="Search" style="width: 250px;">
					</div>
					<button type="submit" class="btn btn-default" style="font-weight: bold;">검색</button>
				</form>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="noticeBoard.jsp" style="font-weight: bold;">공지사항</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" style="font-weight: bold;">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="./userLogin.jsp">학생로그인</a></li>
							<li><a href="managerLogin.jsp">관리자로그인</a></li>
							<li><a href="./logoutAction.jsp">로그아웃</a></li>
							<li><a href="modifyingInformation.jsp">정보수정</a></li>
							<li class="divider"></li>
							<li><a href="./userRegister.jsp">회원가입</a></li>
							<li><a href="./managerRegister.jsp">관리자 등록</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
	    <div class="alert alert-success mt-4" role="alert">
		  	회원정보 수정이 완료되었습니다.
		</div>
		<input type="button" value="확인" onclick="location.href='main.jsp'"> 
    </div>
	<%@ include file="footer.jsp"%>

	<script src="js/bootstrap.js"></script>
	<script src="js/jquery-3.5.1.min.js"></script>
  </body>
</html>