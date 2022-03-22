<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/header.jsp" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상세정보</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=05ccb792673fe247abd6d6734603e6dc"></script>
<style>
.fotorama__wrap {
	margin: 0 auto;
}
</style>
</head>
<body>
	<%-- detail controller에서 locDto로 받아옴 --%>
	<div class="container mt-5">
		<div class="row text-center">
			<h1>${locDto.loc_name }</h1>
			<h5>${locDto.loc_region }${locDto.loc_city }</h5>
		</div>
		<!-- 버튼 넣을거 생각하고 수정,삭제 mapping (관리자만 볼 수 있게) jstl if 사용 -->
		<c:if test="${not empty res }">
		<c:if test="${res.user_auth eq 3 }">
			<div class="d-flex flex-row-reverse mt-3">
			<div class="p-2">
				<!-- javascript로 클릭된 버튼에 따라 다른 링크 submit -->
				<form action="#" id=editForm method="post">
					<input type="hidden" id="loc_id_hidden" name="loc_id"
						value="${locDto.loc_id }" />
					<%--관리자 권한  --%>
					<input type="hidden" id="loc_id_hidden" name="user_auth"
						value="${user_auth }" />
					<button type="button" id="updateBtn"
						class="editBtn btn btn-primary " onclick="getPost('updateForm')">수정</button>
					<button type="button" id="deleteBtn"
						class="editBtn btn btn-primary " onclick="getPost('deleteDetail')">삭제</button>
				</form>
			</div>
		</div>
		</c:if>
	</c:if>
		<hr />
		<div class="container-fluid row align-items-center mt-3">
			<div class="col">
				<!-- 주소를 받을 셋팅을 해야됨 -->
				<div class="fotorama">
					<%-- 사진 자료가 있다면 --%>
					<c:if test="${not empty locPh }">
						<c:forEach items="${locPh }" var="p">
							<img src="${p.loc_ph_url }"/>
						</c:forEach>
					</c:if>
					<c:if test="${empty locPh }">
					
					<img
						src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=2294088c-dd0e-4c37-88e7-9ff70c3c29a6">
					<img
						src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=ee65154d-e426-4f6f-8bf0-f838f3736c97">	
					<img
						src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=ff7905c5-5b6b-48c1-9d00-4a280a877e19">
					</c:if>
				</div>
			</div>
		</div>
		<!-- 상세정보 -->
		<div class="row mt-1">
			<h4>상세정보</h4>
		</div>
		<hr />
		<div class="row mt-1">
			<p>${locDto.loc_desc }</p>
		</div>
		<!-- 지도  -->
		<div class="row container-fluid ms-1 me-1" id="map"
			style="width: auto; height: 300px;"></div>
		<br /> <br /> <br />
		<div>
		<iframe width="100%" height="245" src="https://forecast.io/embed/#lat=${locDto.loc_lat }&lon=${locDto.loc_long }&name=${locDto.loc_city }&color=&font=arial&units=si" frameborder="0"></iframe>
		</div>
		<div>
			댓글 또는 이 관광지가 포함된 여행(trip) <br /> <br /> <br /> <br /> <br />
		</div>















	</div>
</body>

<script>
//버튼을 누르면 action 안에 있는 주소로 attr을 바꿔 submit 한다.
function getPost(action){
	
	isConfirmed=false;
	if(action=="updateForm"){
		isConfirmed=confirm("정말 수정 하시겠습니까?");
	}else if(action=="deleteDetail"){
		isConfirmed=confirm("정말 삭제 하시겠습니까?");
	}
		
	if( isConfirmed == true){
		$("#editForm").attr('action',"${pageContext.request.contextPath}/content/"+action).submit();
	}else{
		return;
	}	
}

let coord=${locDto.loc_lat}


var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(${locDto.loc_lat}, ${locDto.loc_long}), //지도의 중심좌표.
	level: 11 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

//마커를 표시할 위치입니다 
var position =  new kakao.maps.LatLng(${locDto.loc_lat}, ${locDto.loc_long});

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
  position: position,
  clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
});

// 아래 코드는 위의 마커를 생성하는 코드에서 clickable: true 와 같이
// 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
// marker.setClickable(true);

// 마커를 지도에 표시합니다.
marker.setMap(map);

// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
var iwContent = '<div style="padding:5px;">${locDto.loc_name}</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

// 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
    content : iwContent,
    removable : iwRemoveable
});

// 마커에 클릭이벤트를 등록합니다
kakao.maps.event.addListener(marker, 'click', function() {
      // 마커 위에 인포윈도우를 표시합니다
      infowindow.open(map, marker);  
});


</script>
</html>