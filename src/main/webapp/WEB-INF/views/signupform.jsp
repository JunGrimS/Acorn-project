<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script type="text/javascript">
function fn_checkid(){ 
			$.ajax({
				url : "checkid",
				type : "post",
				dataType : "json",
				data : {"user_id" : $("#user_id").val()},
				success : function(data){
					if(data == 1){
						alert("중복된 아이디입니다.");
					}else if(data == 0){
						$("#idChk").attr("value", "Y");
						alert("사용가능한 아이디입니다.");
					}
				}
			})
		}
$(function() { 
	$("#Date").datepicker(config);
});

const config={
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		yearSuffix: '년',
		changeMonth: true,
		changeYear: true
}
</script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<style>
body {
	min-height: 100vh;
	background: -webkit-gradient(linear, left bottom, right top, from(#92b5db),
		to(#1d466c));
	background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
}

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
				<h4 class="mb-3">회원가입</h4>
				<form class="validation-form" novalidate action="signup"
					method="post">
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="user_id">아이디</label> <input type="text"
								class="form-control" id="user_id" name="user_id" placeholder=""
								value="" required>
							<div class="invalid-feedback">아이디를 입력해주세요.</div>
						</div>

					</div>
					<button class="idChk btn btn-primary btn-lg btn-block"
						type="button" id="idChk" onclick="fn_checkid();" value="N">중복확인</button>
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="user_pwd">비밀번호</label> <input type="password"
								class="form-control" id="user_pwd" name="user_pwd"
								placeholder="" value="" required>
							<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
						</div>
					</div>
					<div class="mb-3">
						<label for="user_name">성명</label> <input type="text"
							class="form-control" id="user_name" name="user_name"
							placeholder="" required>
						<div class="invalid-feedback">성명을 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="user_tel">전화번호</label> <input type="text"
							class="form-control" id="user_tel" name="user_tel" placeholder=""
							required>
						<div class="invalid-feedback">전화번호를 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="user_email">이메일</label> <input type="email"
							class="form-control" id="user_email" name="user_email"
							placeholder="" required>
						<div class="invalid-feedback">이메일을 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="user_birth">생년월일</label> <input type="text"
							class="form-control" id="Date" name="user_birth" placeholder=""
							required>
						<div class="invalid-feedback">예)1990-00-00</div>
					</div>
					<div class="row">
						<div class="col-md-8 mb-3">
							<label><input type="radio" name="user_sex" value="male">남성</label>
							<label><input type="radio" name="user_sex" value="female">여성</label>
						</div>
					</div>
					<button class="btn btn-primary btn-lg btn-block" type="submit">가입
						완료</button>
				</form>
			</div>
		</div>
	</div>
	<script> window.addEventListener('load', () => {
		const forms = document.getElementsByClassName('validation-form');
		Array.prototype.filter.call(forms, (form) => {
			form.addEventListener('submit', function (event) {
				if (form.checkValidity() === false) {
					event.preventDefault();
					event.stopPropagation();
					} 
				form.classList.add('was-validated');
				}, false);
			});
		}, false); 
	</script>
</body>
</html>