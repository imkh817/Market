<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>알바 글 작성</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
	function openDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById('job_place').value = data.address;
			}
		}).open();
	}
</script>

<link rel="stylesheet" href="./css/goods.css">
<link rel="stylesheet" href="./css/navbar.css">
</head>

<body class="pt-5">
	<!-- header : 부트스트랩, 제이쿼리 불러오기-->
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<!-- navbar -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

	<div class="container my-5 goods_form">
		<br>
		<!-- 상품 등록 작성 폼 -->
		<form action="job_insert" method="post" enctype="multipart/form-data">

			<div class="form-group row mt-1">
				<label for="title" class="col-sm-2 col-form-label fw-bold">글 제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="job_title" name="job_title" placeholder="글 제목" required>
				</div>
			</div>

			<div class="form-group row mt-3">
				<label for="goods_price" class="col-sm-2 col-form-label fw-bold">시급</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="job_price" name="job_price" placeholder="숫자만 입력해주세요." required>
				</div>
			</div>
			
			<div class="form-group row mt-3">
				<label for="goods_price" class="col-sm-2 col-form-label fw-bold">근무 요일</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="job_day" name="job_day" placeholder="요일을 입력해주세요." required>
				</div>
			</div>

			<div class="form-group row mt-3">
				<div class="form-group">
					<label for="job_time" class="col-sm-2 col-form-label fw-bold">근무 시간</label> 
					<input type="text" class="form-control d-inline w-auto" id="job_time1"
						name="job_time1" placeholder="시작 시간 (HH:MM)" required> 
						<span class="d-inline"> ~ </span> 
					<input type="text" class="form-control d-inline w-auto" id="job_time2"
						name="job_time2" placeholder="마감 시간 (HH:MM)" required> 
						<span class="d-inline"></span>
				</div>
			</div>

			<div class="form-group row mt-3">
				<label for="inputZip" class="col-sm-2 col-form-label fw-bold">주소 찾기</label>
					<div class="col-sm-4">
					<input type="text" id="job_place" class="form-control d-inline w-auto"
						name="job_place" readonly onclick="openDaumPostcode()" required>
						<button type="button" class="btn btn-secondary"
							onclick="openDaumPostcode()">검색</button>
					</div>
			</div>

			<div class="form-group row mt-3">
				<label for="job_content" class="col-sm-2 col-form-label fw-bold">상세 설명</label>
				<div class="col-sm-8">
					<textarea class="form-control" id="job_content" name="job_content" rows="5" placeholder="정확한 장소 및 상세 설명을 입력해주세요." required></textarea>
				</div>
			</div>
			
			<div class="form-group row mt-3">
				<label for="job_image" class="col-sm-2 col-form-label fw-bold">참고 이미지</label>
				<div class="col-sm-10 input_container my-auto">
					<input type="file" class="form-control-file" id="images" name="images" multiple required>
				</div>
			</div>
			
			<div class="text-center mt-3">
				<button type="submit" class="btn btn-primary">글 등록</button>
			</div>
		</form>
	</div><!-- end 상품 등록 작성 폼 -->

</body>
<!-- footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>