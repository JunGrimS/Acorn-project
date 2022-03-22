<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<script src="https://ucarecdn.com/libs/widget/3.x/uploadcare.min.js"></script>
<script>
	UPLOADCARE_LOCALE = "ko"
	UPLOADCARE_PUBLIC_KEY = "e259833894a4c3479463"
	UPLOADCARE_TABS = "file camera url facebook gdrive gphotos"
</script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=05ccb792673fe247abd6d6734603e6dc&libraries=services">
</script>

</head>
<style>
.input-form {
	max-width: 680px;
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
.final_id_ck{
    display: none;
}
.final_pwd_ck{
    display: none;
}
.final_pwdck_ck{
    display: none;
}
.final_name_ck{
    display: none;
}
.final_tel_ck{
    display: none;
}
.final_mail_ck{
    display: none;
}
.final_birth_ck{
    display: none;
}

/* 비밀번호 확인 일치 유효성검사 */
.pwck_input_re_1{
        color : green;
        display : none;    
}
.pwck_input_re_2{
        color : red;
        display : none;    
}

</style>
<body>
<script type="text/javascript">



</script>

	<!-- locDto locPh update폼도 같이 해보자  -->


	<div class="container">
		<div class="input-form-background row">
			<div class="input-form col-md-12 mx-auto">
			<c:if test="${function eq 'insert' }">
				<p>지역 추가 폼</p>
			</c:if>
			<c:if test="${function eq 'update' }">
				<p>지역 업데이트 폼</p>
			</c:if>
				<div>
					<c:if test="${function eq 'insert' }">
						<form id="insertForm" action="insert" method="post">
					</c:if>
					<c:if test="${function eq 'update' }">
						<form id="insertForm" action="${pageContext.request.contextPath}/content/updateDetail" method="post">
					</c:if>
					<c:if test="${function eq 'update' }">
						<label class="form-label" for="id_disabled">loc_id</label>
						<input class="form-control" disabled id="id_disabled" type="" name="id_disabled" value="${locDto.loc_id }" />
						<input class="form-control" id="id" type="hidden" name="loc_id" value="${locDto.loc_id }" />
					</c:if>
					<!-- <form id="insertForm" action="insert" method="post"> -->
		
					<!-- 추후 추가  1차로 만들고 세부 사항 입력
				<div>
					<label class="form-label" for="id">등록 번호</label>
					<select name="loc_id" id="id" disabled="disabled" value=></select>
				</div>
				-->
					<div>
						<label class="form-label" for="name">이름</label> <input
							class="form-control nn" id="name" type="text" name="loc_name"
							value="${locDto.loc_name }" />
						<div class="invalid-feedback">한글자 이상!!</div>
					</div>
					<div>
						<label class="form-label" for="regionSelect">지역</label> <select
							id="regionSelect" class="form-select" name="loc_region">
							<option id="reg_opt" selected>시/도</option>
							<c:forEach items="${regionList }" var="region">
								<option value="${region }">${region }</option>
							</c:forEach>
						</select>
						<div class="invalid-feedback">지역을 선택해 주세요</div>
					</div>
					<div>
						<!-- 아작스로 해야될듯... 해결함 -->
						<label class="form-label" for="citySelect">지역</label> <select
							id="citySelect" class="form-select" name="loc_city">
							<option selected disabled>시/군/구</option>
						</select>
						<div class="invalid-feedback">지역을 선택해 주세요</div>
					</div>
					<div>
						<label class="form-label " for="addr">주소</label>
						<c:if test="${function eq 'insert' }">
							<input class="form-control nn mb-1" id="addr" type="text"
								name="loc_addr" />
						</c:if>
						<c:if test="${function eq 'update' }">
							<input class="form-control nn mb-1" id="addr" type="text"
								name="loc_addr" value="${locDto.loc_addr }" />
						</c:if>
						<!-- 좌표 검색 버튼 -->
						<div>
							<button type="button" class="btn btn-secondary mt-1" id="locSearchBtn">좌표 검색</button>
							<button id="mapModalBtn" disabled="disabled" type="button" class="btn btn-success mt-1 ms-2 " data-bs-toggle="modal" data-bs-target="#mapModal" disabled >결과 지도 열기</button>
						</div>
						<label class="form-label mt-1" for="locSearchBtn" id="searchResult"></p>
						
						<div class="invalid-feedback">한글자 이상!!</div>
					</div>
					<div>
						<label class="form-label" for="cat">분류</label>
						<c:if test="${function eq 'insert' }">
							<input class="form-control nn" id="cat" type="text" name="loc_cat" />
						</c:if>
						<c:if test="${function eq 'update' }">
							<input class="form-control nn" id="cat" type="text" name="loc_cat"
								value="${locDto.loc_cat }" />
						</c:if>
						<div class="invalid-feedback">한글자 이상!!</div>
					</div>
					<div>
						<label class="form-label" for="desc">상세설명</label>
						<c:if test="${function eq 'insert' }">
							<textarea class="form-control" style="height: 100px" name="loc_desc" id="desc"></textarea>							
						</c:if>
						<c:if test="${function eq 'update' }">
							<textarea class="form-control" style="height: 100px" name="loc_desc" id="desc">${locDto.loc_desc }</textarea>
						</c:if>
						<label for="url">상세정보를 적어주세요.</label>
					</div>
		
					<hr />
					<!-- 아래 부분은 빈칸 전송 가능 + 이 부분만 따로 수정  페이지 만들기  -->
					<div>
						<label class="form-label" for="tel">전화번호</label>
						<c:if test="${function eq 'insert' }">
							<input class="form-control" id="tel" type="text" name="loc_tel" />
						</c:if>
						<c:if test="${function eq 'update' }">
							<input class="form-control" id="tel" type="text" name="loc_tel"
								value="${locDto.loc_tel }" />
						</c:if>
					</div>
					<div>
						<label class="form-label" for="worktime">운영시간</label>
						<c:if test="${function eq 'insert' }">
							<input class="form-control" id="worktime" type="text"
								name="loc_worktime" />
						</c:if>
						<c:if test="${function eq 'update' }">
							<input class="form-control" id="worktime" type="text"
								name="loc_worktime" value="${locDto.loc_worktime }" />
						</c:if>
					</div>
					<div>
						<label class="form-label" for="nonwork">휴무</label>
						<c:if test="${function eq 'insert' }">
							<input class="form-control" id="nonwork" type="text"
								name="loc_nonwork" />
						</c:if>
						<c:if test="${function eq 'update' }">
							<input class="form-control" id="nonwork" type="text"
								name="loc_nonwork" value="${locDto.loc_nonwork }" />
						</c:if>
					</div>
					<div>
						<label class="form-label" for="parking">주차장</label>
						<c:if test="${function eq 'insert' }">
							<input class="form-control" id="parking" type="text"
								name="loc_parking" />
						</c:if>
						<c:if test="${function eq 'update' }">
							<input class="form-control" id="parking" type="text"
								name="loc_parking" value="${locDto.loc_cat }" />
						</c:if>
					</div>
					<br />
					<div>
						<label class="form-label" style="display: none" for="lat1">위도</label>
						<input class="form-control lat" disabled id="lat1" type="text"
							name="loc_lat" />
					</div>
					<div>
						<label class="form-label" for="lat2">위도</label> <input
							class="form-control lat" id="lat2" type="hidden" name="loc_lat" />
					</div>
					<div>
						<label class="form-label" style="display: none" for="long1">경도</label>
						<input class="form-control long" disabled id="long1" type="text"
							name="loc_long" />
					</div>
					<div>
						<label class="form-label" for="long">경도</label> <input
							class="form-control long" id="long2" type="hidden" name="loc_long" />
					</div>
					<!-- url이 "," 로 나누어져 있는 String 집어넣는곳 hidden -->
					<div class="form-floating">
						<c:if test="${function eq 'insert' }">
							<textarea class="form-control" style="display: none;" name="loc_ph_url" id="url" style="height: 100px"></textarea>
						</c:if>
						<c:if test="${function eq 'update' }">
							<label class="form-label" for="url">사진 url들 (띄어쓰기 없이',' 로
								나눠주세요)</label>
							<textarea name="loc_ph_url" id="url" style="height: 100px"><c:forEach items="${locPh }" var="ph" varStatus="status"><c:choose><c:when test="${status.index eq 0 }"><c:out value="${ph.loc_ph_url }" /></c:when><c:otherwise>,<c:out value="${ph.loc_ph_url }" /></c:otherwise></c:choose>	</c:forEach></textarea>
						</c:if>
					</div>
					<input type="hidden" role="uploadcare-uploader"
						data-image-shrink="1024x1024" data-multiple="true" />
					<c:if test="${function eq 'insert' }">
						<button class="btn btn-primary" id="submitBtn" type="submit"
							disabled>추가</button>
					</c:if>
					<c:if test="${function eq 'update' }">
						<button class="btn btn-primary" id="submitBtn" type="submit"
							disabled>변경</button>
					</c:if>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 지도 모달  -->
	<div class="modal fade" id="mapModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">좌표 검색 결과</h5>
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
</body>
<script>

//로딩후 버튼 비활성화
$(document).on("ready",function(){
	
	$("#mapModalBtn").attr("disabled","disabled");
	
});




//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

$("#locSearchBtn").on("click",function(){
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch($("#addr").val(), function(result, status) {
		$("#searchResult").text("");
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	    	 $("#searchResult").text("검색 성공");
	        let lat=result[0].y;
	        let long=result[0].x;
	        $(".lat").val(lat);
	        $(".long").val(long);
	        $("#mapModalBtn").removeAttr("disabled");
	     }else{
	    	 $("#searchResult").text("검색 실패");
	    	 $("#mapModalBtn").attr("disabled","disabled");
	     }
	});
});




	let widget = uploadcare
			.MultipleWidget('[role=uploadcare-uploader]');
	//url이 들어갈 배열을 만들고
	//let urlArr=[];
	//let urlStringArr=[];
	
	//그냥 간단한 배열이기 때문에 string형태로 가져오자
	let urlStr="";
	
	// listen to the "change" event
	widget.onChange(function (group) {
		
		// 혹시 모르니 한번더 urlArr 초기화 시켜주고
		//urlArr=[];
		//urlStringArr=[];
		urlStr="";
	  
		// get a list of file instances
	  group.files().forEach(file => {
	    // once each file is uploaded, get its CDN URL from the fileInfo object
	    file.done(fileInfo => {
	      //urlArr.push(fileInfo.cdnUrl);
	      //$("#url").val($("#url").val()+fileInfo.cdnUrl);
	      if(urlStr==""){
	    	  urlStr=fileInfo.cdnUrl;
	      }else{
	    	  urlStr= urlStr+","+fileInfo.cdnUrl;  
	      }
	      //만들어진 url String을 hidden인 text area에 입력
	      $("#url").val(urlStr);
	      
	    });
	  });
	  //urlStringArr=JSON.stringify(urlArr);
	  console.log(urlStr)
	});

	//validity test 
	let reg = /.+/ // 무조건 한글자 이상 테스트
	$(".nn").on("input", function() {
		//처음엔 다 지워주고
		$(this).removeClass("is-invalid is-valid");
		//무조건 한글자 이상 조건과 띄어쓰기만 있는경우 걸러내기
		if ($(this).val().trim() != '' && reg.test($(this).val())) {
			$(this).addClass("is-valid");
			$("#submitBtn").removeAttr('disabled'); // 나중에 고치자
		} else {
			$(this).addClass("is-invalid");
			$("#submitBtn").attr('disabled', 'disabled');
		}

	});

	$("#submitBtn").on("mouseup", function() {

		$(".nn").each(function(index, item) {
			//한번은 다 지워주고
			$(".nn").removeClass("is-invalid is-valid");
			//하나씩 each로 돌려가며 빈칸 확인
			$(".nn").each(function(index, item) {
				// 위와 같은 조건 확인 해주고
				if ($(this).val().trim() != '' && reg.test($(this).val())) {
					//성공시
					$(this).addClass("is-valid");
				} else {//실패시
					$(this).addClass("is-invalid");
					$("#submitBtn").attr('disabled', 'disabled');
				}
			});
		});
	});
	
	$("#citySelect").change(function() {
		//console.log($(this).val());
		let data = "loc_region=" + $(this).val();
		//console.log(data);
		// JSON넣을 객체
		$("#addr").val($("#addr").val()+" "+$(this).val())
	});
	
	let jsonData = null;
	$("#regionSelect").change(function() {
		//console.log($(this).val());
		let data = "loc_region=" + $(this).val();
		//console.log(data);
		// JSON넣을 객체
		$("#addr").val($("#addr").val()+" "+$(this).val())

		$.ajax({
			url : "${pageContext.request.contextPath}/content/city_list",
			data : data,
			type : "get",
			success : function(datas) {
				//console.log(datas);
				jsonData = datas
				$("#reg_opt").attr("disabled", "disabled")
				$("#citySelect").empty();

				for (var count = 0; count < datas.length; count++) {
					var option = $("<option>" + datas[count] + "</option>");
					$('#citySelect').append(option);
				}

			},
			error : function() {
				console.log("error");
			}
		});

	});
	
	

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
		
	let lat="";
	let long="";
	
		$("#mapModalBtn").on("click",function(){
			
			let lat=$("#lat2").val()
			let long=$("#long2").val()
			
			var mapContainer=mapContainer = document.getElementById('map'), // 지도를 표시할 div  
			mapOption = { 
			    center: new kakao.maps.LatLng(lat, long), // 지도의 중심좌표
			    level: 5 // 지도의 확대 레벨
			};
			
			map = new kakao.maps.Map(mapContainer, mapOption);
			
			//마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
			var positions = [];
			
			for (var i = 0; i < 1; i++) {
				let position=
				{
				    content: '<div>'+$("#name").val()+'</div><div>주소와 이름 확인</div>', 
				    latlng: new kakao.maps.LatLng(lat, long)
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
			
			moveLatLon = new kakao.maps.LatLng(lat, long);
			map.setCenter(moveLatLon);
			
			//setTimeout(function(){ map.relayout(); }, 500);
			
			//setTimeout(function(){ setCenter(latMid ,longMid); }, 500);
			
			let relaySuccess= timedRelay(500);
			
			setCenter(lat,long);
			
			setTimeout(function(){ setCenter(lat,long); }, 550);
		  
		});
		
		function setCenter(lat,long) {            
		    // 이동할 위도 경도 위치를 생성합니다 
		    moveLatLon = new kakao.maps.LatLng(lat, long);
		    
		    // 지도 중심을 이동 시킵니다
		    map.setCenter(moveLatLon);
		    console.log("성공");
		}
		
		function timedRelay(time){
			
			setTimeout(function(){ map.relayout(); }, time);
			setCenter(lat,long);
			return true;
		}
		
		
		//관광지를 선택할 수 있는 창을 열면 지도버튼 활성화
		$("#mapModalBtn").removeAttr("disabled");


		

</script>
</html>