<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</head>
<body>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>

	window.location.href='${pageContext.request.contextPath}/content';
	

</script>
<p>작업 메뉴</p>
<!-- <a href="buserinfo">부서 정보</a> -->
<c:if test="${res==null }">
	<a href="login">로그인</a>

	<a href="signup">회원 가입</a>
</c:if>
<c:if test="${res!=null }">
	<a href="logout">로그아웃</a>
	
	<a href="memberupdate">정보수정</a>
	
	<a href="my_trip">나의 여행</a>
</c:if>
<a href="content">여행 컨텐츠</a>

<a href="tb_list?page=1">커뮤니티</a>

<div class="search_wrap">
		<form id="searchForm" action="searchtotal" method="get">
			<div class="search_input">
				<input type="text" name="keyword">
				<button class='btn search_btn'>컨텐츠검색</button>
			</div>
		</form>
	</div>
</body>
</html>