<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
function selectItem(){
	if($("#resultTable input[name='checkMyTrip']:checked").length == 0){
		alert("다녀온 여행지를 체크해주세요.");
		return;
	}
}
</script>
 
<table id="resultTable">
	<thead>
		<tr>
			<th>선택</th>
			<th>이름</th>
			<th>지역</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="popupList" items="${popupList }">
			<tr>
				<td><input type="checkbox" name="checkMyTrip" value="${popupList.id}" /></td>
				<td>${popupList.name}</td>
				<td>${popupList.region}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
	<a href="" onclick="selectItem()">등록</a>
	<a href="javascript:self.close();">닫기</a>