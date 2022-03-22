<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행장소 선택 페이지</title>
<!-- bootstrap css 로딩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- bootstrap javascript 로딩 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<script type="text/javascript">
window.onload = function(){
	let btnIns = document.querySelector("#btnInsertDetail");
	btnIns.addEventListener("click", checkSubmit);
}
function checkSubmit(){
	if(confirm("등록하시겠습니까?")){
		frm.submit();
	}
}
</script>
<!-- Uploadcare -->
<script>
  UPLOADCARE_PUBLIC_KEY = 'demopublickey';
</script>
<script src="https://ucarecdn.com/libs/widget/3.x/uploadcare.full.min.js"></script>
 
</head>
<body>
<div class="form-group">
	<form action="insertDetail" method="post" name="frm" class="form-inline">
		<label for="ti_content">여행 내용</label>
		<br>
		<textarea class="form-control" id="ti_content" name="ti_content" rows="5"></textarea>
		<br>
		<label for="image">이미지 첨부</label>
		<input type="hidden" role="uploadcare-uploader" name="ti_pic_url" />
		<script>
		//role의 값이 uploadcare-uploader인 태그를 업로드 위젯으로 생성
		var singleWidget = uploadcare.SingleWidget("[role=uploadcare-uploader]");
		//그 위젯을 통해 업로드가 끝났을 때
	//	singleWidget.onUploadComplete(function(info){
			//id가 content인 태그의 값 뒤에 업로드한 이미지 파일의 주소를 이미지 태그와 함께 첨부
	//		document.getElementById("content").value = document.getElementById("content").value + '<img src="' + info.cdnUrl + '">';
	//	});
		</script>
		<br>
		<input class="btn btn-primary" type="button" value="등록" id="btnInsertDetail">
	</form>
</div>
</body>
</html>