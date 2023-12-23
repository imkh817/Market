<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>상품 판매 등록</title>
</head>
<!-- Daum address API -->
<script>
	function openDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById('cafe_address').value = data.address;
			}
		}).open();
	}
</script>
<body class="pt-5">
	<!-- header : 부트스트랩, 제이쿼리 불러오기-->
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<!-- navbar -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

	<div class="container my-5">

		<!-- 상품 등록 작성 폼 -->
		<form enctype="multipart/form-date" action="#" method="post">
			<div class="mb-3">
				사진을 선택해 주세요. 
				<input class="form-control form-control-sm" id="formFileSm" type="file">
			</div>
			<div>
				<input type="text" placeholder="상품명"></input>
			</div>
			<div>
				<input type="number" placeholder="판매가격"></input>
			</div>
			<div>
				<textarea>상품의 상세 정보를 입력해주세요.</textarea>
			</div>
			<div>
				<input type="text" id="cafe_address" class="form-control"
					name="cafe_address" readonly placeholder="주소를 입력하세요"
					onClick="openDaumPostcode()">

				<div class="input-group-append">
					<input type="button" class="btn btn-secondary"
						onclick="openDaumPostcode()" value="검색" />
				</div>
			</div>
			<div>
				<input type="submit" value="등록" class="btn btn-primary" /> 
				<input type="button" value="취소" class="btn btn-primary" />
			</div>
		</form>
	</div>

</body>
<!-- footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>