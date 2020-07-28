<%@page import="manager.ManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="evaluation.*"%>
<%@page import="user.*"%>
<%@page import="notice.*"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
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
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='userLogin.jsp'");
			script.println("</script>");
		}
		int evaluationID = 0;
		if(request.getParameter("evaluationID") != null) {
			evaluationID = Integer.parseInt(request.getParameter("evaluationID"));
		}
		if(evaluationID==0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		}
		EvaluationDTO evaluationDTO = new EvaluationDAO().getindex(evaluationID);
		if(!userID.equals(evaluationDTO.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이 글에 대한 권한이 없습니다')");
			script.println("location.href='index.jsp'");
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
			<form method="post" action="updateAction_index.jsp?evaluationID=<%=evaluationID%>">
				<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="4" style="background-color:#eeeeee; text-align:center;">게시판 글 수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2" ><input type="text" class="form-control" placeholder="강의명" name="lectureName" maxlength="50" value="<%=evaluationDTO.getLectureName() %>"></td>
							<td colspan="2"><input type="text" class="form-control" placeholder="교수명" name="professorName" maxlength="50" value="<%=evaluationDTO.getProfessorName() %>"></td>
						</tr>
						<tr>							
							<td>
								<select name="lectureYear" class="form-control">
									<option value="수강년도" disabled="disabled" selected>수강년도</option>
									<option value="2010">2010</option>
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020" >2020</option>
								</select>
							</td>	
							<td>
								<select name="semesterDivide" class="form-control">								
									<option value="해당학기" disabled="disabled" selected>해당학기</option>
									<option value="1학기" >1학기</option>
									<option value="여름학기">여름학기</option>
									<option value="2학기">2학기</option>
									<option value="겨울학기">겨울학기</option>
								</select>
							</td>	
							<td>
								<select name="lectureDivide" class="form-control">
									<option value="전공선택" disabled="disabled" selected>전공선택</option>
									<option value="전공" >전공</option>
									<option value="교양">교양</option>
									<option value="기타">기타</option>
								</select>
							</td>
						</tr>	
						<tr>
							<td colspan="4">
								<input placeholder="제목" type="text" name="evaluationTitle" class="form-control" maxlength="30" value="<%=evaluationDTO.getEvaluationTitle() %>">
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<textarea placeholder="내용입력" name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"> <%=evaluationDTO.getEvaluationContent() %> </textarea>
							</td>
						</tr>
						<tr>
							<td colspan="1">
								<select name="totalScore" class="form-control">
									<option value="종합" disabled="disabled" selected>종합</option>
									<option value="A" >A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</td>
							<td colspan="1">
								<select name="creditScore" class="form-control">
									<option value="성적" disabled="disabled" selected>성적</option>
									<option value="A">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</td>
							<td colspan="1">
								<select name="comfortableScore" class="form-control">
									<option value="분위기" disabled="disabled" selected>분위기</option>
									<option value="A">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</td>
							<td colspan="1">
								<select name="lectureScore" class="form-control">
									<option value="강의" disabled="disabled" selected>강의</option>
									<option value="A">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</td>
						</tr>
					</tbody>					
				</table>
				<label style="float:right">
					<input type="submit" class="btn btn-primary " value="글 수정" >
					<input onclick="location='index.jsp'" type="button" class="btn btn-danger "  value="수정취소" >
				</label>
			</form>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>