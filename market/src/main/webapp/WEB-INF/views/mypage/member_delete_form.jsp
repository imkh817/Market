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
<link rel="stylesheet" href="./css/navbar.css">
</head>
<body class="my-5">
	<!-- 상단 내비바 -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

	<div class="mx-auto my-3 py-3" style="max-width: 768px;">
		<div class="d-flex justify-content-center my-3 py-3">
			<ul class="nav nav-underline gap-5">
				<li class="nav-item"><a class="nav-link" aria-current="page"
					href="mypage_list" style="color: #47C83E;">판매 내역</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_liked_form" style="color: #47C83E;">관심 상품</a></li>
				<li class="nav-item"><a class="nav-link"
					href="mypage_job_list" style="color: #47C83E;">내 구인 공고</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_update_form" style="color: #47C83E;">정보 수정</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_delete_form" style="color: #47C83E;">회원 탈퇴</a></li>
			</ul>
		</div>
	</div>

	<div class="d-flex justify-content-center">
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
<!-- load 함수로 동적 교체 -->
<script>
	$(".category").load("<c:url value='navbar' />");
</script>
</html>