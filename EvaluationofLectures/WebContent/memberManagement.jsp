<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="report.ReportDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="notice.PostDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.*"%>
<%@page import="manager.*"%>
<%@page import="evaluation.*"%>
<%@page import="likey.*"%>
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
					<li><a href="noticeBoard.jsp" style="font-weight: bold;">공지사항</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" style="font-weight: bold;">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="./logoutAction.jsp">로그아웃</a></li>
							<li><a href="./modifyingInformation.jsp">정보수정</a></li>							
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table  class="table table-bordered" style="text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color:#eeeeee; text-align:center;">회원 수</th>
						<th style="background-color:#eeeeee; text-align:center;">총 게시글 수</th>
						<th style="background-color:#eeeeee; text-align:center;">총 공지사항 수</th>
					</tr>
				</thead>
				<tbody>
					<%
						UserDAO userDAO = new UserDAO();	
						EvaluationDAO evaluationDAO = new EvaluationDAO();
						PostDAO postDAO = new PostDAO();
					%>
					<tr>
						<td><%= userDAO.count() %> </td>
						<td><%= evaluationDAO.count() %> </td>
						<td><%= postDAO.count() %> </td>
					</tr>
				</tbody>
			</table>
			<div style="padding:10px"></div>
			<table  class="table table-bordered" style="text-align:center; layout:fixed; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color:#eeeeee; text-align:center;"><i>No.</i></th>
						<th style="background-color:#eeeeee; text-align:center;">회원명</th>
						<th style="background-color:#eeeeee; text-align:center;">회원ID</th>						
						<th style="background-color:#eeeeee; text-align:center;">게시글 수</th>
						<th style="background-color:#eeeeee; text-align:center;">좋아요 개수</th>
						<th style="background-color:#eeeeee; text-align:center;">신고</th>
						<th style="background-color:#eeeeee; text-align:center;">가입요청</th>
						<th style="background-color:#eeeeee; text-align:center;">SMS</th>
						<th style="background-color:#eeeeee; text-align:center;">정보</th>
					</tr>
				</thead>
				<tbody>
					<%						
						userDAO.setNotice();
						ArrayList<UserDTO> list = userDAO.getList();
						ReportDAO reportDAO = new ReportDAO();
						for(int i=0; i<list.size(); i++) {
					%>
					<tr>
						<td><%= list.get(i).getUserNo() %></td>
						<td><%= list.get(i).getUserName() %></td>
						<td><%= list.get(i).getUserId() %></td>
						<td><%= evaluationDAO.count_index(list.get(i).getUserId()) %></td>
						<td><%= evaluationDAO.sum_likeCount(list.get(i).getUserId()) %></td>
						<td><%= userDAO.sum_reportCount(list.get(i).getUserId())%>건</td>
						<td>
							<%
								if(userDAO.getUserEmailChecked(list.get(i).getUserId()) == false) {
							%>
									<input type="button" value="요청" onclick="location.href='emailCheckAction.jsp?userID=<%=list.get(i).getUserId()%>'">
							<%
								} else {
							%>
									승인완료
							<%
								}
							%>
						</td>
						<td><input type="button"  value="SMS" onclick="location.href='sms.jsp?phoneNumber=<%=list.get(i).getPhoneNumber() %>'"  ></td>
						<td><input type="button" value="삭제" onclick="location.href='deleteUser.jsp?userID=<%=list.get(i).getUserId()%>'"></td>
					</tr>
					<%
						}
					%>						
				</tbody>
			</table>				
		</div>		
	</div>	
	<%@ include file="footer.jsp"%>
	<script src="js/bootstrap.js"></script>
	<script src="js/jquery-3.5.1.min.js"></script>
</body>
</html>
