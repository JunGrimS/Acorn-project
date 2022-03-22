<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top" aria-label="Fifth navbar example">
    <div class="container-fluid">
		<a class="navbar-brand me-auto" href="${pageContext.request.contextPath}/index.jsp">${region } ${city eq "none"? "": city }</a>
		<button class="navbar-toggler p-2 ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample05" aria-controls="navbarsExample05" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="navbar-toggler-icon"></span>
		</button>
      	<div class="collapse navbar-collapse" id="navbarsExample05">
        	<ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <!--  
          <li class="nav-item">
            <a class="nav-link" href="#">Link</a>
          </li>
          <li class="nav-item">
            <a class="nav-link disabled">Disabled</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="dropdown05" data-bs-toggle="dropdown" aria-expanded="false">Dropdown</a>
            <ul class="dropdown-menu" aria-labelledby="dropdown05">
              <li><a class="dropdown-item" href="#">Action</a></li>
              <li><a class="dropdown-item" href="#">Another action</a></li>
              <li><a class="dropdown-item" href="#">Something else here</a></li>
            </ul>
          </li>
          -->
        </ul>
        <form action="">
        <div>
			<select id="regionSelect" class="form-select mt-3" name="region">
				<option id="reg_opt" value="all" selected>전체 (시/도)</option>
				<c:forEach items="${regions }" var="region">
				<option value="${region }">${region }</option>
				</c:forEach>
			</select>
		</div>
			<div>
				<!-- 아작스로 해야될듯... 해결함 -->
				<select	id="citySelect" class="form-select mt-2" name="city">
					<option selected disabled value="none">시/군/구</option>
				</select>
			</div>
			<div>
				<button class="btn btn-secondary mt-2" type="submit">확인</button>
			</div>
			
        </form>
        <!-- 
        <form action="list2.jsp" method="get">
          <input class="form-control" type="text" placeholder="Search" name="keyword" aria-label="Search">
        </form>
         -->
      </div>
    </div>
  </nav>
<body>
<!-- json으로 넘겨줄 자료 -->
<div class="container-fluid justify-content-start">
	<div class="ms-3 me-3 mt-3">
		<div class="row mt-4"> 
			<h4>총 ${totalNum } 건</h5>
		</div>
		<hr />
		<div class="row">
			<div>
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
					<table style="width: 100%;" class="table table-stripted">
						<tbody>
							<tr>
								<c:choose>
									<c:when test="${not empty o.loc_ph_url }">
										<th style="width: 45%; height: auto;" rowspan="4" ><img style="vertical-align; width: 100%; height: 100%;" src="${o.loc_ph_url}"/></td>
									</c:when>
									<c:when test="${empty o.loc_ph_url }">
										<th style="width: 45%; height: auto;" rowspan="4" ><img style="vertical-align; width: 100%; height: 100%;" src="${pageContext.request.contextPath}/resources/image/no-image-icon-23499.png"/></td>
									</c:when>
								</c:choose>
								<!-- 버튼 형식으로 만들고 ajax 사용해서 JSON값 받아오기 -->
								<td style="font-weight: bold; "><button class="btn btn-sm nameLink" value="${o.loc_id }">${o.loc_name }</button></td>
							</tr>
							<tr>
								<td style="font-size: small; width: 55%;">${o.loc_region } ${o.loc_city }</td>
							</tr>
							<tr>
								<td style="font-size: small; width: 55%;">전화번호: ${o.loc_tel }</td>
							</tr>
							<tr>
								<td style="font-size: small; width: 55%;">해쉬태그: #${o.loc_cat } #${o.loc_city } </td>
							</tr>
						</tbody>
					</table>
				</div>
				</c:forEach>
				<div class="pagingDiv">
					<nav aria-label="Page navigation example">
  						<ul class="pagination">
   							<li id="prevBtn" class="page-item ${pagingNumMap.startPageNum eq 1 ? 'disabled':'' }"><a  class="page-link" href="?pageNum=${pagingNumMap.startPageNum-1 }&region=${region}&city=${city}">Previous</a></li>
		    			<c:forEach var="i" begin="${pagingNumMap.startPageNum }" end="${pagingNumMap.endPageNum }">
		    				<li class="page-item ${pagingNumMap.pageNum eq i ? 'active':'' }"><a class="page-link" href="?pageNum=${i }&region=${region}&city=${city}">${i }</a></li>
		    			</c:forEach>
   							<li id="nextBtn" class="page-item ${pagingNumMap.endPageNum eq pagingNumMap.totalPageCount ? 'disabled':''}"><a class="page-link" href="?pageNum=${pagingNumMap.endPageNum+1 }&region=${region}&city=${city}">Next</a></li>
  						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<script>

