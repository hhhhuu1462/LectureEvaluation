<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="manager.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset= UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>강의평가 웹 사이트</title>
<!-- 부트스트랩 css추가 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- 커스텀 css추가 -->
<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String managerID = null;
		if (session.getAttribute("managerID") != null) {
			managerID = (String) session.getAttribute("managerID");
		}
		ManagerDAO managerDAO = new ManagerDAO();
		ManagerDTO managerDTO = managerDAO.getData(managerID);
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
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4" >
			<div class="jumbotron" style="padding-top: 20px">
				<form method="post" action="managerModifyingAction.jsp">
					<h3 style="text-align: center;">관리자 정보 수정</h3>					
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="managerID" maxlength="20" value="<%=managerDTO.getManagerID() %>" readonly="readonly">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="managerPassword" maxlength="20" value="<%=managerDTO.getManagerPassword()%>">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="managerName" maxlength="20" value="<%=managerDTO.getManagerName()%>">
					</div>
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active">
								<input type="radio" name="managerGender" autocomplete="off" value="남자" checked>남자
							</label> 
							<label class="btn btn-primary">
								 <input type="radio" name="managerGender" autocomplete="off" value="여자" >여자
							</label>
						</div>
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" name="managerEmail" maxlength="20" value="<%=managerDTO.getManagerEmail()%>">
					</div>	
					<div class="form-group">
                        <label>휴대폰 번호('-' 빼고 입력)</label>
                        <input type="tel" class="form-control" name="phoneNumber" placeholder="휴대폰번호를 입력해 주세요" value="0<%=managerDTO.getPhoneNumber()%>">
                    </div>	                				
				<div>
					<label>
						<form method="post" action="managerModifyingAction.jsp">
							<input type="submit" class="btn btn-primary form-control" value="수정완료">
						</form>
					</label>
					<label>
						<form method="post" action="main.jsp">
							<input type="submit" class="btn btn-danger form-control"  value="수정취소" >
						</form>
					</label>
				</div>
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
