<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@page import="evaluation.*"%>
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
		ManagerDTO managerDTO = new ManagerDAO().getData(managerID);
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
						<th colspan="3" style="background-color:#eeeeee; text-align:center; border: 1px solid #dddddd">게시판</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="border: 1px solid #dddddd">글 제목</td>
						<td colspan="2"><%=evaluationDTO.getEvaluationTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %> </td>
					</tr>		
					<tr>
						<td style="border: 1px solid #dddddd">작성자</td>
						<td colspan="2"><%=evaluationDTO.getUserID() %> </td>
					</tr>					
					<tr>
						<td style="border: 1px solid #dddddd">작성일자</td>
						<td colspan="2"><%=evaluationDTO.getEvaluationDate().substring(0, 11) + evaluationDTO.getEvaluationDate().substring(11, 13) + "시" + evaluationDTO.getEvaluationDate().substring(14, 16) + "분" %></td>
					</tr>		
					<tr>
						<td style="border: 1px solid #dddddd">강의명</td>
						<td colspan="2"><%=evaluationDTO.getEvaluationTitle() %> </td>						
					</tr>
					<tr>
						<td style="border: 1px solid #dddddd">교수명</td>
						<td colspan="2"><%=evaluationDTO.getProfessorName() %> </td>
					</tr>
					<tr>
						<td style="border: 1px solid #dddddd">수강년도</td>
						<td colspan="2"><%=evaluationDTO.getLectureYear() %> </td>
					</tr>	
					<tr>
						<td style="border: 1px solid #dddddd">해당학기</td>
						<td colspan="2"><%=evaluationDTO.getSemesterDivide() %> </td>
					</tr>	
					<tr>
						<td style="border: 1px solid #dddddd">전공</td>
						<td colspan="2"><%=evaluationDTO.getLectureDivide() %> </td>
					</tr>	
					<tr>
						<td style="border: 1px solid #dddddd">종합</td>
						<td colspan="2"><%=evaluationDTO.getTotalScore() %> </td>
					</tr>
					<tr>
						<td style="border: 1px solid #dddddd">성적</td>
						<td colspan="2"><%=evaluationDTO.getCreditScore() %> </td>
					</tr>
					<tr>
						<td style="border: 1px solid #dddddd">분위기</td>
						<td colspan="2"><%=evaluationDTO.getComfortableScore() %> </td>
					</tr>
					<tr>
						<td style="border: 1px solid #dddddd">강의</td>
						<td colspan="2"><%=evaluationDTO.getLectureScore() %> </td>
					</tr>
					<tr>
						<td style="border: 1px solid #dddddd">내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%=evaluationDTO.getEvaluationContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %> </td>
					</tr>	
				</tbody>					
			</table>
			<a href="index.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(evaluationDTO.getUserID())) {
			%>
					<a href="update_index.jsp?evaluationID=<%= evaluationID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction_index.jsp?evaluationID=<%=evaluationID %>" class="btn btn-danger">삭제</a>
			<%
				} else {
					if(!(session.getAttribute("managerID") != null)) {
			%>
					<a data-toggle="modal" href="#reportModal" class="btn btn-danger pull-right"  style="width:50;float:right;" >신고</a>
			<%
					}
				}
			%>
			<a href="likeAction.jsp?evaluationID=<%=evaluationID %>" class="btn btn-primary pull-right" style="width:50;float:right; margin-right:4px;">좋아요</a>
		</div>
	</div>
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="modal">신고하기</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form method="post" action="./reportAction_doubleCheck.jsp">
              <div class="form-group">
                <label>신고 대상</label>
                <input type="text" name="reportTarget" class="form-control" maxlength="20" value=<%=evaluationDTO.getUserID()%> readonly>
              </div>
              <div class="form-group">
                <label>신고 제목</label>
                <input type="text" name="reportTitle" class="form-control" maxlength="20">
              </div>
              <div class="form-group">
                <label>신고 내용</label>
                <textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="submit"  onclick="userID=<%=userID %>" class="btn btn-danger">신고하기</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
	<%@ include file="footer.jsp"%>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>