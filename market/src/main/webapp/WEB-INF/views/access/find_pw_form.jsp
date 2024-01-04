<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/banner.css">
<link rel="stylesheet" href="./css/join.css"> 
<link rel="stylesheet" href="./css/navbar.css">
</head>
<script src="./js/join/join_function.js"></script>
<body style="padding-top:20px;">
<section class="banner my-5 py-5">
	<div class="title">
		<h1>
			가장 가까운 플리마켓<br> <b>양배추마켓</b>
		</h1>
	</div>
</section>
<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
<div class="join-container">
    <div class="join-form">
       	<h2>양배추마켓 가입 정보로</h2>
        <h2>비밀번호를 확인하세요.</h2>
        <br>
        <form action="find_pw" method="post">
            <label for="username" class="fw-medium">아이디:</label>
            <input class="col-11 fw-medium" type="text" id="member_id" name="member_id" required placeholder="아이디를 입력해주세요">

			<label  for="phone_number" class="fw-medium">전화번호:</label>
             <div>
            	<input class="col-9 fw-medium" type="text" id="member_phone_num" name="member_phone_num" required placeholder="01012345678 형식으로 입력">
           	 	<input class="col fw-medium" type="button" value="인증번호 발송" onClick="phone_autorization_pw1()">
           	 	<input class="col-9 fw-medium text-danger rounded-pill fw-bold" id="phone_number_valiable" type="text" style="display:none">
            </div>
            <div id="phone_authorization" style="display:none">
            	<label  for="phone_number" class="fw-medium">인증번호:</label>
            	<input class="col-9 fw-medium" id="client_num" type="text">
            	<input class="col fw-medium" type="button" value="인증번호 확인" onClick="check_phone_authorization1()">
            </div>
            
            <input type="text" class="fw-medium" id="phone_authorization_value" name="phone_authorization_value" value="" style="display:none">
            <br>
            <button type="submit" id="joinButton" disabled>비밀번호 찾기</button>
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