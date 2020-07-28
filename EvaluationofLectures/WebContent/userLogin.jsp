<%@page import="manager.ManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset= UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>강의평가 웹 사이트</title>
	<!-- 부트스트랩 css추가 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 css추가 -->
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 된 상태입니다');");
			script.println("location.href='main.jsp';");
			script.println("</script>");
			script.close();
			return;
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
					<li class="active"><a href="main.jsp" style="font-weight: bold;">메인</a></li>
					<li><a href="index.jsp" style="font-weight: bold;">게시판</a></li>					
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
		<div class="col-lg-4"></div>			
		<div class="col-lg-4">	
			<div style="padding-top:20px">
			<img src="image/ezen.png" class="img-fluid">
			</div>		
			<div class="jumbotron" style="padding-top:20px">
				<form method="post" action="./userLoginAction.jsp">
					<h3 style ="text-align:center;">로그인 화면</h3>
					   	<section id="regist">
							<div class="form-group">
								<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
							</div>
							<div class="form-group">
								<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
							</div>
							<input type="submit" class="btn btn-primary form-control" value="로그인">
						</section>	
				</form>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>	
	<!-- 제이쿼리 자바스크립트 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- popper 자바스크립트 추가 -->
	<script src="./js/popper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>
		