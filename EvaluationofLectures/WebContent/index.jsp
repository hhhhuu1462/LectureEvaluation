<%@page import="evaluation.EvaluationDTO"%>
<%@page import="evaluation.EvaluationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notice.*"%>
<%@ page import="user.*"%>
<%@ page import="manager.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<head>
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
		request.setCharacterEncoding("UTF-8");
		String lectureDivide = "전체";
		String searchType = "최신순";
		String search = "";
		
		if (request.getParameter("lectureDivide") != null) {
			lectureDivide = request.getParameter("lectureDivide");
		}
		if (request.getParameter("searchType") != null) {
			searchType = request.getParameter("searchType");
		}
		if (request.getParameter("search") != null) {
			search = request.getParameter("search");
		}
		int pageNumber = 0;
		if (request.getParameter("pageNumber") != null) {
			try {
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			} catch (Exception e) {
				System.out.println("검색 페이지 번호 오류");
			}
		}
		String userID = null;
		String managerID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (session.getAttribute("managerID") != null) {
			managerID = (String) session.getAttribute("managerID");
		}
		if (userID == null && managerID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.');");
			script.println("location.href = 'userLogin.jsp'");
			script.println("</script>");
			script.close();
		}
		boolean userEmailChecked = new UserDAO().getUserEmailChecked(userID);
		boolean managerEmailChecked = new ManagerDAO().getManagerEmailChecked(managerID);
		if (userEmailChecked == false && managerEmailChecked == false) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'emailSendConfirm.jsp'");
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
					<li ><a href="main.jsp" style="font-weight: bold;">메인</a></li>
					<li class="active"><a href="index.jsp" style="font-weight: bold;">게시판</a></li>
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
			<form method="get" action="./index.jsp" class="form-inline mt-3">
				<select name="lectureDivide" class="form-control mx-1 mt-2">
					<option value="전체">전체</option>
					<option value="전공" <%if (lectureDivide.equals("전공")) out.println("selected");%>>전공</option>
					<option value="교양" <%if (lectureDivide.equals("교양")) out.println("selected");%>>교양</option>
					<option value="기타" <%if (lectureDivide.equals("기타")) out.println("selected");%>>기타</option>
				</select>
				<select name="searchType" class="form-control mx-1 mt-2">
					<option value="최신순">최신순</option>
					<option value="추천순" <%if (lectureDivide.equals("추천순")) out.println("selected");%>>추천순</option>
				</select> 			
				<div class="form-group">
					<input type="text" name="search" class="form-control mr-sm-2" placeholder="내용을 입력하세요." aria-label="Search" style="width: 250px;">
				</div>
				<button type="submit" class="btn btn-default" style="font-weight: bold;">검색</button>
			</form>
			<div style="padding:10px"></div>
			<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color:#eeeeee; text-align:center;">번호</th>
						<th style="background-color:#eeeeee; text-align:center;">제목</th>
						<th style="background-color:#eeeeee; text-align:center;">작성자</th>
						<th style="background-color:#eeeeee; text-align:center;">작성일</th>
						<th style="background-color:#eeeeee; text-align:center;">추천</th>
					</tr>
				</thead>		
				<tbody>
					<%				
						EvaluationDAO evaluationDAO = new EvaluationDAO();
						evaluationDAO.setNotice();
						ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
						evaluationList = new EvaluationDAO().getSort(lectureDivide, searchType, search, pageNumber);
						if(evaluationList != null)
						for(int i = 0; i < evaluationList.size(); i++) {
							if(i == 5) break;
							EvaluationDTO evaluation = evaluationList.get(i);						
					%>
					<tr>
						<td><%= evaluationList.get(i).getEvaluationID() %></td>
						<td><a href="view_index.jsp?evaluationID=<%= evaluationList.get(i).getEvaluationID() %>"><%= evaluationList.get(i).getEvaluationTitle() %></a></td>
						<td><%= evaluationList.get(i).getUserID() %></td>
						<td><%= evaluationList.get(i).getEvaluationDate().substring(0, 11) + evaluationList.get(i).getEvaluationDate().substring(11, 13) + "시" + evaluationList.get(i).getEvaluationDate().substring(14, 16) + "분" %></td>
						<td><%= evaluationList.get(i).getLikeCount() %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>		
			<%
				if(session.getAttribute("userID") != null) {
			%>	
					<a href="indexBoard.jsp" class="btn btn-primary pull-right">글쓰기</a>		
			<%
				}
			%>	
			<nav>
				<ul class="pager ">
			<%
				if(! (pageNumber == 0)) {
			%>				
					<li><a style="background-color:AliceBlue" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide, "UTF-8")%>
							&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber - 1%>">← Previous</a></li>
			<%		
				}
				if(!(evaluationList.size() < 6)) {
			%>
					<li><a style="background-color:AliceBlue" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide, "UTF-8")%>
							&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber + 1%>">Next →</a></li>
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