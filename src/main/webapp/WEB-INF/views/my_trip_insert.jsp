<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/header.jsp" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 여행 추가 페이지</title>
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
<link rel="stylesheet" type="text/css"
	href="./resources/css/jquery.datetimepicker.min.css">
<!-- jquery 로딩 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 플러그인 javascript 로딩 -->
<link rel="stylesheet" type="text/css"
	href="./resources/js/jquery.datetimepicker.full.min.js">

<!-- bootstrap css 로딩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<!-- bootstrap javascript 로딩 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>

<!-- Uploadcare -->
<script>
	UPLOADCARE_PUBLIC_KEY = '2396dee3859187cd5756';
</script>
<script
	src="https://ucarecdn.com/libs/widget/3.x/uploadcare.full.min.js"></script>
</head>

<script type="text/javascript">
//부팅시 팝업창에서 항목을 선택해주세요. 메시지 표시
$(function() {
	$("#resTb tbody").append($("#resInfoTr").html());

 	if ($("#resTb tbody").length != 0) {
 		$("#noRes").append("");
		//$("#noRes").append("<td colspan='8'>팝업창에서 항목을 선택해주세요.</td>");
	}
});

//글 등록
window.onload = function() {
	let btnIns = document.querySelector("#btnMyTripInsert");
	btnIns.addEventListener("click", checkData);
}
function checkData() {
	if (frm.ti_trip_name.value === "" || frm.ti_visit_date.value === "") {
		alert("입력하지 않은 항목이 있습니다."); 
		return;
	}

	if (confirm("등록하시겠습니까?")) {
		frm.submit();
	}

	frm.submit();
}

//목록으로 돌아가기
function backCheck() {
	if (confirm("작성을 취소하고 목록으로 돌아가시겠습니까?") == true) {
		location.href = 'my_trip_list';
	} else {
		return;
	}
}

//팝업창에서 추가한 리스트 한줄 삭제
function trRemove(ths) {
	var $tr = $(ths).parents("tr");
	$tr.remove();
}

//팝업 띄우는 함수 
function showPopup() {
	window.open("${pageContext.request.contextPath}/content/list/temp?region=all",
				"팝업창", "width=400,height=800,top=100,left=100");
	
	//관광지를 선택할 수 있는 창을 열면 지도버튼 활성화
	$("#mapModalBtn").removeAttr("disabled");

}
</script>

<script type="text/javascript">
	$(document).ready(function() {
		$("#detailBtn").on("click", function() {

			if (confirm("등록하시겠습니까?")) {
				$.ajax({
					data : decodeURIComponent($("#frm2").serialize()),
					type : "post",
					url : "insertDetail",
					success : function(datas) {
						alert("등록되었습니다.");
					},
					error : function() {
						alert("등록에 실패했습니다.")
					}
				});
			}
			document.getElementById("ti_content").value='';
			document.getElementById("uploadcare-uploader").value='';
		});
	});

	function modalBtn(loc_id) {
		console.log(loc_id);
		$("#modal_loc_id").val(loc_id);
	}
	
/* 순서 변경 */
function moveUp(el){
	var $tr = $(el).parent().parent(); // 클릭한 버튼이 속한 tr 요소
	$tr.prev().before($tr); // 현재 tr 의 이전 tr 앞에 선택한 tr 넣기
}

function moveDown(el){
	var $tr = $(el).parent().parent(); // 클릭한 버튼이 속한 tr 요소
	$tr.next().after($tr); // 현재 tr 의 다음 tr 뒤에 선택한 tr 넣기
}
</script>

