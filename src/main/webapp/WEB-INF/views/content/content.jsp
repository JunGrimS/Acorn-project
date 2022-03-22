<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@include file="/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.js"></script>

<title>컨탠트 페이지</title>
</head>
<body>
<c:if test="${not empty res }">
		<c:if test="${res.user_auth eq 3 }">
			<div class="d-flex justify-content-end me-5">
				<button type="button" class="btn btn-secondary mt-4"
					onclick="location.href='${pageContext.request.contextPath}/content/insert'">관광지
					추가</button>
			</div>
		</c:if>

	</c:if>
	
	<div class="container-fluid row align-items-center mt-4">
		<div class="col">
			<div class="fotorama mt-4" data-width="95%" data-height="60%"">
				<c:choose>
					<c:when test="${not empty frontImg}">
						<c:forEach items="${locPh }" var="p">
							<img src="${p.loc_ph_url }" />
						</c:forEach>
					</c:when>
					<c:otherwise>
						<img
							src="https://db3pap007files.storage.live.com/y4mRkp5Z6RoPbtWP3xRT2WvFcRsVfxX5TAm5M8IQamLE2G_PNd_AUtpuKeJc3ha6tblVw65f7txTxOJ3KoD_XgKttxaKBtWfLcPXXbtZFyAf6BjjZDlnp6s4fUiisDA4m7M4Gi1msDqjPb4lYGbiklQExoIAHOtwL_WGMEh0Hd-KwgTT9SCmNhFWVUzkjzLsums?width=1075&height=597&cropmode=none">
						<img  style="width: 00%; height: 50%;"
							src="https://post-phinf.pstatic.net/MjAxODA4MjJfMTY1/MDAxNTM0OTIyMTc0NzEy.J0aCknD1DgGaD5TX3e-7Bvhn8hQUkjzSYaGdxY3wkUUg.BtGdGzY9wmCdI92D47jGoWrFpH-D81h3BQQ7LirWmvQg.JPEG/%EA%B2%BD%EB%B3%B5%EA%B6%81_%EC%95%BC%EA%B2%BD%ED%88%AC%EC%96%B4_%285%29.jpg?type=w1200" />
						<img src="https://i.ytimg.com/vi/xCnaMivVn8Y/hq720.jpg">
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<div class="container mt-4" style="width: 60%;">
		<h5 class="my-2 ms-1">지역</h5>
			<div class="d-flex flex-wrap mb-4">
				<div >
					<a class="btn btn-primary mx-1 my-1" href="${pageContext.request.contextPath}/content/list?region=all">전체</a>
				</div>
				<c:forEach items="${regionList }" var="r">
				<div >
					<a class="btn btn-primary mx-1 my-1" href="${pageContext.request.contextPath}/content/list?region=${r}&city=none">${r}</a>
				</div>
				</c:forEach>				
		</div>
		<div class="my-2">
			<h5 class="my-2 ms-1">이번 추천 지역은 ${regionName } 입니다</h5>
			<div class="d-flex flex-wrap mb-4">
				<div >
					<a class="btn btn-warning mx-1 my-1" href="${pageContext.request.contextPath}/content/list?region=${regionName}">전체 보기</a>
				</div>
				<c:forEach items="${regionRecoList }" var="o" begin="1" end="10">
				<div >
					<a class="btn btn-warning mx-1 my-1" href="${pageContext.request.contextPath}/content/detail?loc_id=${o.loc_id }">${o.loc_name }</a>
				</div>
				</c:forEach>
		</div>
		<hr />
		<div class="my-2">
			<h5 class="my-2 ms-1">이번 추천 시/군은 ${cityName } 입니다.</h5>
			<div class="d-flex flex-wrap mb-4">
				<div >
					<!-- 미완 <a class="btn btn-primary mx-1 my-1" href="${pageContext.request.contextPath}/content/list?region=${regionName}">전체 보기</a>  -->
				</div>
				<c:forEach items="${cityRecoList }" var="o" begin="1" end="10">
				<div >
					<a class="btn btn-success mx-1 my-1" href="${pageContext.request.contextPath}/content/detail?loc_id=${o.loc_id }">${o.loc_name }</a>
				</div>
				</c:forEach>
		</div>
	</div>
	

	









</body>
</html>