<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@page import="manager.*"%>
<!DOCTYPE html>
<html>
<head>
<title>강의평가 웹 사이트</title>
<!-- 부트스트랩 css추가 -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/bootstrap-theme.css">
<link rel="stylesheet" href="css/bootstrap-theme.min.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/footer.css">

<!-- 제이쿼리 자바스크립트 추가 -->
<script src="js/jquery.min.js"></script>
<!-- popper 자바스크립트 추가 -->
<script src="/js/popper.js"></script>
<!-- 부트스트랩 자바스크립트 추가 -->
<script src="js/bootstrap.min.js"></script>
<script src="js/npmjs"></script>
<script src="js/bootstrap.js"></script>
<script src="js/jquery-3.5.1.min.js"></script>
</head>
<body>			
	<%
		// 로그인이 되어있다면 session 값 가져오기
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}		
		String managerID = null;
		if (session.getAttribute("managerID") != null) {
			managerID = (String) session.getAttribute("managerID");
		}	
	%>
	<div class="jumbotron text-center mb-0">
		<h1>EZEN ACADEMY</h1>
		<p id="top">학생들을 위한 강의 평가 웹 사이트</p>
	</div>
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
					%>
							<li><a href="./memberManagement.jsp" style="font-weight: bold;">회원관리</a></li>
					<%
						}
					%>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="noticeBoard.jsp" style="font-weight: bold;">공지사항</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" style="font-weight: bold;">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
						<%
							if (userID == null && managerID == null) { 
						%>
							<li><a href="./userLogin.jsp">학생로그인</a></li>
							<li><a href="managerLogin.jsp">관리자로그인</a></li>
							<li class="divider"></li>
							<li><a href="./userRegister.jsp">회원가입</a></li>
							<li><a href="./managerRegister.jsp">관리자 등록</a></li>
						<% } %>
						<%
							if (userID != null) { 
						%>
								<li><a href="./logoutAction.jsp">로그아웃</a></li>
								<li><a href="./modifyingInformation.jsp">정보수정</a></li>
						<%
								} else if (managerID != null) { 
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
	<div class="p-3 mb-2 container">
		<div class="jumbotron">
			<h1>웹 사이트 소개</h1>
			<p>이 사이트는 본 학원에서 수강을 계획하고 있는 학생들을 위한 강의평가 게시판입니다.
			<p>
				<a class="btn btn-primary btn-pull" href="#" role="button">강의 안내</a>
		</div>
		<div class="row">
			<div>
				<h2>JAVA</h2>
				<p></p>
				<img src="image/java.png"  style="width:230px; height:100px; float:left;" class="img-fluid" >
			
			</div>
		</div>
		<div class="row">
			<div>
				<h2>JSP</h2>
				<p></p>
				<img src="image/jsp.png"  style="width:150px; height:100px; float:right;" class="img-fluid">
				
			</div>
		</div>
		<div class="row">
			<div>
				<h2>SPRING</h2>
				<p></p>
				<img src="image/spring.png"  style="width:150px; height:100px; float:left;" class="img-fluid">
			</div>
		</div>
		<div style="cursor:pointer;" onclick="window.scrollTo(0,0);">
			<input type="submit" value="TOP" style="float:right;">
		</div>
	</div>	
	<%@ include file="footer.jsp"%>
	<script src="js/bootstrap.js"></script>
	<script src="js/jquery-3.5.1.min.js"></script>
</body>
</html>
