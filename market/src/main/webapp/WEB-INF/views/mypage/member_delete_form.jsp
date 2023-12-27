<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<script src="./js/join/join.js"></script>
<link rel="stylesheet" href="./css/join.css">
<link rel="stylesheet" href="./css/pagination.css">
</head>
<body class="my-5 py-5">
	<!-- 상단 내비바 -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

	<!-- 프로필 정보 및 통계 영역 -->
	<div class="mx-auto my-3 py-3" style="max-width: 768px;">
		<div
			class="container p-4 mb-3 bg-body-tertiary shadow rounded rounded-4">
			<div class="row">
				<div class="col my-auto text-center">
					<p class="fs-4 fw-bold mb-2">#${member_nickname}</p>
					<img src="./images/picture.png" class="img-fluid" alt="프로필 이미지"
						style="width: 100px; height: 100px;">
				</div>
				<div class="col my-auto text-center pt-3">
					<i class="fa-solid fa-gift fs-1 mb-2" style="color: #5ba95d;"></i>
					<p class="fs-5">판매 ${sell_count}</p>
				</div>
				<div class="col my-auto text-center pt-3">
					<i class="fa-solid fa-heart fs-1 mb-2" style="color: #e84a62;"></i>
					<p class="fs-5">좋아요 ${liked_count}</p>
				</div>
			</div>
		</div>

		<div class="d-flex justify-content-center my-3 py-3">
			<ul class="nav nav-underline gap-5">
				<li class="nav-item"><a class="nav-link" aria-current="page"
					href="mypage_list" style="color: #47C83E;">판매 내역</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_liked_form" style="color: #47C83E;">관심 상품</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_delete_form" style="color: #47C83E;">회원 탈퇴</a></li>
			</ul>
		</div>
	</div>

	<div class="d-flex justify-content-center my-3 py-3">
		<div class="join-container" style="width: 768px;">
			<div class="join-form">
				<h2>회원 탈퇴를 원하시면</h2>
				<h2>비밀번호를 입력하세요.</h2>
				<br>
				<form action="member_delete" method="post">
					<label for="username" class="fw-medium">비밀번호:</label> <input
						class="col-12 fw-medium" type="password" id="member_pw"
						name="member_pw" required placeholder="비밀번호를 입력해주세요."> <br>
					<br>
					<button type="submit" id="member_delete_button">탈퇴하기</button>
				</form>
			</div>
		</div>
	</div>
	
		<!-- 하단 내비바 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>