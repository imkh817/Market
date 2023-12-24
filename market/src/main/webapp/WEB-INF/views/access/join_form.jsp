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
</head>

<script src="./js/join/join_function.js"></script>

<body class="pt-5">
<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
<section class="banner my-5 py-5">
	<div class="title">
		<h1>
			가장 가까운 플리마켓<br> <b>양배추마켓</b>
		</h1>
	</div>
</section>

<div class="join-container">
    <div class="join-form">
       	<h2>양배추 마켓에 오신 것을</h2>
        <h2>환영합니다.</h2>
        <br>
        
        <form action="join_member" method="post">
            <label for="username" class="fw-medium">아이디:</label>
            <input class="col-11 fw-medium" type="text" id="member_id" name="member_id" required placeholder="아이디를 입력해주세요">
            <input type="text" class="rounded-pill text-danger fw-bold" id="id_valiable" value="" style="display:none">

            <label for="password" class="fw-medium">비밀번호:</label>
            <input class="col-11" type="password" id="password" name="member_pw" required placeholder="비밀번호를 입력해주세요" onfocus="id_valiable1()">

			<label for="name" class="fw-medium">이름:</label>
            <input class="col-11 fw-medium" type="text" id="member_name" name="member_name" placeholder="이름을 입력해주세요" required>
            
            <label for="nickname" class="fw-medium">별명:</label>
            <input class="col-11 fw-medium" type="text" id="member_nickname" name="member_nickname" placeholder="별명을 입력해주세요" required>
            <input type="text" class="rounded-pill text-danger fw-bold" id="nickname_valiable" value="" style="display:none">
            
			<label for="jumin" class="fw-medium">주민번호</label>
			<div class="input-group">
				<input class="col-5" type="text" id="member_jumin1" class="form-control fw-medium"
					style="border-radius: 4px 0 0 4px; height: 43px;" maxlength="6"
					name="member_jumin1" required onfocus="name_valiable1()" placeholder="주민번호 앞 6자리 입력">
				<div class="input-group-prepend">
					<span class="input-group-text"
						style="border-radius: 0; height: 43px;">-</span>
				</div>
				<input class="col-5" type="text" class="form-control fw-medium"
					style="border-radius: 0 4px 4px 0; height: 43px;" maxlength="1"
					id="member_jumin2" name="member_jumin2" required placeholder="주민번호 뒷 1자리 입력">
			</div>
            
             <label  for="phone_number" class="fw-medium">전화번호:</label>
             <div>
            	<input class="col-9 fw-medium" type="text" id="member_phone_num" name="member_phone_num" required placeholder="01012345678 형식으로 입력">
           	 	<input class="col fw-medium" type="button" value="인증번호 발송" onClick="phone_authorization1()">
           	 	<input class="col-9 fw-medium text-danger rounded-pill fw-bold" id="phone_number_valiable" type="text" style="display:none">
            </div>
            <div id="phone_authorization" style="display:none">
            	<label  for="phone_number" class="fw-medium">인증번호:</label>
            	<input class="col-9 fw-medium" id="client_num" type="text">
            	<input class="col fw-medium" type="button" value="인증번호 확인" onClick="check_phone_authorization1()">
            </div>
            
            <input type="text" class="fw-medium" id="phone_authorization_value" name="phone_authorization_value" value="" style="display:none">
            <button type="submit" id="joinButton" disabled>가입하기</button>
        </form>
    </div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
<script src="./js/join/join.js"></script>
</html>