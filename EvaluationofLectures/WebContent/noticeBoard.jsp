<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notice.*"%>
<%@ page import="user.*"%>
<%@ page import="manager.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
	a, a:hover {
	color : #000000;
	text-decoration:  : none;
	}
</style>
</head>
<body>
	<%
		String userID = null;
		String managerID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(session.getAttribute("managerID") != null) {
			managerID = (String) session.getAttribute("managerID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		int noticeID = 0;
		if(request.getParameter("noticeID") != null) {
			noticeID = Integer.parseInt(request.getParameter("noticeID"));
		}
		Post post = new PostDAO().getNotice(noticeID);
		
		if (userID == null && managerID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.');");
			script.println("location.href = 'managerLogin.jsp'");
			script.println("</script>");
			script.close();
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
					<li ><a href="main.jsp" style="font-weight: bold;">메인</a></li>
					<li ><a href="index.jsp" style="font-weight: bold;">게시판</a></li>
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
			<div style="padding:10px"></div>
			<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color:#eeeeee; text-align:center;">번호</th>
						<th style="background-color:#eeeeee; text-align:center;">제목</th>
						<th style="background-color:#eeeeee; text-align:center;">작성자</th>
						<th style="background-color:#eeeeee; text-align:center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						PostDAO postDAO = new PostDAO();
						postDAO.setNotice();
						ArrayList<Post> list = postDAO.getList(pageNumber);
						for(int i=0; i<list.size(); i++) {
					%>
					<tr>
						<td><%= list.get(i).getNoticeID() %></td>
						<td><a href="view.jsp?noticeID=<%= list.get(i).getNoticeID() %>"><%= list.get(i).getNoticeTitle() %></a></td>
						<td><%= list.get(i).getManagerID() %></td>
						<td><%= list.get(i).getNoticeDate().substring(0, 11) + list.get(i).getNoticeDate().substring(11, 13) + "시" + list.get(i).getNoticeDate().substring(14, 16) + "분" %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<nav>
				<ul class="pager ">
			<%
				if(pageNumber != 1) {
			%>				
					<li><a style="background-color:AliceBlue" href="noticeBoard.jsp?pageNumber=<%=pageNumber - 1 %>">← Previous</a></li>
			<%		
				}
				if(postDAO.nextPage(pageNumber + 1)) {
			%>
					<li><a style="background-color:AliceBlue" href="noticeBoard.jsp?pageNumber=<%=pageNumber + 1 %>">Next →</a></li>
			<%
		     	 }
				
				if(session.getAttribute("managerID") != null) {
			%>
					<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>				
			<%
				}
			%>
				</ul>
			</nav>	
		</div>
	</div>
	<%@ include file="footer.jsp"%>				
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>