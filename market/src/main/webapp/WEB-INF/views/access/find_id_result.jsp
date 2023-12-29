<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<c:if test="${member == null}">
	<script>
	alert('회원 정보가 일치하지 않습니다!');
	history.go(-1);
	</script>
</c:if>
	
<body>
<section class="banner my-5 py-5">
	<div class="title">
		<h1>
			가장 가까운 플리마켓<br> <b>양배추마켓</b>
		</h1>
	</div>
</section>
<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
<div class="join-container text-center">
    <h2>${member.member_name}님의 아이디는</h2>
    <h2><span class="text-success">${member.member_id}</span>입니다.</h2>
</div>
<br>
<div  class="rounded fw-medium" style="width: 380px; height: 50px; background-color: #f0f0f0; border: 1px solid #ccc; padding: 10px; margin: 10px; text-align: center; margin-left: auto; margin-right: auto;">
    <span> 정보 보호를 위해 아이디의 일부만 보여집니다.</span>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp"%>
<script src="./js/join/join.js"></script>
</body>
</html>