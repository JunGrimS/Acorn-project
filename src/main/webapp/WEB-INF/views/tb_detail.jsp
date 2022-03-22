<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

.detail-form {
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
<script type="text/javascript">
window.onload = function(){
	document.querySelector("#rBtn").onclick = chkfunc;
}
//댓글 등록
function chkfunc(){
	//alert("c");
	
	$.ajax({
		type:"post",
		url:"reply_insert",
		data : $("#frm").serialize(),
		dataType:"json",
		complete : function(){
			location.reload();
		}
	});
	
};
	
// 	$(document).ready(function(){
		
// 		$(document).on('click','#replyInsert1',function(){
// 			// 댓글 달 경우
// 			fnReply($(this));
// 		});
		
		
// 	})
// 	// 등록버튼 줄에 있는 파라미터 등록
// 	function fnReply(obj){
// 		$("#replyForm").find("input[name='user_id']").val($(obj).closest("tr").find("input[name='user_id']").val());
// 		$("#replyForm").find("input[name='content']").val($(obj).closest("tr").find("textarea[name='content']").val());
// 		$("#replyForm").find("input[name='gnum']").val($(obj).closest("tr").find("input[name='gnum']").val());
// 		$("#replyForm").find("input[name='onum']").val($(obj).closest("tr").find("input[name='onum']").val());
// 		$("#replyForm").find("input[name='nested']").val($(obj).closest("tr").find("input[name='nested']").val());
// 		$("#replyForm").find("input[name='tb_url']").val($("#frm").find("input[name='tb_url']").val());
// 		$("#replyForm").find("input[name='tb_no']").val($("#frm").find("input[name='tb_no']").val());

// 		alert();
// 		// 댓글 입력 후 새로고침 >> 댓글 등록 확인
// 		$.ajax({
// 			url : "reply_insert",
// 			type : "post",
// 			data : $("#replyForm").serialize(),
// 			dataType :"json",
// 			complete : function(){
				
// 		        location.reload();	
// 			}		
// 		});	
// 	}
	
	function rtn(obj){
		
		$.ajax({
			url : "reply_list2.do",
			type : "post",
			data : {
				"onum" : $(obj).parent().find("input[name='onum']").val(),
				"nested" : Number($(obj).parent().find("input[name='nested']").val())+1
			},
			dataType : "json",
			success : function(result){
				

			},error : function(e){
				
			}
				
		})
		
		
		var html = "";
		html += '<tr>';
		html += '<td colspan="2">';
		html += '<input type="hidden" name="user_id" value="${sessionScope.res.user_id}"/>';
		html += '<input type="hidden" name="gnum" value="'+$(obj).parent().find("input[name='onum']").val()+'"/>';
		html += '<input type="hidden" name="onum" value="'+$(obj).parent().find("input[name='onum']").length+'"/>';
		html += '<input type="hidden" name="nested" value="'+(Number($(obj).parent().find("input[name='nested']").val())+1)+'"/>';
		html += '<textarea class="form-control" cols="100%" rows="5" name="content" placeholder="내용을 입력하세요."></textarea>';
		html += '</td>';
		html += '<td><input type="button" id="replyInsert1" value="등 록"></td>';
		html += '</tr>';
		
		$(obj).parent().append(html);
		$(obj).hide();
	}
	
	function fnInsert(){
		document.frm.action = "tb_insertPage";
		document.frm.submit();
	}
	
	function fnDelete(){
		document.frm.action = "tb_delete";
		document.frm.submit();
		
	}
		
	function fnList(tb_url){
		document.frm.action=tb_url;
		document.frm.submit();
		
	}
	
</script>
</head>
<body>
<div class="container">
	<div class="detail-form col-md-12 mx-auto">
		<form id="frm" name="frm" method="post" >
			<input type="hidden" name="tb_cat" id="tb_cat" value="<c:out value="${dto.tb_cat }"/>" />
			<input type="hidden" name="tb_no" id="tb_no" value="<c:out value="${dto.tb_no }"/>"/>
			<input type="hidden" name="page" id="page" value="1"/>
			<input type="hidden" name="tb_url" value="<c:out value="${tb_url }"/>" />
			<input type="hidden" name="user_id"  value="${sessionScope.res.user_id }" />
			<input type="hidden" name="gnum"  value="${dto.tb_no }" />
			<input type="hidden" name="onum"  value="0" />
			<input type="hidden" name="nested"  value="0" />
			<h1 class="text-center" >
				<c:choose>
						<c:when test="${dto.tb_cat eq '1' }">
							공지
						</c:when>
						<c:when test="${dto.tb_cat eq '2' }">
							문의
						</c:when>
						<c:when test="${dto.tb_cat eq '3' }">
							자유
						</c:when>
						<c:otherwise>
						</c:otherwise>
				</c:choose>
				게시판
			</h1>
			<table class="table table-hover" >
				<thead>
					<div class="fw-bold">
						<tr>
							<th colspan="6">
							제목 : ${dto.tb_title }
							
							</th>
						</tr>
					</div>
					<tr>
						<th>글번호 : ${dto.tb_no }</th>
						<th>
							분류 : 
							<c:choose>
								<c:when test="${dto.tb_cat eq '1' }">
									공지
								</c:when>
								<c:when test="${dto.tb_cat eq '2' }">
									문의
								</c:when>
								<c:when test="${dto.tb_cat eq '3' }">
									자유
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</th>
						<th>지역 : 
							<c:choose>
								<c:when test="${dto.tb_region eq '0001'}">
									서울
								</c:when>
								<c:when test="${dto.tb_region eq '0002'}">
									경기
								</c:when>
								<c:when test="${dto.tb_region eq '0003'}">
									강원
								</c:when>
								<c:when test="${dto.tb_region eq '0004'}">
									충청
								</c:when>
								<c:when test="${dto.tb_region eq '0005'}">
									전라
								</c:when>
								<c:when test="${dto.tb_region eq '0006'}">
									경상
								</c:when>
								<c:when test="${dto.tb_region eq '0007'}">
									제주
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</th>
						<th>작성자 : ${dto.tb_id }</th>
						<th>작성일 : ${dto.tb_date }</th>
						<th>조회수 : ${dto.tb_readcnt }</th>
					</tr>
					
				</thead>
				<tbody>
					<tr>
						<td colspan="6">
							<textarea class="form-control" rows="10" readonly="readonly" >${dto.tb_content }</textarea>
						</td>
					</tr>
				</tbody>
		
			</table>
			
			
			<table class="table table-striped table-hover">
				<!-- 댓글 입력 -->
				<tr>
					<td>
						<textarea class="form-control" cols="90%" rows="5" name="content" placeholder="내용을 입력하세요."></textarea>
						<input type="button" id="rBtn" style="float:right;" value="등 록">
					</td>
				</tr>
				<!-- 댓글 리스트 -->
				<c:if test="${not empty replyList }">
					<c:forEach items="${replyList }" var="list">
						<tr>
							<td>
								<span style="text-align:left">${list.user_id }</span>
								<span style="float:right">${fn:substring(list.date2, 2, 16) }</span>
							</td>
						</tr>
						<tr>
							<td>${list.content }
								<c:if test="${list.user_id eq sessionScope.res.user_id or sessionScope.res.user_auth eq 3 }">		
									<a href="#" id="" style="float:right">댓글 삭제</a>
								</c:if>							
							</td>							
						</tr>
						<c:if test="${not empty sessionScope.res.user_id }">
							<tr>
								<td >
									<input type="hidden" name="gnum"  value="${list.gnum}" />
									<input type="hidden" name="onum"  value="${list.onum}" />
									<input type="hidden" name="nested"  value="${list.nested }" />
									<a href="#" onclick="rtn(this);" style="text-align:left;">답글</a>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</c:if>
			</table>
			
			
			
			<!-- 리스트 버튼 -->
			<div class="row">	
				<div class="col-12" >
					<div style="float:right;">
						<c:if test="${sessionScope.res.user_auth eq '3' or sessionScope.res.user_id eq dto.tb_id }">
							<a class="btn btn-outline-primary" href="#" onclick="fnInsert(); return false;">수정</a>
							<a class="btn btn-outline-danger" href="#" onclick="fnDelete();">삭제</a>
						</c:if>
						<a class="btn btn-outline-dark" href="#" onclick="fnList('${tb_url}');">목록</a>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
</body>
</html>