<body>
<div class="container justify-content-start ms-6 me-6">
	<div class="col-4 fw-bold mt-5">
		<h2>나의 여행 추가</h2>
	</div>
	<div class="d-flex justify-content-end mr-3">
		<a href="javascript:void(0);" onclick="showPopup();"
			class="btn float-right btn-dark">여행 장소 등록하기</a>&nbsp;&nbsp;
		<button id="mapModalBtn" type="button" class="btn float-right btn-primary"
			data-bs-toggle="modal" data-bs-target="#mapModal" disabled >결과 지도 열기</button>
	</div>
	<div class="fs-4 mt-3">
		<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
			fill="currentColor" class="bi bi-arrow-right-circle-fill"
			viewBox="0 0 16 16">
	  		<path d="M8 0a8 8 0 1 1 0 16A8 8 0 0 1 8 0zM4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z" />
		</svg> 다녀온 여행지
	</div>

	<!-- 다녀온 여행지 테이블 -->
	<div id="contAreaBox">
		<div class="table-responsive mt-2">
			<table id="resTb" class="table table-striped table-bordered text-center tbl_List">
				<thead>
					<tr>
						<!-- <th>번호</th> -->
						<th>장소명</th>
						<th>지역</th>
						<th>주소</th>
						<th>전화번호</th>
						<th>운영시간</th>
						<th>사진/캡션 추가하기</th>
						<th>삭제하기</th>
						<th>순서변경</th>
					</tr>
				</thead>
				<tbody>
					<!-- 팝업리스트에서 추가  -->
				</tbody>
			</table>
		</div>

		<!-- 팝업창에서 선택한 항목들 리스트에 추가 -->
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
						<td><button type="button" onclick="moveUp(this)">▲</button>
							<button type="button" onclick="moveDown(this)">▼</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 항목이 없을 때 팝업창 클릭 유도 메시지 출력 -->
		<div class="table-responsive">
			<table style="display: none;" class="table table-striped table-bordered text-center tbl_List">
				<tbody id="resInfoTr">
					<tr id="noRes">
						<td colspan="8">팝업창에서 항목을 선택해주세요.</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<br>

	<!-- 방문날짜, 여행 이름 입력 -->
	<form action="insert" method="post" name="frm" class="form-inline">
		<table class="table table-stripted">
			<tr>
				<th style="text-align: center">
					<div class="form-group col-md-4">
						<label class="mr-sm-2" for="ti_visit_date">방문날짜 </label>
						<input id="inputDate" type="date" name="ti_visit_date" />
						<script>
							$("#inputDate").datetimepicker();
						</script>
					</div>
				</th>
				<th>
					<div class="form-group col-md-6">
						<label for="title">나의 여행 이름</label>&nbsp;
						<input type="text" class="form-control" id="title" name="ti_trip_name"
							placeholder="나의 여행 이름">
					</div>
					<br>
				</th>
			</tr>
			<tr>	
				<td colspan="2" style="text-align: right">
					<input class="btn float-center btn-secondary" type="button" value="목록으로 돌아가기" onclick="backCheck()">&nbsp;&nbsp;
					<input class="btn float-center btn-primary" type="button" value="등록" id="btnMyTripInsert">
				</td>
			</tr>
		</table>
	</form>

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
							<label for="ti_content">여행 내용</label> <br> 
							<div style="width:100%; word-break:break-all;word-wrap:break-word;">
							<input type="hidden" name="loc_id" id="modal_loc_id" value="" />
							<textarea class="form-control" id="ti_content" name="ti_content"rows="5"></textarea>
							</div><br>
							<label for="image">이미지 첨부</label>
							<div>
							<input type="hidden"
								role="uploadcare-uploader" name="ti_pic_url" id="ti_pic_url" /> <br>
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

	<div class="modal fade" id="mapModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row container ms-1 me-1" id="map"
						style="width: auto; height: 340px;"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
</body>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=05ccb792673fe247abd6d6734603e6dc"></script>
<script>
	//role의 값이 uploadcare-uploader인 태그를 업로드 위젯으로 생성
	var singleWidget = uploadcare.SingleWidget("[role=uploadcare-uploader]");
	//그 위젯을 통해 업로드가 끝났을 때
	//	singleWidget.onUploadComplete(function(info){
	//id가 content인 태그의 값 뒤에 업로드한 이미지 파일의 주소를 이미지 태그와 함께 첨부
	//		document.getElementById("content").value = document.getElementById("content").value + '<img src="' + info.cdnUrl + '">';
	//	});
/*	
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
mapOption = { 
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 6 // 지도의 확대 레벨
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
*/

//인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
return function() {
    infowindow.open(map, marker);
};
}

//인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
return function() {
    infowindow.close();
};
}
	
