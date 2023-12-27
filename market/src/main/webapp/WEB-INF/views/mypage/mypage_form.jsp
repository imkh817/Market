<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>mypage_form</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/banner.css">
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
	
	<%@ include file="/WEB-INF/views/include/user_profile.jsp"%>

	<div class="d-flex flex-row justify-content-center mx-auto">
		<div class="col-3">

			<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

		</div>
		<div class="col-9">

			<%@ include file="/WEB-INF/views/mypage/mypage_list.jsp"%>

		</div>
	</div>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>