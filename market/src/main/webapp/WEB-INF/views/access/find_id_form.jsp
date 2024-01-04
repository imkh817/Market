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
        <h2>아이디를 확인하세요.</h2>
        <br>
        <form action="find_id" method="post">
            <label for="username" class="fw-medium">이름:</label>
            <input class="col-11 fw-medium" type="text" id="member_name" name="member_name" required placeholder="이름을 입력해주세요">

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
            <br>
            <button type="submit" id="find_id_button">아이디 찾기</button>
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