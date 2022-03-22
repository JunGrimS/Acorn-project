<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<title>Community</title>
<script type="text/javascript">

	// 글쓰기 회원 유효성
	function fnInsert(user_id){

		if(!user_id){
			alert("로그인해주세요.");
			return;
		}
		$("#tb_url").val("tb_list?");
		
		document.frm.action = "tb_insertPage";
		document.frm.submit();
	}

	// 상세보기
	function fnDetail(tb_no){
		
		$("#tb_no").val(tb_no);
		$("#tb_url").val("tb_list");
		
		document.frm.action = "tb_detail";
		document.frm.submit();
	}
	
</script>
<style>

</style>
</head>
<body>
	<div class="container">
	<div class="row my-3">
		<div class="col-sm-12">
			<h1 class="text-center">Community</h1>
			<hr />

<!-- 			<a href="tb_insertPage">글 쓰기</a> -->
<!-- 			<a href="tb_list2?tb_cat=1&page=1"></a> -->
		</div>
	</div>
	<form id="frm" name="frm">
		<input type="hidden" name="tb_cat" id="tb_cat" value="" />
		<input type="hidden" name="tb_no" id="tb_no" value=""/>
		<input type="hidden" name="page" id="page" value=""/>
		<input type="hidden" name="searchN" id="searchN" value=""/>
		<input type="hidden" name="searchV" id="searchV" value=""/>
		<input type="hidden" name="tb_url" id="tb_url" value=""/>
		<div class="row">	
			<c:forEach var="table" items="${list }" varStatus="status" >
					<div class="col-4 fw-bold">	
						<div class="fs-2" style="float:left;">
							<c:choose>
								<c:when test="${status.index eq '0' }">
									공지
								</c:when>
								<c:when test="${status.index eq '1' }">
									문의
								</c:when>
								<c:otherwise>
									자유
								</c:otherwise>							
							</c:choose>
							게시판
						</div>
						<div style="float:right;">
							<a href="tb_list2?page=1&tb_cat=${status.index+1}"  class="bi bi-arrow-right-square" >
								<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-arrow-right-square" viewBox="0 0 16 16">
									더보기
	  								<path fill-rule="evenodd" d="M15 2a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2zM0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm4.5 5.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z"/>
								</svg>
							</a>
						</div>
						<table class="table table-striped table-hover" >
							<thead>
								<tr class="something">
									<c:choose>
										<c:when test="${status.index eq 0 }">
											<th scope="col" class="text-center col-md-6">제목</th>
										</c:when>
										<c:when test="${status.index ne 0 }">
											<th scope="col" class="text-center col-md-2">지역</th>
											<th scope="col" class="text-center col-md-4">제목</th>
										</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>
									<th scope="col" class="text-center col-md-1">ID</th>
									<th scope="col" class="text-center col-md-3">작성일</th>
									<th scope="col" class="text-center col-md-2">조회</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="a" items="${table}">
									<tr>
		<!-- 								<th scope="row"> -->
		<%-- 									<c:choose> --%>
		<%-- 										<c:when test="${a.tb_cat eq '1' }"> --%>
		<!-- 											공지 -->
		<%-- 										</c:when> --%>
		<%-- 										<c:when test="${a.tb_cat eq '2' }"> --%>
		<!-- 											문의 -->
		<%-- 										</c:when> --%>
		<%-- 										<c:otherwise> --%>
		<!-- 											자유 -->
		<%-- 										</c:otherwise>							 --%>
		<%-- 									</c:choose> --%>
		<!-- 								</th> -->
										<c:if test="${status.index ne 0 }">
											<td>
											<c:choose>
												<c:when test="${a.tb_region eq '0001'}">
													서울
												</c:when>
												<c:when test="${a.tb_region eq '0002'}">
													경기
												</c:when>
												<c:when test="${a.tb_region eq '0003'}">
													강원
												</c:when>
												<c:when test="${a.tb_region eq '0004'}">
													충청
												</c:when>
												<c:when test="${a.tb_region eq '0005'}">
													전라
												</c:when>
												<c:when test="${a.tb_region eq '0006'}">
													경상
												</c:when>
												<c:when test="${a.tb_region eq '0007'}">
													제주
												</c:when>
												<c:otherwise>
												</c:otherwise>
											</c:choose>
											</td>
										</c:if>
										<td>
											<!-- span = text 줄이기 -->
											<span class="d-inline-block text-truncate" style="max-width: 110px;">
												<a href="#" onclick="fnDetail('${a.tb_no}');">
													${a.tb_title }
												</a>
											</span>
										</td>
										<td>${a.tb_id }</td>
										<td>
											<c:out value="${fn:substring(a.tb_date,2,10)}"/>
										</td>
										<td>${a.tb_readcnt }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
			</c:forEach>
			<div class="row">	
				<div class="col-12" >
					<div style="float:right;">
						<a href="#" onclick="fnInsert('${res.user_id}');" class="btn btn-primary" >글쓰기</a>
					</div>		
				</div>
			</div>
		</div>
	</form>
	</div>
</body>
</html>