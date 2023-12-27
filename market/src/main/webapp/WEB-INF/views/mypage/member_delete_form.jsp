<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/banner.css">
<link rel="stylesheet" href="./css/join.css">
</head>
<body>
	<section class="banner my-5 py-5">
		<div class="title">
			<h1>
				가장 가까운 플리마켓<br> <b>양배추마켓</b>
			</h1>
		</div>
	</section>

	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	
	<div class="d-flex flex-row justify-content-center mx-auto">
	<div class="col-1">
		<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	</div>
		<div class="col-11">
			<div class="join-container">
				<div class="join-form">
					<h2>회원 탈퇴를 원하신다면</h2>
					<h2>비밀번호를 입력하세요.</h2>
					<br>
					<form action="member_delete" method="post">
						<label for="username" class="fw-medium">비밀번호:</label> <input
							class="col-11 fw-medium" type="password" id="member_pw"
							name="member_pw" required placeholder="비밀번호를 입력해주세요."> <br><br>
						<button type="submit" id="member_delete_button">탈퇴하기</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script src="./js/join/join.js"></script>
</body>
</html>