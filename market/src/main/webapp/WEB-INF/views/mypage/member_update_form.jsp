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
<style>
.logo {
	background: url('../images/user.png');
	background-position: center;
	background-size: cover;
	width: 100px;
	height: 100px;
	align-items: center;
	border: 1px solid #BDBDBD;
}

#file {
	display: none;
}

.ai-text {
	padding: 5px 20px;
	background-color: #444444;
	border-radius: 5px;
	color: #ffffff;
	position: absolute;
	display: none;
}

.ai-title:hover+.ai-text {
	display: block;
}
</style>
</head>
<body class="my-5 py-5">
	<!-- 상단 내비바 -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

	<!-- 프로필 정보 및 통계 영역 -->
	<div class="mx-auto my-3 py-3" style="max-width: 768px;">
		<div class="d-flex justify-content-center my-3 py-3">
			<ul class="nav nav-underline gap-5">
				<li class="nav-item"><a class="nav-link" aria-current="page"
					href="mypage_list" style="color: #47C83E;">판매 내역</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_liked_form" style="color: #47C83E;">관심 상품</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_delete_form" style="color: #47C83E;">회원 탈퇴</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_delete_form" style="color: #47C83E;">정보 수정</a></li>
			</ul>
		</div>
	</div>

	<div class="join-container" style="width: 768px;">
		<div class="join-form">
			<form action="member_update" method="post">
				<p class="fs-2 fw-medium mb-3">프로필</p>
				<hr>
				<div>
					<div class="logo rounded-circle opacity-75 my-4 mx-auto"
						style="position: relative">
						<label for="file" style="cursor: pointer;"> <i
							class="fa-solid fa-camera text-light opacity-75"
							style="position: absolute; transform: translate(350%, 450%);"></i>
						</label> <input type="file" name="file" id="file">
					</div>
				</div>
				<div class="d-flex justify-content-center mb-3">
					<a class="ai-title text-dark" href="#">
						<i class="fs-4 fa-solid fa-wand-magic-sparkles opacity-75"></i>
					</a>
					<div class="ai-text">원하는 이미지를 간단한 글로 설명하면 AI가 생성해줘요</div>
				</div>
				<div class="input-group mb-2">
					<label class="form-label fw-medium">이름</label>
					<div class="input-group">
						<input
							class="form-control border-bottom border-dark-subtle rounded-0"
							type="text" style="border: none;" placeholder="입력란">
					</div>
				</div>
				<div class="input-group mb-2">
					<label class="form-label fw-medium">별명</label>
					<div class="input-group">
						<input
							class="form-control border-bottom border-dark-subtle rounded-0"
							type="text" style="border: none;" placeholder="입력란">
					</div>
				</div>
				<div class="input-group mb-2">
					<label class="form-label fw-medium">전화번호</label>
					<div class="input-group">
						<input
							class="form-control border-bottom border-dark-subtle rounded-0"
							type="text" style="border: none;" placeholder="입력란">
					</div>
				</div>
				<button type="submit" id="member_update_button">수정하기</button>
			</form>
		</div>
	</div>

	<!-- 하단 내비바 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>