<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>홈</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/banner.css">
</head>
<body class="my-5 py-5">
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<!-- 각 페이지 변동 부분 시작 -->
	<%@ include file="/WEB-INF/views/main_list.jsp"%>
	<!-- 각 페이지 변동 부분 끝 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
<!-- load 함수로 동적 교체 -->
<script>
	$(".list_content").load("<c:url value='list' />");
</script>
</html>