let cnt=0;
let modal_loc_id=""

$(".nameLink").on("click", function(){
	console.log($(this).val());
	let data= "loc_id="+$(this).val();
	console.log(data);
	// JSON넣을 닙 
	let jsonData=null;
	$.ajax({
		  url : "temp",
		  data: data,
		  type : "post",
		  success : function(data) {
		  	console.log(data);
		  	jsonData=data
		  	//$(opener.document).find("#JSON").val(data);
		  	cnt=$(opener.document).find("input[name='cnt']").val();
		  	cnt++
		  	modal_loc_id="modalBtn("+data.loc_id+")"
		  	$(opener.document).find("#resTr tr").attr("id","tr_"+data.loc_id);
		  	$(opener.document).find("#resTr tr").find("td[name='no']").text(cnt);
		  	$(opener.document).find("#resTr tr").find("td[name='loc_name']").text(data.loc_name);
		  	$(opener.document).find("#resTr tr").find("td[name='loc_region']").text(data.loc_region);
		  	$(opener.document).find("#resTr tr").find("td[name='loc_addr']").text(data.loc_addr);
		  	$(opener.document).find("#resTr tr").find("td[name='loc_tel']").text(data.loc_tel);
		  	$(opener.document).find("#resTr tr").find("td[name='loc_worktime']").text(data.loc_worktime);
		  	$(opener.document).find("#resTr tr").find("td[name='loc_id']").text(data.loc_id);
		  	$(opener.document).find("#resTr tr").find("td[name='loc_lat']").text(data.loc_lat);
		  	$(opener.document).find("#resTr tr").find("td[name='loc_long']").text(data.loc_long);
		  	$(opener.document).find("#resTr tr th").find("button[name='modalBtn']").attr("onclick",modal_loc_id);
		  	$(opener.document).find("#resTb tbody").append($(opener.document).find("#resTr").html());
		  	$(opener.document).find("#resTr tr").find("td[name='no']").text($(opener.document).find("input[name='cnt']").val(cnt));
		  	
		  	
		  	$(opener.document).find("#resTr tr").find("td[name='no']").text("");
		  	$(opener.document).find("#resTr tr").find("td[name='loc_name']").text("");
		  	$(opener.document).find("#resTr tr").find("td[name='loc_region']").text("");
		  	$(opener.document).find("#resTr tr").find("td[name='loc_addr']").text("");
		  	$(opener.document).find("#resTr tr").find("td[name='loc_tel']").text("");
		  	$(opener.document).find("#resTr tr").find("td[name='loc_worktime']").text("");
		  	$(opener.document).find("#resTr tr").find("td[name='loc_id']").text("");
		  	$(opener.document).find("#resTr tr").find("td[name='loc_lat']").text("");
		  	$(opener.document).find("#resTr tr").find("td[name='loc_long']").text("");
		  	
		  	
		  	//$(opener.document).find
		  	//$(opener.document).find
		  	//$(opener.document).find
		  	
		  },
		  error : function() {
		  	alert("error");
		  }
		})
		console.log(jsonData);
});


