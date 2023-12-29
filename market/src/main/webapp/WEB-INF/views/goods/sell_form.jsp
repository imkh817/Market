<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>상품 판매 등록</title>
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
		<form action="goods_reg" method="post" enctype="multipart/form-data">

			<div class="form-group row mt-1">
				<label for="title" class="col-sm-2 col-form-label fw-bold">상품 제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="goods_name" name="goods_name" placeholder="상품 제목">
				</div>
			</div>

			<div class="form-group row mt-3">
				<label for="goods_category" class="col-sm-2 col-form-label fw-bold">카테고리</label>
				<div class="col-sm-10">
					<select class="form-select" id="category_no" name="category_no">
						<option value="0" selected="selected">카테고리 선택</option>
						<c:forEach items="${Category}" var="Category">
							<option value="${Category.category_no }">${Category.category_name}</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="form-group row mt-3">
				<label for="goods_price" class="col-sm-2 col-form-label fw-bold">가격</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="goods_price" name="goods_price" placeholder="숫자만 입력해주세요.">
				</div>
			</div>

			<div class="form-group row mt-3">
				<label for="goods_content" class="col-sm-2 col-form-label fw-bold">상품 설명</label>
				<div class="col-sm-8">
					<textarea class="form-control" id="goods_content" name="goods_content" rows="5" placeholder="상품 설명"></textarea>
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-primary btn-sm" onClick="#">AI 글 작성</button>
				</div>
			</div>
			
			<div class="form-group row mt-3">
				<label for="images" class="col-sm-2 col-form-label fw-bold">상품 이미지</label>
				<div class="col-sm-10 input_container my-auto">
					<input type="file" class="form-control-file" id="images" name="images" multiple>
				</div>
			</div>
			
			<div class="text-center mt-3">
				<button type="submit" class="btn btn-primary">상품 등록</button>
			</div>
		</form>
	</div><!-- end 상품 등록 작성 폼 -->

</body>
<!-- footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>