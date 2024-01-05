<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알바 게시판</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/alba_banner.css">
<link rel="stylesheet" href="./css/job_button.css">
<link rel="stylesheet" href="./css/navbar.css">
</head>
<body style="padding-top: 20px;">

	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<section class="banner my-5 py-5">
		<div class="title">
			<h1>
				우리 동네, 나의 일자리<br> <b>양배추마켓</b>
			</h1>
		</div>
	</section>

	<div class="d-flex justify-content-center my-2 py-2">
		<h3 class="fw-bold">우리 동네 알바</h3>
	</div>

	<div class="d-flex justify-content-end mb-5 col-md-9">
		<c:if test="${member_id != null }">
			<button class="green-border-button write-button"
				onClick="location.href='job_insert_form'">글 작성</button>
		</c:if>
	</div>

	<div class="row row-cols-2 d-flex justify-content-center"
		style="max-width: 840px; position: relative; margin: 0 auto;">
		<c:forEach var="list" items="${list}">
			<div class="card mb-3" style="border: none; max-width: 420px;">
				<div class="row g-0">
					<div class="col-md-4">
						<div class="mx-auto">
							<a href="job_detail?job_no=${list.job_no}"> <img
								src="./upload/${list.job_image}" alt=""
								style="width: 120px; height: 120px;">
							</a>
						</div>
					</div>
					<div class="col-md-8">
						<div class="card-body">
							<p class="card-title">
								<c:set var="truncated_sub"
									value="${fn:substring(list.job_title, 0, 15)}" />
								<a href="job_detail?job_no=${list.job_no}"
									style="text-decoration: none; color: black;">${truncated_sub}</a>
								<c:if test="${fn:length(list.job_title)>15}">...</c:if>
							</p>
							<p class="card-text fw-bold">시급 ${list.job_price}원</p>
							<p class="card-text " style="font-size: 0.8rem;">
								<c:set var="truncated_place"
									value="${fn:substring(list.job_place, 0, 18)}" />
								<i class="fa-solid fa-location-dot"></i> <span>&nbsp;${truncated_place}</span>
								<c:if test="${fn:length(list.job_place)>18}">...</c:if>
							</p>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>

		<div style="margin-bottom: 80px;"></div>
		<!-- 페이징 버튼 -->
		<nav aria-label="Page navigation example"
			style="position: relative; margin-top: 20px; text-align: center; bottom: 0; transform: translateX(-50%); background-color: white; z-index: 100;">
			<ul class="pagination justify-content-center">
				<c:if test="${page.startPage > page.pagePerBlk }">
					<li class="page-item"><a class="page-link"
						style="color: #47C83E;" href="job_main?page=${page.startPage-1}">Previous</a></li>
				</c:if>
				<c:forEach begin="${page.startPage}" end="${page.endPage}"
					var="pageNum">
					<li class="page-item"><a class="page-link"
						style="color: #47C83E;" href="job_main?page=${pageNum}">${pageNum}</a></li>
				</c:forEach>
				<c:if test="${page.endPage < page.totalPage}">
					<li class="page-item"><a class="page-link"
						style="color: #47C83E;" href="job_main?page=${page.startPage-1}">Next</a></li>
				</c:if>
			</ul>
		</nav>
	</div>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
<!-- load 함수로 동적 교체 -->
<script>
	$(".category").load("<c:url value='navbar' />");
</script>
</html>