<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>알바 글 작성</title>
<link rel="stylesheet" href="./css/goods.css">
<link rel="stylesheet" href="./css/navbar.css">
</head>

<style>

</style>
<body class="pt-5">
	<!-- header : 부트스트랩, 제이쿼리 불러오기-->
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<!-- navbar -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

	<div class="container my-5 goods_form">
		<br>
		<!-- 상품 등록 작성 폼 -->
		<form action="*" method="post" enctype="multipart/form-data">

			<div class="form-group row mt-1">
				<label for="title" class="col-sm-2 col-form-label fw-bold">글 제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="job_title" name="job_title" placeholder="글 제목">
				</div>
			</div>

			<div class="form-group row mt-3">
				<label for="goods_price" class="col-sm-2 col-form-label fw-bold">시급</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="job_price" name="job_price" placeholder="숫자만 입력해주세요.">
				</div>
			</div>
			
			<div class="form-group row mt-3">
				<label for="goods_price" class="col-sm-2 col-form-label fw-bold">근무 요일</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="job_day" name="job_day" placeholder="요일을 입력해주세요.">
				</div>
			</div>

			<div class="form-group row mt-3">
				<div class="form-group">
					<label for="job_time" class="col-sm-2 col-form-label fw-bold">근무 시간</label> 
					<input type="text" class="form-control d-inline w-auto" id="job_time1"
						name="job_time1" placeholder="시작 시간 (HH:MM)"> 
						<span class="d-inline" required> ~ </span> 
					<input type="text" class="form-control d-inline w-auto" id="job_time2"
						name="job_time2" placeholder="마감 시간 (HH:MM)"> 
						<span class="d-inline" required></span>
				</div>
			</div>

			<div class="form-group row mt-3">
				<label for="job_content" class="col-sm-2 col-form-label fw-bold">상세 설명</label>
				<div class="col-sm-8">
					<textarea class="form-control" id="job_content" name="job_content" rows="5" placeholder="상품 설명"></textarea>
				</div>
			</div>
			
			<div class="form-group row mt-3">
				<label for="job_image" class="col-sm-2 col-form-label fw-bold">참고 이미지</label>
				<div class="col-sm-10 input_container my-auto">
					<input type="file" class="form-control-file" id="job_image" name="job_image" multiple>
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