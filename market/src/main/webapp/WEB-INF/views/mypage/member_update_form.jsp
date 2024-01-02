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
<body class="my-5 py-5">
	<!-- 상단 내비바 -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

	<!-- 프로필 정보 및 통계 영역 -->
	<div class="mx-auto my-3 py-3" style="max-width: 768px;">
		<%-- <div
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
		</div> --%>

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
        <h2>프로필</h2>
        <hr style="border: none; border-top: 1px solid #000; margin-top: 10px;">
        <br>
		<img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' fill='currentColor'%3E%3Cpath d='M8 0a8 8 0 1 0 8 8A8 8 0 0 0 8 0zm-.5 12h1V5h-1zm0-6h1v1h-1z'/%3E%3C/svg%3E" class="rounded" alt="..." style="width: 50px; height: 50px;">

        <form action="member_delete" method="post">
            <input class="col-12 fw-medium" type="file" id="member_image1" name="member_image1"> <br> <br>
            <button type="submit" id="member_delete_button">탈퇴하기</button>
        </form>
    </div>
</div>

		<!-- 하단 내비바 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>