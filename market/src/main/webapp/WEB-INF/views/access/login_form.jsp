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
</head>
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
        
        <form action="#" method="post">
            <label for="username">아이디:</label>
            <input class="col-12" type="text" id="username" name="username" required>

            <label for="password">비밀번호:</label>
            <input class="col-12" type="password" id="password" name="password" required>

			<div class="password-reset" align="center">
				<a href="find_id">아이디 찾기</a> | <a href="find_pw">비밀번호 찾기</a>
			</div>
			<br>
            <button type="submit">로그인하기</button>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>

</body>
</html>