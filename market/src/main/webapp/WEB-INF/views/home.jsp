<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.example.demo.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<title>홈</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/banner.css">
<link rel="stylesheet" href="./css/navbar.css">
</head>
<body style="padding-top:20px;">
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<!-- 각 페이지 변동 부분 시작 -->
	<!-- 배너 -->
	<section class="banner my-5 py-5">
		<div class="title">
			<h1>
				가장 가까운 플리마켓<br> <b>양배추마켓</b>
			</h1>
		</div>
	</section>
	<!-- 글 목록 -->
	<div class="best_list"></div>
	<!-- 각 페이지 변동 부분 끝 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>

<!-- load 함수로 동적 교체 -->
<script>
	$(".category").load("<c:url value='navbar' />");
</script>
<script>
	$(".best_list").load("<c:url value='best' />");
</script>
<script>
	function sort() {
		let order = $("#order").val();
		location.href = '${path}/home?page=${page}&order=' + order;
	}
</script>
</html>