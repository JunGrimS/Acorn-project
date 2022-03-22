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
<script type="text/javascript">
 
	function fnInsert(user_id,tb_cat){

		if(!user_id){
			alert("로그인해주세요.");
			return;
		}
		$("#tb_cat").val(tb_cat);
		$("#tb_url").val("tb_list2.do?tb_cat="+tb_cat+"&");
		
		document.frm.action = "tb_insertPage";
		document.frm.submit();
	}
	

	function fnDetail(tb_no){
		
		$("#tb_no").val(tb_no);
		$("#tb_url").val("tb_list2");

		document.frm.action = "tb_detail";
		document.frm.submit();
		
	}
	
	function fnSearch(cat){
		document.frm.action = "tb_list2";
		if(cat != ""){
			document.frm.tb_cat.value = cat;				
			document.frm.page.value = 1;				
			
		}
		document.frm.submit();

	}

	
	function fnPage(page_no){
		
// 		if($("#page_chk").val() < page_no ){
// 			alert("해당 페이지는 존재하지 않습니다.");
// 			return;
// 		}
		
		$("#page").val(page_no);
		document.frm.action = "tb_list2";
		document.frm.submit();
		
	}
	
</script>

<title>더보기</title>
</head>
<body>
	<div class="container my-3">
		<h1 class="text-center">
			<c:choose>
				<c:when test="${tb_cat eq '1' }">
					<strong>공지게시판</strong>			
				</c:when>			
				<c:when test="${tb_cat eq '2' }">	
					<strong>문의게시판</strong>			
				</c:when>
				<c:otherwise>
					<strong>자유게시판</strong>							
				</c:otherwise>			
			</c:choose>
		</h1>
<!-- 		<div class="text-left"> -->
<!-- 			<a href="tb_list?page=1">전체 리스트</a> -->
<!-- 		</div> -->
		<div class="row">	
			<div class="col-12" >
				<div style="float:right;">
					<c:if test="${(tb_cat ne '1' and sessionScope.res.user_auth ne 3 ) or sessionScope.res.user_auth eq 3}">
						<a href="#" onclick="fnInsert('${res.user_id}','${tb_cat }');" class="btn btn-primary" >글쓰기</a>
					</c:if>
				</div>
			</div>
		</div>
		<form id="frm" name="frm" >
			<input type="hidden" name="tb_cat" id="tb_cat" value="${tb_cat }" />
			<input type="hidden" name="page_chk" id="page_chk" value="${page_chk }" />
			<input type="hidden" name="tb_no" id="tb_no" value=""/>
			<input type="hidden" name="page" id="page" value=""/>
			<input type="hidden" name="tb_url" id="tb_url" value=""/>
	
			<div class="row">
				<div class="col-sm-2">
					<c:forEach var="tb_cate" begin="1" end="3" >
						<a href="tb_list2?page=1&tb_cat=${tb_cate}" class="btn btn-outline-dark fs-4 my-1" style="display:inline-block; width:100%;">
							<c:choose>
								<c:when test="${tb_cate eq '1' }">
									공지
								</c:when>
								<c:when test="${tb_cate eq '2' }">
									문의
								</c:when>
								<c:otherwise>
									자유
								</c:otherwise>	
							</c:choose>						
						</a>
					</c:forEach>
				</div>
				<div class="col-sm-10">
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th>종류</th>
								<c:if test="${tb_cat ne 1 }">
									<th>지역</th>
								</c:if>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="table" items="${result }" varStatus="status" >
								<tr>
									<td>
										<c:choose>
											<c:when test="${table.tb_cat eq '1' }">
												공지
											</c:when>
											<c:when test="${table.tb_cat eq '2' }">
												문의
											</c:when>
											<c:otherwise>
												자유
											</c:otherwise>							
										</c:choose>
									</td>
									<c:if test="${tb_cat ne 1 }">
										<td>
										<c:choose>
											<c:when test="${table.tb_region eq '0001'}">
												서울
											</c:when>
											<c:when test="${table.tb_region eq '0002'}">
												경기
											</c:when>
											<c:when test="${table.tb_region eq '0003'}">
												강원
											</c:when>
											<c:when test="${table.tb_region eq '0004'}">
												충청
											</c:when>
											<c:when test="${table.tb_region eq '0005'}">
												전라
											</c:when>
											<c:when test="${table.tb_region eq '0006'}">
												경상
											</c:when>
											<c:when test="${table.tb_region eq '0007'}">
												제주
											</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
										</td>
									</c:if>
									<td>
<%-- 										<a href="tb_detail?tb_no=${table.tb_no}"> --%>
										<a href="#" onclick="fnDetail('${table.tb_no}');">
											${table.tb_title }
										</a>
									</td>
									<td>${table.tb_id }</td>
									<td><c:out value="${fn:substring(table.tb_date,0,10)}"/></td>
									<td>${table.tb_readcnt }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<!-- 검색 -->
					<div style="float:right;" >
							<select name="searchN">
								<option value="tb_title" <c:if test="${empty searchN or searchN eq 'tb_title' }">selected="selected"</c:if> >글제목</option>
								<option value="tb_id" <c:if test="${searchN eq 'tb_id' }">selected="selected"</c:if> >작성자</option>
							</select>
							<input type="text" name="searchV" />
							<input type="button" onclick="fnSearch('${tb_cat}'); return false;" value="검색" />
					</div>
				</div>
				
				<!-- 페이지 시작 -->
				<div class="row">
					<div class="col-12">
						<div style="text-align:center;">
							<c:forEach var="pg" items="${pageArr }">
								<c:if test="${pg <= page_chk }">
									<a href="#" class="btn btn-outline-primary" onclick="fnPage('${pg}');">${pg}</a>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- 페이지 끝 -->
				
			</div>
		</form>
	</div>
</body>
</html>