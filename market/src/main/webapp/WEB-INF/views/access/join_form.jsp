<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/banner.css">
<link rel="stylesheet" href="./css/join.css">
<link rel="stylesheet" href="./css/navbar.css">
</head>

<script src="./js/join/join_function.js"></script>

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
			<form action="join_member" method="post">
				<div class="input-group mb-2">
					<label for="username" class="form-label fw-medium">아이디</label>
					<div class="input-group">
						<input class="form-control rounded-1" type="text" id="member_id"
							name="member_id" required placeholder="아이디를 입력해주세요">
					</div>
					<input type="text" class="rounded-pill text-danger fw-bold px-3"
						id="id_valiable" value="" style="display: none">
				</div>
				<div class="input-group mb-2">
					<label for="password" class="form-label fw-medium">비밀번호</label>
					<div class="input-group">
						<input class="form-control rounded-1" type="password"
							id="password" name="member_pw" required
							placeholder="비밀번호를 입력해주세요" onfocus="id_valiable1()">
					</div>
				</div>
				<div class="input-group mb-2">
					<label for="name" class="form-label fw-medium">이름</label>
					<div class="input-group">
						<input class="form-control rounded-1" type="text" id="member_name"
							name="member_name" placeholder="이름을 입력해주세요" required>
					</div>
				</div>
				<div class="input-group mb-2">
					<label for="nickname" class="form-label fw-medium">별명</label>
					<div class="input-group">
						<input class="form-control rounded-1" type="text"
							id="member_nickname" name="member_nickname"
							placeholder="별명을 입력해주세요" required>
					</div>
					<input type="text" class="rounded-pill text-danger fw-bold px-3"
						id="nickname_valiable" value="" style="display: none">
				</div>
				<div class="input-group mb-2">
					<label for="jumin" class="form-label fw-medium">주민번호</label>
					<div class="input-group">
						<input class="col-5" type="text" id="member_jumin1"
							style="border-radius: 4px 0 0 4px;" maxlength="6"
							name="member_jumin1" required onfocus="name_valiable1()"
							placeholder="주민번호 앞 6자리 입력"> <input
							class="col-2 text-center" type="text" style="border-radius: 0;"
							maxlength="1" name="member_jumin1" required
							onfocus="name_valiable1()" value="-" readonly> <input
							class="col-5" type="text" style="border-radius: 0 4px 4px 0;"
							maxlength="1" id="member_jumin2" name="member_jumin2" required
							placeholder="주민번호 뒷 1자리 입력">
					</div>
				</div>
				<div class="input-group mb-2">
					<label for="phone_number" class="form-label fw-medium">전화번호</label>
					<div class="input-group">
						<input class="col-9 fw-medium" type="text" id="member_phone_num"
							name="member_phone_num" required
							placeholder="01012345678 형식으로 입력"> <input
							class="col-3 fw-medium" type="button" value="인증번호 발송"
							onClick="phone_authorization1()">
					</div>
					<input
						class="col-9 fw-medium text-danger rounded-pill fw-bold px-3"
						id="phone_number_valiable" type="text" style="display: none">
					<div class="input-group mb-2" id="phone_authorization"
						style="display: none">
						<label for="phone_number" class="form-label fw-medium">인증번호</label>
						<div class="input-group">
							<input class="col-9 fw-medium" id="client_num" type="text">
							<input class="col-3 fw-medium" type="button" value="인증번호 확인"
								onClick="check_phone_authorization1()">
						</div>
						<input type="text" class="form-control rounded-1"
							id="phone_authorization_value" name="phone_authorization_value"
							value="" style="display: none">
					</div>
				</div>
				<button class="my-3 pt-3 rounded-1" type="submit" id="joinButton"
					disabled>가입하기</button>
			</form>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
<script src="./js/join/join.js"></script>
<!-- load 함수로 동적 교체 -->
<script>
	$(".category").load("<c:url value='navbar' />");
</script>
</html>