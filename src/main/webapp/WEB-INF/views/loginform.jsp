<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta charset="UTF-8">
<title>로그인</title>
<style>
.input-form {
	max-width: 680px;
	margin-top: 80px;
	padding: 32px;
	background: #fff;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	-webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#logoutBtn").on("click", function() {
			location.href = "logout";
		})

		$("#registerBtn").on("click", function() {
			location.href = "signup";
		})

		$("#mypageBtn").on("click", function() {
			location.href = "mypage";
		})

		$("#updateBtn").on("click", function() {
			location.href = "memberupdate";
		})

		$("#findpwdBtn").on("click", function() {
			location.href = "findpwd";
		})
	})
</script>
</head>
<body>

	<div class="container">
		<div class="input-form-background rows">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">로그인</h4>
				<form action="login" method="post">
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="user_id">아이디</label> <input type="text"
								class="user_id_input form-control" id="user_id" name="user_id"
								placeholder="" value="" required>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="user_pwd">비밀번호</label> <input type="password"
								class="user_pwd_input form-control" id="user_pwd"
								name="user_pwd" placeholder="" value="" required>
						</div>
					</div>
					<div>
						<button type="submit" class="signup_btn btn btn-primary">로그인</button>
						<button class="btn btn-primary" id="registerBtn" type="button">회원가입</button>
						<button class="btn btn-primary" id="findpwdBtn" type="button">비밀번호찾기</button>
					</div>
					<c:if test="${msg == false}">
						<p style="color: red;">로그인 실패! 아이디와 비밀번호를 확인해주세요.</p>
					</c:if>
				</form>
			</div>
		</div>
	</div>
</body>
</html>