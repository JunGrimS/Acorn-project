<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script 
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원정보수정</title>
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
</head>
<body>
	<div class="container">
		<div class="input-form-background row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">회원정보수정</h4>
				<form novalidate action="memberupdate" method="post">
					<div class="form-group has-feedback">
						<label class="control-label" for="user_id">아이디</label> <input
							class="form-control" type="text" id="user_id" name="user_id"
							value="${res.user_id}" readonly="readonly" />
					</div>
					<div class="mb-3">
						<label for="user_pwd">비밀번호</label> <input type="password"
							class="form-control" id="user_pwd" name="user_pwd" placeholder=""
							value="" required>
					</div>
					<div class="mb-3">
						<label for="user_name">성명</label> <input type="text"
							class="form-control" id="user_name" name="user_name"
							placeholder="" required>
					</div>
					<div class="mb-3">
						<label for="user_tel">전화번호</label> <input type="text"
							class="form-control" id="user_tel" name="user_tel" placeholder=""
							required>
					</div>
					<div class="mb-3">
						<label for="user_email">이메일</label> <input type="email"
							class="form-control" id="user_email" name="user_email"
							placeholder="" required>
					</div>
					<div class="mb-3">
						<label for="user_birth">생년월일</label> <input type="text"
							class="form-control" id="user_birth" name="user_birth"
							placeholder="" required>
					</div>
					<div class="row">
						<div class="col-md-8 mb-3">
							<label for="user_sex">성별</label> <select
								class="custom-select d-block w-100" id="user_sex"
								name="user_sex">
								<option value=""></option>
								<option>남</option>
								<option>여</option>
							</select>
							<div class="invalid-feedback">성별을 선택해주세요.</div>
						</div>
					</div>
					<button class="btn btn-primary btn-lg" type="submit">수정
						완료</button>
				</form>
				<form id="memberdeleteForm" action="memberdelete" method="get">
				<button class="btn btn-primary btn-lg" id="submit">회원 탈퇴</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>