$("#regionSelect").change(function(){
	//console.log($(this).val());
	let data= "loc_region="+$(this).val();
	//console.log(data);
	// JSON넣을 객체
	let jsonData=null;
	
	$.ajax({
		  url : "${pageContext.request.contextPath}/content/city_list",
		  data: data,
		  type : "get",
		  success : function(datas) {
		  	console.log(datas);
		  	jsonData=datas
		  	$("#reg_opt").attr("disabled","disabled")
		  	$("#citySelect").empty();
		  	
		  	var nonOption = $("<option selected value='none'>"+'시/군/구'+"</option>");
            $('#citySelect').append(nonOption);
		  	
		  	for(var count = 0; count < datas.length; count++){                
                var option = $("<option>"+datas[count]+"</option>");
                $('#citySelect').append(option);
            }

		  	
		  	
		  },
		  error : function() {
		  	console.log("error");
		  }
		});

		
});




/*
var trCnt = $("#resTb tbody tr").length;
  //팝업에서 추가한 리스트 표시
//var lastTr = $("#resTb tbody tr:last");

function addOne(data){
	
	$("#resTr tr").attr("id","tr_"+data.loc_id);
	$("#"+data.loc_id).find("td[name='no']").val();
	$("#"+data.loc_id).find("td[name='loc_name']").append(data.loc_name);
	("#resTr tr").find("td[name='loc_region']").append(data.loc_region);
	("#resTr tr").find("td[name='loc_addr']").append(data.loc_addr);
	("#resTr tr").find("td[name='tel']").append(data.tel);
	("#resTr tr").find("td[name='opening_hours']").append(data.working);
	//$(lastTr).find("td[name='cancle']").append(resArr[i].cancle);
	$("#resTb tbody").append($("#"+data.loc_id).html());
	
	
}  
  
$("#resTr tr").attr("id","tr_"+data.loc_id);
$("#"+data.loc_id).find("td[name='no']").val();
$("#"+data.loc_id).find("td[name='loc_name']").append(data.loc_name);
$("#"+data.loc_id).find("td[name='loc_region']").append(data.loc_region);
$(lastTr).find("td[name='loc_addr']").append(data.loc_addr);
$(lastTr).find("td[name='tel']").append(data.tel);
$(lastTr).find("td[name='opening_hours']").append(data.opening_hours);
//$(lastTr).find("td[name='cancle']").append(resArr[i].cancle);
$("#resTb tbody").append($("#"+data.loc_id).html());
*/





/*
//팝업창에서 setResList에 클릭한 리스트 정보를 담아온다.
function setResList(resArr){
	if($("#noRes").length > 0){  //팝업창에서 항목을 선택해주세요. 메시지 삭제
		$("#noRes").remove();
	}
	
	for(var i=0; i<resArr.length; i++){
		
        var trCnt = $("#resTb tbody tr").length;
        $("#resTb tbody").append($("#resTr").html());  //팝업에서 추가한 리스트 표시
        var lastTr = $("#resTb tbody tr:last");
        $(lastTr).attr("id","tr_"+resArr[i].rf_idx);
        $(lastTr).find("td[name='no']").append(resArr[i].no);
        $(lastTr).find("td[name='loc_name']").append(resArr[i].loc_name);
        $(lastTr).find("td[name='loc_region']").append(resArr[i].loc_region);
        $(lastTr).find("td[name='loc_addr']").append(resArr[i].loc_addr);
        $(lastTr).find("td[name='tel']").append(resArr[i].tel);
        $(lastTr).find("td[name='opening_hours']").append(resArr[i].opening_hours);
        $(lastTr).find("td[name='cancle']").append(resArr[i].cancle);
    }
}
*/


/*
$.ajax({
	  url : "temp",
	  data: "loc_id=100",
	  type : "post",
	  success : function(data) {
	  	console.log(data);
	  },
	  error : function() {
	  	alert("error");
	  }
	})
*/

</script>
</html>