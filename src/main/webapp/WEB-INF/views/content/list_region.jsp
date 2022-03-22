<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/header.jsp" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
let loc_num;

function imgCheck(loc_id){
	loc_num=loc_id;
	let data= "loc_id="+loc_id;
		$.ajax({
			  url : "locImg",
			  data: data,
			  type : "get",
			  success : function(url) {
			  	console.log(url);
			  	$(this).attr('src',url);
			  	
		      },
			  error : function() {//이미지 없으면 바꿔주고
			  	console.log($(this).attr('id') + ": 이미지 없음");
			  	$(this).attr('src',"/resources/image/no-image-icon-23499.png");
				}
		});
		
}
/*
$("#820").ready(function() { 
	let idNum=().attr('id')
	if($(".locImg").attr('src') == "https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=ee65154d-e426-4f6f-8bf0-f838f3736c97&thumb"){
		let data= "loc_id="+idNum;
		$.ajax({
			  url : "locImg",
			  data: data,
			  type : "get",
			  success : function(url) {
			  	console.log(url);
			  	$(this).attr('src',url);
			  	
		      },
			  error : function() {//이미지 없으면 바꿔주고
			  	console.log($(this).attr('id') + ": 이미지 없음");
			  	$(this).attr('src',"/resources/image/no-image-icon-23499.png");
				}
		});
	}
});
*/
</script>
</head>
<body>
<div class="container justify-content-start ms-6 me-6" >
	<div class="ms-5 me-5">
		<div class="row mt-5">
			<h1>${region }</h1>
			<c:if test="${not empty res }">
				<c:if test="${res.user_auth eq 3 }">
				<div class="d-flex justify-content-end">
					<button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/content/insert'">관광지 추가</button>
				</div>
				</c:if>
			
			</c:if>
		</div>
		<hr />
		<div class="row">
			<div class="col-8">
				<div class="row"> 
					<h5>총 ${totalNum } 건</h5>
				</div>
				<hr />
				<%--
				<!-- 예시 -->>
				<div class="row">
					<table style="width: 100%;" class="table table-stripted">
						<tbody>
							<tr>
								<th style="width: 23%; height: auto;" rowspan="4"><img style="vertical-align; width: auto; height: auto;" src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=ee65154d-e426-4f6f-8bf0-f838f3736c97&thumb" alt="" /></td>
								<td style="font-weight: bold; ">이름</th>
							</tr>
							<tr>
								<td style="font-size: small;">region city</td>
							</tr>
							<tr>
								<td style="font-size: small;">전화번호: 000-1111-1411</td>
							</tr>
							<tr>
								<td style="font-size: small;">해쉬태그 </td>
							</tr>
						</tbody>
					</table>
				</div>
				 --%>
				<c:forEach items="${list }" var="o" varStatus="status">
				<div class="row">
					<table style="width: 100%;" class="table-borderless mb-2">
						<tbody>
							<tr>
								<c:choose>
									<c:when test="${not empty o.loc_ph_url }">
										<th style="width: 23%; height: auto;" rowspan="4"><img id="${o.loc_id }"  style="vertical-align; width: 100%; height: 100%;" src="${o.loc_ph_url}"/></td>
									</c:when>
									<c:when test="${empty o.loc_ph_url }">
										<th style="width: 23%; height: auto;" rowspan="4"><img id="${o.loc_id }"  style="vertical-align; width: 100%; height: 100%;" src="${pageContext.request.contextPath}/resources/image/no-image-icon-23499.png"/></td>
									</c:when>
								</c:choose>
									<th style="width: 5%; height: auto;" rowspan="4"></td>
								<td class="ms-3" style="font-weight: bold; "><a href="detail?loc_id=${o.loc_id }">${o.loc_name }</a></td>
							</tr>
							<tr>
								<td class="ms-3" style="font-size: small;">${o.loc_region } ${o.loc_city }</td>
							</tr>
							<tr>
								<td class="ms-3" style="font-size: small;">전화번호: ${o.loc_tel }</td>
							</tr>
							<tr>
								<td class="ms-3" style="font-size: small;">해쉬태그: #${o.loc_cat } #${o.loc_city } </td>
							</tr>
						</tbody>
					</table>
				</div>
				</c:forEach>
				<div class="pagingDiv">
					<nav aria-label="Page navigation example">
  						<ul class="pagination">
   							<li id="prevBtn" class="page-item ${pagingNumMap.startPageNum eq 1 ? 'disabled':'' }"><a  class="page-link" href="${pageContext.request.contextPath}/content/list?pageNum=${pagingNumMap.startPageNum-1 }&region=${region}&city=${city}">Previous</a></li>
		    			<c:forEach var="i" begin="${pagingNumMap.startPageNum }" end="${pagingNumMap.endPageNum }">
		    				<li class="page-item ${pagingNumMap.pageNum eq i ? 'active':'' }"><a class="page-link" href="${pageContext.request.contextPath}/content/list?pageNum=${i }&region=${region}&city=${city}">${i }</a></li>
		    			</c:forEach>
   							<li id="nextBtn" class="page-item ${pagingNumMap.endPageNum eq pagingNumMap.totalPageCount ? 'disabled':''}"><a class="page-link" href="${pageContext.request.contextPath}/content/list?pageNum=${pagingNumMap.endPageNum+1 }&region=${region}&city=${city}">Next</a></li>
  						</ul>
					</nav>
				</div>
			</div>
			<div class="col-4">
			<%-- 선택된 시도/지역은 음영처리되도록 추후 추가  --%>
				<div class="row">
					<table class="table table-borderless table-responsive-sm mt-2">
						<thead>
							<tr class="">
								<th style="border-bottom: 2px solid #c8c9cb;">시/도</th>
							</tr>
						</thead>
						<tbody>
							<tr>
							<!-- 지역만 선택하는 경우기 때문에 city는 null -->
							<c:forEach var="r" items="${regions}" varStatus="status" >
								<c:if test="${status.index%4==0}">
								</tr><tr>
								</c:if>
									<td><a href="list?region=${r}&city=none">${r }</a></td>						
							</c:forEach>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="row">
					<c:if test="${region ne 'all' }">
					<table class="region_table table table-borderless table-responsive-sm">
						<thead>
							<tr>
								<th style="border-bottom: 2px solid #c8c9cb;">${region }</th>
							</tr>
						</thead>
						<tbody>
							<tr>
							<!-- 도시선택 경우에는 지역이름과 도시이름 둘다 param으로 넘기기 -->
							<c:forEach var="c" items="${cities}" varStatus="status" >
								<c:if test="${status.index%4==0}">
								</tr><tr>
								</c:if>
									<td><a href="list?city=${c }&region=${region}">${c }</a></td>						
							</c:forEach>
							</tr>
						</tbody>
					</table>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
/*
let loc_num;

function imgCheck(loc_id){
	loc_num=loc_id;
	let data= "loc_id="+loc_id;
		$.ajax({
			  url : "locImg",
			  data: data,
			  type : "get",
			  success : function(url) {
			  	console.log(url);
			  	$(this).attr('src',url);
			  	
		      },
			  error : function() {//이미지 없으면 바꿔주고
			  	console.log($(this).attr('id') + ": 이미지 없음");
			  	$(this).attr('src',"/resources/image/no-image-icon-23499.png");
				}
		});
		
}
*/
/*
$("#820").ready(function() { 
	let idNum=().attr('id')
	if($(".locImg").attr('src') == "https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=ee65154d-e426-4f6f-8bf0-f838f3736c97&thumb"){
		let data= "loc_id="+idNum;
		$.ajax({
			  url : "locImg",
			  data: data,
			  type : "get",
			  success : function(url) {
			  	console.log(url);
			  	$(this).attr('src',url);
			  	
		      },
			  error : function() {//이미지 없으면 바꿔주고
			  	console.log($(this).attr('id') + ": 이미지 없음");
			  	$(this).attr('src',"/resources/image/no-image-icon-23499.png");
				}
		});
	}
});
*/
</script>

</body>
</html>