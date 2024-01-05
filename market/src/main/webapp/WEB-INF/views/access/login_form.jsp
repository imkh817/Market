<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/banner.css">
<link rel="stylesheet" href="./css/join.css">
<link rel="stylesheet" href="./css/navbar.css">
</head>
<body style="padding-top:20px;">
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<section class="banner my-5 py-5">
		<div class="title">
			<h1>
				가장 가까운 플리마켓<br> <b>양배추마켓</b>
			</h1>
		</div>
	</section>

	<div class="join-container my-3">
		<div class="join-form">
			<div class="title my-3">
				<h2>
					양배추마켓에 오신 것을<br>환영합니다.
				</h2>
			</div>
			<form action="login" method="post">
				<div class="input-group mb-2">
					<label for="member_id" class="form-label fw-medium">아이디</label>
					<div class="input-group">
						<input class="form-control rounded-1" type="text" id="member_id"
							name="member_id" required>
					</div>
				</div>
				<div class="input-group mb-2">
					<label for="password" class="form-label fw-medium">비밀번호</label>
					<div class="input-group">
						<input class="form-control rounded-1" type="password"
							id="member_pw" name="member_pw" required>
					</div>
				</div>
				<div class="password-reset" align="center">
					<a href="find_id_form">아이디 찾기</a> | <a href="find_pw_form">비밀번호
						찾기</a>
				</div>
				<br>
				<button type="submit">로그인하기</button>
			</form>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>

</body>
<!-- load 함수로 동적 교체 -->
<script>
	$(".category").load("<c:url value='navbar' />");
</script>
</html>