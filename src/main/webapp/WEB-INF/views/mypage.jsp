<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>마이페이지</title>
<script type="text/javascript">
	$(document).ready(function() {
		$("#logoutBtn").on("click", function() {
			location.href = "logout";
		})
 
		$("#updateBtn").on("click", function() {
			location.href = "memberupdate";
		})

		$("#deleteBtn").on("click", function() {
			location.href = "memberdelete";
		})
		
		$("#adminBtn").on("click", function() {
			location.href = "admin";
		})
	})
</script>
</head>
<body>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<h3>작성글</h3>
	<div>
		<p>${res.user_id}님환영합니다.</p>
		<button id="logoutBtn" type="button">로그아웃</button>
		<button id="updateBtn" type="button">회원 정보 수정</button>
		<button id="deleteBtn" type="button">회원 탈퇴</button>
	</div>
	<div>
		<c:if test="${res.user_auth==2 }">
			<button id="adminBtn" type="button">관리자 페이지</button>
		</c:if>
		<a href="/www/tb_list?page=1">목록이동</a>
	</div>
</body>
</html>