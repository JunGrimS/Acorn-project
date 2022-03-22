<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="header" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- jQuery -->

<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>

 -->

<%-- <script src="${pageContext.request.contextPath}/resources/common/js/jquery-3.3.1.min.js" ></script> --%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">

<meta name="viewport" content="width=device-width, initial-scale=1">


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<!-- Bootstrap theme -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap-theme.min.css"> --%>

<!-- common CSS -->
<link rel="stylesheet"
	href="<header:url value='${pageContext.request.contextPath}/resources/common/css/common.css'/>">

<!--메뉴바 추가 부분-->
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
	<a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">여행</a>
	<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample03" aria-controls="navbarsExample05" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarsExample03">
		<ul class="navbar-nav me-auto mb-2 mb-lg-0">
			<li class="nav-item active"><a class="nav-link" href="#">Home
					<span class="sr-only">(current)</span>
			</a></li>
			<header:if test="${res==null }">
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">로그인</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/signup">회원가입</a></li>
			</header:if>
			<header:if test="${res!=null }">
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">로그아웃</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/memberupdate">정보수정</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/my_trip">나의여행</a></li>
			</header:if>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/content">여행 컨텐츠</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/tb_list?page=1">커뮤니티</a></li>
		</ul>
		<form class="form-inline my-2 my-md-0" action="${pageContext.request.contextPath}/searchtotal" method="get">
			<input class="form-control" type="text" placeholder="Search" name="keyword">
		</form>
	</div>
</nav>


