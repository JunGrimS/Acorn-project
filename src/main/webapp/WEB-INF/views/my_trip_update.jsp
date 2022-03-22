<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 수정</title>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap" rel="stylesheet">
<style>
	*{
		font-family: 'Noto Sans KR', sans-serif;
	}
</style>

<!-- 플러그인에서 제공해주는 css 로딩 -->
<link rel="stylesheet" type="text/css" href="./resources/css/jquery.datetimepicker.min.css">
<!-- jquery 로딩 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 플러그인 javascript 로딩 -->
<link rel="stylesheet" type="text/css" href="./resources/js/jquery.datetimepicker.full.min.js">
	
<!-- bootstrap css 로딩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- bootstrap javascript 로딩 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<!-- Uploadcare -->
<script>
	UPLOADCARE_PUBLIC_KEY = '2396dee3859187cd5756';
</script>
<script
	src="https://ucarecdn.com/libs/widget/3.x/uploadcare.full.min.js"></script>
	
<script type="text/javascript">

//여행장소 추가하기
function showPopup(){
	window.open("${pageContext.request.contextPath}/content/list/temp?region=all",
			"팝업창", "width=400,height=800,top=100,left=100");
	//관광지를 선택할 수 있는 창을 열면 지도버튼 활성화
	$("#mapModalBtn").removeAttr("disabled");
}

//수정하기
function update(){
	if(confirm("수정하시겠습니까?")){
		if(upfrm.ti_trip_name.value === "" || upfrm.ti_visit_date.value === ""){
			alert("입력하지 않은 항목이 있습니다.");
			return;
		}else{
			upfrm.submit();				
		}
	}else{
		return;
	}		
}

//수정 취소
function cancel(){
	if(confirm("취소할까요?")){
		location.href='my_trip_detail?ti_id=${data.ti_id}';
	}else{
		return;
	}
}

//팝업창 리스트 한줄 삭제
function deleteCheck(ths) {
	if(confirm("정말 삭제하시겠습니까?")){
		var $tr = $(ths).parents("tr");
		$tr.remove();
		delfrm.submit();
	}else{
		return;
	}
}

//여행지 한곳 수정
$(document).ready(function() {
	$("#detailBtn").on("click", function() {

		if (confirm("수정하시겠습니까?")) {
			$.ajax({
				data : decodeURIComponent($("#frm2").serialize()),
				type : "post",
				url : "updateDetail",
				success : function(datas) {
					alert("수정되었습니다.");
				},
				error : function() {
					alert("수정에 실패했습니다.")
				}
			});
		}
		document.getElementById("ti_content").value='';
		document.getElementById("uploadcare-uploader").value='';
	});
});

//모달 버튼
function modalBtn(loc_id) {
	console.log(loc_id);
	$("#modal_loc_id").val(loc_id);
}
</script>

</head>
<body>
<div class="container justify-content-start ms-6 me-6">
	<div class="col-4 fw-bold mt-5">
		<h2>나의 여행 수정</h2>
	</div>
	<table class="table table-stripted">
		<tr>
			<td style="text-align: right">
				<input class="btn btn-primary" type="button" value="수정" onclick="update()"> 
				<input class="btn btn-warning" type="button" value="취소" onclick="cancel()">
				<input class="btn float-right btn-dark" type="button" value="여행 장소 추가하기" onclick="showPopup()">
			</td>
		</tr>
	</table>

	<!-- 글 수정 폼 -->
	<form action="my_trip_update" method="post" name="upfrm">
		<input type="hidden" name="ti_id" value="${data.ti_id }">
		<table  class="table table-stripted">	
			<tr>
				<td>
					<div class="form-group col-md-6">
					<label class="mr-sm-2" for="ti_visit_date">방문날짜</label> <input
						id="inputDate" type="date" name="ti_visit_date" value="${data.ti_visit_date.substring(0,10) }" />
						<!-- <script>$("#inputDate").datetimepicker();</script> -->
					</div>
				</td>
			</tr>
			<tr>
				<div class="form-group col-md-6">
					<label for="title">나의 여행 이름</label>
					<input type="text" class="form-control" id="title" name="ti_trip_name" value="${data.ti_trip_name }">
				</div>
			</tr>
		</table>
	</form>



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
						<th>수정하기</th>
						<th>삭제하기</th>
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
						<td><button name="modalBtn" type="button" class="btn btn-primary"
											data-bs-toggle="modal" data-bs-target="#exampleModal">
											수정</button>
						</td>
						<td>
							<form action="delete_detail" method="post" name="delfrm">
							<input class="btn btn-warning" type="button" value="삭제" onclick="deleteCheck()">
							<input type="hidden" name="ti_id" value="${data.ti_id }">
							</form>
						</td>
					</tr>
					</c:forEach>
					
					
				</tbody>
			</table>
		</div>


		<!-- 수정폼에서 신규 추가 -->
		<input type="hidden" name="cnt" value="0" />
		<div class="table-responsive mt-2">
			<table style="display: none;" class="table table-striped table-bordered text-center tbl_List">
				<tbody id="resTr">
					<tr>
						<!-- hidden: loc_id -->
						<!-- <td name="no">1</td> -->
						<td name="loc_name">원조할아버지보쌈</td>
						<td name="loc_region">서울</td>
						<td name="loc_addr">서울 영등포구 여의도동 12</td>
						<td name="loc_tel">02-1523-1253</td>
						<td name="loc_worktime">10:00 ~ 22:00</td>
						<td hidden name="loc_id"></td>
						<td class="lat" name="loc_lat" style="display: none"></td>
						<td class="long" name="loc_long" style="display: none"></td>
						<th name="moreInfo">
							<button name="modalBtn" type="button" class="btn btn-primary"
								data-bs-toggle="modal" data-bs-target="#exampleModal">
								추가</button>
						</th>
						<td name="cancel"><a href="javascript:void(0);"
							onclick="trRemove(this);" class="btn btn-warning">삭제 </a></td>
					</tr>
				</tbody>
			</table>
		</div>




	</div>

	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">추가창</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<form name="frm2" id="frm2" class="form-inline">
							<label for="ti_content">여행 내용</label>
							<div style="width:100%; word-break:break-all;word-wrap:break-word;">
							<input type="hidden" name="loc_id" id="modal_loc_id" value="" />
							<textarea class="form-control" id="ti_content" name="ti_content" rows="5"></textarea>
							</div><br>
							<label for="image">이미지 첨부</label> <input type="hidden"
								role="uploadcare-uploader" name="ti_pic_url" id="ti_pic_url" /> <br>
								<div>
								<input type="hidden" name="ti_id" value="${data.ti_id }">
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" id="detailBtn" class="btn btn-primary"
						data-bs-dismiss="modal">Save changes</button>
				</div>
			</div>
		</div>
	</div>

</div>
</body>

<script>
	//role의 값이 uploadcare-uploader인 태그를 업로드 위젯으로 생성
	var singleWidget = uploadcare.SingleWidget("[role=uploadcare-uploader]");
</script>

</html>