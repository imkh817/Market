<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>위치인증</title>
<!-- <style>
.map_wrap {
	position: relative;
	width: 100%;
	height: 350px;
}

.title {
	font-weight: bold;
	display: block;
}

.hAddr {
	position: absolute;
	left: 10px;
	top: 10px;
	border-radius: 2px;
	background: #fff;
	background: rgba(255, 255, 255, 0.8);
	z-index: 1;
	padding: 5px;
}

#centerAddr {
	display: block;
	margin-top: 2px;
	font-weight: normal;
}

.bAddr {
	padding: 5px;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}
</style> -->
<%@ include file="/WEB-INF/views/include/header.jsp"%>
</head>
<body class="my-5 py-5">
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<!-- 각 페이지 변동 부분 시작 -->
	<%@ include file="/WEB-INF/views/location.jsp"%>
	<!-- 각 페이지 변동 부분 끝 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>