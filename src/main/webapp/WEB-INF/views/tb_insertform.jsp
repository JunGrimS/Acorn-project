<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 부트 -->

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script 
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
	
	
<style>
.insert-form {
	max-width: 900px;
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
<script>

	//선택 유효성
	window.onload = function(){
		let btnIns = document.querySelector("#btnIs");
		btnIns.addEventListener("click", clickData);
	}
	function clickData(){

		if(is.tb_cat.value == 0){
			alert("분류를 선택하지 않았습니다.");
			is.name.focus();
			return;
		}
		
		if(is.tb_region.value === ""){
			alert("지역을 선택하지 않았습니다.");
			is.name.focus();
			return;
		}
		
		if(is.tb_title.value === ""){
			alert("제목을 입력하지 않았습니다.");
			is.name.focus();
			return;
		}
		
		if(is.tb_no.value == 0){
			is.action = "tb_insert";
			
		}else{
			is.action = "tb_update?tb_no="+is.tb_no.value+"&tb_url"+$("#tb_url").val();
			
		}

		is.submit();
	}	
	
</script>
<div class="container">
	<div class="insert-form col-md-12 mx-auto">
		<h1 class="text-center" >
			<c:choose>
				<c:when test="${dto.tb_no ne '0' }">
					수정 페이지
				</c:when>
				<c:otherwise>
					새로운 이야기
				</c:otherwise>
			</c:choose>
		</h1>
		<form action="#" method="post" id="is">
			<div>
				<input type="hidden" name="tb_no" value="<c:out value="${dto.tb_no }"/>" />
				<input type="hidden" name="tb_url" value="<c:out value="${tb_url }"/>" />
				<label for="tb_id">id</label>
				<input class="form-control" type="text" id="tb_id" name="tb_id" value="<c:out value="${empty dto.tb_id ? res.user_id : dto.tb_id }"/>" readonly />
			</div>
			<div>
				<label for="tb_cat">분류</label>
				<select class="form-control" name="tb_cat" id="tb_cat" <c:if test="${not empty tb_cat}"> readonly onFocus="this.initialSelect = this.selectedIndex;" onChange="this.selectedIndex = this.initialSelect;"</c:if>>
					<c:if test="${sessionScope.res.user_auth eq '3' }">
						<option value="1" <c:if test="${tb_cat eq '1'}">selected </c:if> >공지</option>
					</c:if>
					<option value="2" <c:if test="${tb_cat eq '2'}">selected </c:if> >문의</option>
					<option value="3" <c:if test="${tb_cat eq '3'}">selected </c:if> >자유</option>
				</select>
			</div>
			<div>
				<label for="tb_region">지역</label>
				<select class="form-control" name="tb_region" id="tb_region">
					<option value="" >선택</option>
					<option value="0001" <c:if test="${not empty dto.tb_region and dto.tb_region eq '0001'}">selected</c:if> >서울</option>
					<option value="0002" <c:if test="${not empty dto.tb_region and dto.tb_region eq '0002'}">selected</c:if> >경기</option>
					<option value="0003" <c:if test="${not empty dto.tb_region and dto.tb_region eq '0003'}">selected</c:if> >강원</option>
					<option value="0004" <c:if test="${not empty dto.tb_region and dto.tb_region eq '0004'}">selected</c:if> >충청</option>
					<option value="0005" <c:if test="${not empty dto.tb_region and dto.tb_region eq '0005'}">selected</c:if> >전라</option>
					<option value="0006" <c:if test="${not empty dto.tb_region and dto.tb_region eq '0006'}">selected</c:if> >경상</option>
					<option value="0007" <c:if test="${not empty dto.tb_region and dto.tb_region eq '0007'}">selected</c:if> >제주</option>
				</select>		
			</div>
			<div>
				<label for="tb_title">제목</label>
				<input class="form-control" type="text" id="tb_title" name="tb_title" value="<c:out value="${ dto.tb_title}"/>" placeholder="제목 입력하세요." />
			</div>
			<div>
				<label>내용</label>
				<textarea name="tb_content" id="tb_content" class="form-control" rows="10"><c:out value="${ dto.tb_content}"/></textarea>
			</div>
		</form>
	   <div class="mb-3" style="text-align:center;">
			<input type="button" class="btn btn-primary" value="<c:out value="${dto.tb_no ne '0' ? '수정' : '등록' }"/>" id="btnIs">&nbsp;&nbsp;
			<input type="button" class="btn btn-primary" value="목록" onclick="javascript:history.back();">
	    </div>
    </div>
</div>
</body>
</html>








