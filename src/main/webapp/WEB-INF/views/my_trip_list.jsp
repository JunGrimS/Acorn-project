<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 여행 리스트 페이지</title>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap" rel="stylesheet">
<style>
	*{
		font-family: 'Noto Sans KR', sans-serif;
	}
</style>
<!-- bootstrap css 로딩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- bootstrap javascript 로딩 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</head>
<body>
<div class="container justify-content-start ms-6 me-6">
	<div class="col-4 fw-bold mt-5">
		<h2>나의 여행 목록</h2> 
	</div>
	<div class="d-flex justify-content-end">
		<a href="insert" class="btn float-right btn-dark">나의 여행 추가</a>
	</div>
	<div class="mt-5 mb-5">
	<table class="table table-stripted">
		<!-- 등록된 여행 리스트 -->
		<tr>
			<th>번호</th>
			<th>여행 이름</th>
			<th>방문일</th>
			<th>등록일</th>	
		</tr>
		<c:forEach var="out" items="${data }">	
		<tr>
			<td>${out.ti_num }</td>
			<td><a href="my_trip_detail?ti_id=${out.ti_id }">${out.ti_trip_name }</a></td>
			<td>${out.ti_visit_date.substring(0,10)}</td>
			<td>${out.ti_reg_write.substring(0,16)}</td>
		</tr>
		</c:forEach>
	</table>
	</div>
</div>
</body>
</html>