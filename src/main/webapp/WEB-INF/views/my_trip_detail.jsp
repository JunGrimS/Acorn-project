<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 여행 상세 내용 페이지</title>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap" rel="stylesheet">
<style>
	*{
		font-family: 'Noto Sans KR', sans-serif;
	}
</style>

<style>
	.table td img{
		max-width:100%;
	}
</style>

<!-- bootstrap css 로딩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- bootstrap javascript 로딩 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script type="text/javascript">

//수정하기
function update(){
	location.href='my_trip_update?ti_id=${data.ti_id }';
} 

//삭제하기
function deleteCheck(){
	if(confirm("정말 삭제하시겠습니까?") == true){
		location.href='delete?ti_id=${data.ti_id }';
	}else{
		return;
	}
}
</script>

</head>

<body>
<div class="container justify-content-start ms-6 me-6">
	<table class="table table-stripted">
		<tr>
			<td style="text-align: right">
				<input class="btn btn-primary" type="button" value="수정" onclick="update()"> 
				<input class="btn btn-warning" type="button" value="삭제" onclick="deleteCheck()">
				<input class="btn btn-secondary" type="button" value="목록으로 돌아가기" onclick="location.href='my_trip_list'">
			</td>
		</tr>
	</table>
	
	<table  class="table table-stripted">	
		<tr>
			<td>
				방문날짜 : ${data.ti_visit_date.substring(0,10) }&nbsp;&nbsp;&nbsp;&nbsp;
				작성일 : ${data.ti_reg_write.substring(0,16) }
			</td>
		</tr>
		<tr>
			<td colspan="3">제목 : ${data.ti_trip_name }</td>
		</tr>
	</table>
	
	<div class="fs-4 mt-3">
		<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-arrow-right-circle-fill" viewBox="0 0 16 16">
		  <path d="M8 0a8 8 0 1 1 0 16A8 8 0 0 1 8 0zM4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z"/>
		</svg> 다녀온 여행지
	</div>
	
	<!-- 다녀온 여행지 테이블 -->
	<div id="contAreaBox">
	<div class="table-responsive mt-2">
	<table id="resTb" class="table table-striped table-bordered text-center tbl_List">
		<thead>
			<tr>
				<th>장소명</th>
				<th>지역</th>
				<th>주소</th>
				<th>전화번호</th>
				<th>운영시간</th>
			</tr>
		</thead> 
		<tbody>
			<c:forEach var="out" items="${locData }">	
			<tr>
				<td>${out.loc_name }</td>
				<td>${out.loc_region }</td>
				<td>${out.loc_addr }</td>
				<td>${out.loc_tel }</td>
				<td>${out.loc_worktime }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	
	<div class="table-responsive mt-2 mb-5">
	<table id="resTb" class="table table-striped table-bordered text-center tbl_List">
		<c:forEach var="out" items="${locData }">
			<tr>
				<th>${out.loc_name }</th>
			</tr>
			<tr>
				<td><img src="${out.ti_pic_url }"></td>
			</tr>
			<tr>
				<td style="white-space: pre-line;">${out.ti_content }</td>
			</tr>
		</c:forEach>
	</table>
	</div>
	
	</div>
</div>
</body>
</html>