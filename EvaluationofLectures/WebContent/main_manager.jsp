<%@page import="java.io.PrintWriter"%>
<%@page import="manager.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>강의평가 웹 사이트</title>
<meta http-equiv="Content-Type" content="text/html; charset= UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1">
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
	request.setCharacterEncoding("UTF-8");
	String lectureDivide = "전체";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	if (request.getParameter("lectureDivide") != null) {
		lectureDivide = request.getParameter("lectureDivide");
	}
	if (request.getParameter("searchType") != null) {
		searchType = request.getParameter("searchType");
	}
	if (request.getParameter("search") != null) {
		search = request.getParameter("search");
	}
	if (request.getParameter("pageNumber") != null) {
		try {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} catch (Exception e) {
			System.out.println("검색 페이지 번호 오류");
		}
	}
	String managerID = null;
	if (session.getAttribute("managerID") != null) {
		managerID = (String) session.getAttribute("managerID");
	}	
	%>
	<div class="jumbotron text-center mb-0">
		<h1>EZEN ACADEMY</h1>
		<p>학생들을 위한 강의 평가 웹 사이트</p>
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
					<li><a href="noticeBoard.jsp" style="font-weight: bold;">게시판</a></li>
				</ul>
				<form class="navbar-form navbar-left" role="search">
					<div class="form-group">
						<input type="text" name="search" class="form-control mr-sm-2" placeholder="내용을 입력하세요." aria-label="Search" style="width: 250px;">
					</div>
					<button type="submit" class="btn btn-default" style="font-weight: bold;">검색</button>
				</form>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#" style="font-weight: bold;">공지사항</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" style="font-weight: bold;">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
						<% if(managerID == null) { %>
						 		<li><a href="./userLogin.jsp">학생로그인</a></li>
								<li><a href="managerLogin.jsp">관리자로그인</a></li>
								<li class="divider"></li>
								<li><a href="./userRegister.jsp">회원가입</a></li>
								<li><a href="./managerRegister.jsp">관리자 등록</a></li>
						<% } else if (managerID != null) { 
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
	<div class="p-3 mb-2 container">
		<div class="jumbotron">
			<h1>웹 사이트 소개</h1>
			<p>이 사이트는 본 학원에서 수강을 계획하고 있는 학생들을 위한 강의평가 게시판입니다.
			<p>
				<a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a>
		</div>
		<div class="row">
			<div class="col-sm-4">
				<h2>JAVA</h2>
				<p>SM엔터테인먼트 소속의 5인조 걸그룹!</p>
				<img src="image/java.png"  style="max-width: 100%; height: auto;" class="img-fluid">
				<p>아이린, 슬기, 웬디, 조이로 구성된 4인조로 데뷔했고, 사흘 후인 2014년 8월 4일 데뷔곡인 디지털 싱글 행복이 발매</p>
			</div>
			<!-- right content -->
			<div class="col-sm-4">
				<h2>JSP</h2>
				<p>2018년 8월 6일, 여름 미니 2집 Summer Magic</p>
				<img src="image/jsp.png"  style="max-width: 100%; height: auto;" class="img-fluid">
			</div>
			<div class="col-sm-4">
				<h2>SPRING</h2>
				<p>2018년 8월 6일, 여름 미니 2집 Summer Magic</p>
				<img src="image/spring.png"  style="max-width: 100%; height: auto;" class="img-fluid">
			</div>
		</div>
	</div>

	<%@ include file="footer.jsp"%>

	<script src="js/bootstrap.js"></script>
	<script src="js/jquery-3.5.1.min.js"></script>
</body>
</html>
