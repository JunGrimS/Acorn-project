<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/header.jsp" %>	
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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
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
.final_id_ck{
    display: none;
}
.final_pwd_ck{
    display: none;
}
.final_pwdck_ck{
    display: none;
}
.final_name_ck{
    display: none;
}
.final_tel_ck{
    display: none;
}
.final_mail_ck{
    display: none;
}
.final_birth_ck{
    display: none;
}

/* 비밀번호 확인 일치 유효성검사 */
.pwck_input_re_1{
        color : green;
        display : none;    
}
.pwck_input_re_2{
        color : red;
        display : none;    
}

</style>
</head>
<body>
	<div class="container">
		<div class="input-form-background row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">회원가입</h4>
				<form class="validation-form" id="signup_form"
					method="post">
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="user_id">아이디</label> <input type="text"
								class="user_id_input form-control" id="user_id" name="user_id" placeholder=""
								value="" required>
								<span class="final_id_ck">아이디를 입력해주세요.</span>
						</div>
					</div>
					<button class="idChk btn btn-primary btn-lg"
						type="button" id="idChk" onclick="fn_checkid();" value="N">중복확인</button>
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="user_pwd">비밀번호</label> <input type="password"
								class="user_pwd_input form-control" id="user_pwd" name="user_pwd"
								placeholder="" value="">
							<span class="final_pwd_ck">비밀번호를 입력해주세요.</span>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="user_pwdck">비밀번호확인</label> <input type="password"
								class="user_pwdck_input form-control" id="user_pwdck" name="user_pwdck"
								placeholder="" value="">
						</div>
						<span class="final_pwdck_ck">비밀번호 확인을 입력해주세요.</span>
							<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
							<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
					</div>
					<div class="mb-3">
						<label for="user_name">성명</label> <input type="text"
							class="user_name_input form-control" id="user_name" name="user_name"
							placeholder="">
						<span class="final_name_ck">이름을 입력해주세요.</span>
					</div>
					<div class="mb-3">
						<label for="user_tel">전화번호</label> <input type="text"
							class="user_tel_input form-control" id="user_tel" name="user_tel" placeholder="">
						<span class="final_tel_ck">전화번호를 입력해주세요.</span>
					</div>
					<div class="mb-3">
						<label for="user_email">이메일</label> <input type="email"
							class="user_email_input form-control" id="user_email" name="user_email"
							placeholder="">
						<span class="final_mail_ck">이메일을 입력해주세요.</span>
					</div>
					<div class="mb-3">
						<label for="user_birth">생년월일</label> <input type="text"
							class="user_birth_input form-control" id="user_birth" name="user_birth" placeholder="">
						<span class="final_birth_ck">생년월일을 입력해주세요.</span>
					</div>
					<div class="row">
						<div class="col-md-8 mb-3">
							<label><input type="radio" name="user_sex" value="male">남성</label>
							<label><input type="radio" name="user_sex" value="female">여성</label>
						</div>
					</div>
					<button class="signup_btn btn btn-primary btn-lg" >가입
						완료</button>
				</form>
			</div>
		</div>
	</div>

<script>
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

/* 유효성 검사 통과유무 변수 */
var idCheck = false;            // 아이디
var idckCheck = false;            // 아이디 중복 검사
var pwCheck = false;            // 비번
var pwckCheck = false;            // 비번 확인
var pwckcorCheck = false;        // 비번 확인 일치 확인
var nameCheck = false;            // 이름
var mailCheck = false;            // 이메일
var birthCheck = false;
var telCheck = false;

$(document).ready(function(){
	//회원가입 버튼(회원가입 기능 작동)
    $(".signup_btn").click(function(){

        /* 입력값 변수 */
    var user_id = $('.user_id_input').val();                 // id 입력란
    var user_pwd = $('.user_pwd_input').val();                // 비밀번호 입력란
    var user_pwdck = $('.user_pwdck_input').val();            // 비밀번호 확인 입력란
    var user_name = $('.user_name_input').val();				// 이름 입력란
    var user_tel = $('.user_tel_input').val();  
    var user_email = $('.user_email_input').val();            // 이메일 입력란
    var user_birth = $('.user_birth_input_').val();        // 생일 입력란 
    
    /* 아이디 유효성검사 */
    if(user_id == ""){
        $('.final_id_ck').css('display','block');
        idCheck = false;
    }else{
        $('.final_id_ck').css('display', 'none');
        idCheck = true;
    }
    
    /* 비밀번호 유효성 검사 */
    if(user_pwd == ""){
        $('.final_pwd_ck').css('display','block');
        pwCheck = false;
    }else{
        $('.final_pwd_ck').css('display', 'none');
        pwCheck = true;
    }
    
    /* 비밀번호 확인 유효성 검사 */
    if(user_pwdck == ""){
        $('.final_pwdck_ck').css('display','block');
        pwckCheck = false;
    }else{
        $('.final_pwdck_ck').css('display', 'none');
        pwckCheck = true;
    }
    
    /* 이름 유효성 검사 */
    if(user_name == ""){
        $('.final_name_ck').css('display','block');
        nameCheck = false;
    }else{
        $('.final_name_ck').css('display', 'none');
        nameCheck = true;
    }
    
    /* 이메일 유효성 검사 */
    if(user_email == ""){
        $('.final_mail_ck').css('display','block');
        mailCheck = false;
    }else{
        $('.final_mail_ck').css('display', 'none');
        mailCheck = true;
    }
    
    /* 생일 유효성 검사 */
    if(user_birth == ""){
        $('.final_birth_ck').css('display','block');
        birthCheck = false;
    }else{
        $('.final_birth_ck').css('display', 'none');
        birthCheck = true;
    }
    
    /* 전화번호 유효성 검사 */
    if(user_tel == ""){
        $('.final_tel_ck').css('display','block');
        telCheck = false;
    }else{
        $('.final_tel_ck').css('display', 'none');
        telCheck = true;
    }
    
    if(idCheck&&pwCheck&&pwckCheck&&pwckcorCheck&&nameCheck&&mailCheck&&birthCheck&&telCheck ){
        $("#signup_form").attr("action", "signup");
        $("#signup_form").submit(); 
    } 
    
    return false;
    });
    
});

/* 비밀번호 확인 일치 유효성 검사 */

$('.user_pwdck_input').on("propertychange change keyup paste input", function(){
        
    var user_pwd = $('.user_pwd_input').val();
    var user_pwdck = $('.user_pwdck_input').val();
    $('.final_pwdck_ck').css('display', 'none');
    
    if(user_pwd == user_pwdck){
        $('.pwck_input_re_1').css('display','block');
        $('.pwck_input_re_2').css('display','none');
        pwckcorCheck = true;
    }else{
        $('.pwck_input_re_1').css('display','none');
        $('.pwck_input_re_2').css('display','block');
        pwckcorCheck = false;
    }      
});



</script>
</body>
</html>