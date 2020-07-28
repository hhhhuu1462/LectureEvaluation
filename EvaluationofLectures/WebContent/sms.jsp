<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SMS 발송</title>

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

<body onload="loadJSON()">
	<%
		String phoneNumber = null;
		if (request.getParameter("phoneNumber") != null) {
			phoneNumber = (String)request.getParameter("phoneNumber");
		}
	%>		
	
		
	<form method="post" name="smsForm" action="smssend.jsp">
		<input type="hidden" name="action" value="go">
		<div class="container">
			<div class="row">
				<table class="table table-striped" style="text-align: center; table-layout: fixed; border: 1px solid #dddddd;">
					<thead>
						<tr>
							<th colspan="4" style="background-color: #eeeeee; text-align: center;">SMS</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="4">
								<input placeholder="받는 번호" type="text" name="rphone" class="form-control" maxlength="30" value=0<%=phoneNumber %>>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<textarea placeholder="내용입력" name="msg" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<label style="float: right">
					<input onclick="location='memberManagement.jsp'" type="button" class="btn btn-danger " value="취소" name="cancle" style="width: 50; float: right;"> 
					<input type="submit" class="btn btn-primary " value="발송" style="width: 50; float: right; margin-right: 4px;">
				</label>
				<input type="hidden" name="sphone1" value="010">
				<input type="hidden" name="sphone2" value="2282">
				<input type="hidden" name="sphone3" value="4338">
			</div>
		</div>
	</form>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>