$("#mapModalBtn").on("mouseover",function(){
	
	latArr=[];
	longArr=[];
	
	//lat
	$(document).find("#resTb tbody tr").find("td[name='loc_lat']").each(function(idx){
		latArr.push($(this).text());
	
	});
	y1=Math.min(...latArr);
	y2=Math.max(...latArr);
	
	
	
	//long
	$(document).find("#resTb tbody tr").find("td[name='loc_long']").each(function(idx){
		longArr.push($(this).text());
		
	});
	x1=Math.min(...longArr);
	x2=Math.max(...longArr);
	
	latMid= y1 + ((y2 - y1) / 2);
	longMid= x1 + ((x2 - x1) / 2);
	
	
});
	
	
	let nameArr = [];
	let latArr = [];
	let longArr =[];
	let latMid="";
	let longMid="";
	let y1 ="";
	let y2 ="";
	let x1 ="";
	let x2 ="";
	
	var moveLatLon = "";
	
	
	/*
	x1 : 다각형의 x 좌표 중 가장 작은 값 (long)
	y1 : 다각형의 y 좌표 중 가장 작은 값 (lat)
	x2 : 다각형의 x 좌표 중 가장 큰 값
	y2 : 다각형의 y 좌표 중 가장 큰 값
	center.x = x1 + ((x2 - x1) / 2);
	center.y = y1 + ((y2 - y1) / 2);
	*/
	
	$("#mapModalBtn").on("click",function(){
		/*
		latArr=[];
		longArr=[];
		
		//lat
		$(document).find("#resTb tbody tr").find("td[name='loc_lat']").each(function(idx){
			latArr.push($(this).text());
		
		});
		y1=Math.min(...latArr);
		y2=Math.max(...latArr);
		
		
		
		long
		$(document).find("#resTb tbody tr").find("td[name='loc_long']").each(function(idx){
			longArr.push($(this).text());
			
		});
		x1=Math.min(...longArr);
		x2=Math.max(...longArr);
		
		latMid= y1 + ((y2 - y1) / 2);
		longMid= x1 + ((x2 - x1) / 2);
		
		*/
		
		//이름
		$(document).find("#resTb tbody tr").find("td[name='loc_name']").each(function(idx){
			nameArr.push($(this).text());
			
		});
		
		var mapContainer=mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		mapOption = { 
		    center: new kakao.maps.LatLng(latMid, longMid), // 지도의 중심좌표
		    level: 12 // 지도의 확대 레벨
		};
		
		map = new kakao.maps.Map(mapContainer, mapOption);
		
		//마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
		var positions = [];
		
		for (var i = 0; i < nameArr.length; i++) {
			let position=
			{
			    content: '<div>'+nameArr[i]+'</div>', 
			    latlng: new kakao.maps.LatLng(latArr[i], longArr[i])
			};
			//test
			console.log(position);
			positions.push(position);
		}
		
		
		
		
		for (var i = 0; i < positions.length; i ++) {
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    map: map, // 마커를 표시할 지도
		    position: positions[i].latlng // 마커의 위치
		});

		// 마커에 표시할 인포윈도우를 생성합니다 
		var infowindow = new kakao.maps.InfoWindow({
		    content: positions[i].content // 인포윈도우에 표시할 내용
		});

		// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
		// 이벤트 리스너로는 클로저를 만들어 등록합니다 
		// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
		kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
		kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
		}
		
		moveLatLon = new kakao.maps.LatLng(latMid, longMid);
		map.setCenter(moveLatLon);
		
		//setTimeout(function(){ map.relayout(); }, 500);
		
		//setTimeout(function(){ setCenter(latMid ,longMid); }, 500);
		
		let relaySuccess= timedRelay(500);
		
		setCenter(latMid,longMid);
		
		setTimeout(function(){ setCenter(latMid,longMid); }, 550);
	  
	});
	
	function setCenter(latMid,longMid) {            
	    // 이동할 위도 경도 위치를 생성합니다 
	    moveLatLon = new kakao.maps.LatLng(latMid, longMid);
	    
	    // 지도 중심을 이동 시킵니다
	    map.setCenter(moveLatLon);
	    console.log("성공");
	}
	
	function timedRelay(time){
		
		setTimeout(function(){ map.relayout(); }, time);
		setCenter(latMid,longMid);
		return true;
	}

</script>

</html>