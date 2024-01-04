<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<script>
var url = window.location.pathname;

$('.nav-item').find('a').each(function(){
	$(this).toggleClass('active', $(this).attr('href')==url);
});
</script>
<link rel="stylesheet" href="./css/pagination.css">
<link rel="stylesheet" href="./css/navbar.css">
</head>
<body style="padding-top: 20px;">
	<!-- 상단 내비바 -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

	<!-- 프로필 정보 및 통계 영역 -->
	<div class="mx-auto my-3 py-3" style="max-width: 768px;">
		<div
			class="container p-4 mb-3 bg-body-tertiary shadow rounded rounded-4">
			<div class="row">
				<div class="col my-auto text-center">
					<p class="fs-4 fw-bold mb-2">#${member_nickname}</p>
					<img src="./images/picture.png" class="img-fluid" alt="프로필 이미지"
						style="width: 100px; height: 100px;">
				</div>
				<div class="col my-auto text-center pt-3">
					<i class="fa-solid fa-gift fs-1 mb-2" style="color: #5ba95d;"></i>
					<p class="fs-5">판매 ${sell_count}</p>
				</div>
				<div class="col my-auto text-center pt-3">
					<i class="fa-solid fa-heart fs-1 mb-2" style="color: #e84a62;"></i>
					<p class="fs-5">좋아요 ${liked_count}</p>
				</div>
			</div>
		</div>

		<div class="d-flex justify-content-center my-3 py-3">
			<ul class="nav nav-underline gap-5">
				<li class="nav-item"><a class="nav-link" aria-current="page"
					href="mypage_list" style="color: #47C83E;">판매 내역</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_liked_form" style="color: #47C83E;">관심 상품</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_update_form" style="color: #47C83E;">회원 탈퇴</a></li>
			</ul>
		</div>
	</div>

	<div class="mx-auto my-3 py-3" style="max-width: 768px;">
		<div class="container row row-cols-1 row-cols-md-3"
			style="max-width: 768px; position: relative;">
			<c:forEach var="list" items="${list}">
				<div class="col">
					<div class="card" style="border: none;">
						<img src="../images/example.png" class="card-img-top mx-auto my-2"
							alt="" style="width: 200px; height: 200px;">
						<div class="card-body mx-1">
							<p class="card-text lh-1">${list.goods_name}</p>
							<p class="card-text lh-1 fw-bold">${list.goods_price}</p>
							<p class="card-text lh-1" style="font-size: 0.8rem;">
								<i class="fa-solid fa-location-dot"></i> <span>&nbsp;${list.goods_place}</span>
							</p>
							<div class="row">
								<p class="col card-text text-body-tertiary lh-1"
									style="font-size: 0.8rem;">
									<i class="fa-solid fa-eye"></i> <span>&nbsp;${list.goods_readcount}</span>
								</p>
								<p class="col card-text text-body-tertiary lh-1"
									style="font-size: 0.8rem;">
									<i class="fa-solid fa-heart"></i> <span>&nbsp;관심</span>
								</p>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>

			<!-- 페이징 버튼 -->
			<div class="container d-flex justify-content-center mt-3 pt-3">
				<ul class="pagination">
					<c:if test="${page.startPage > page.pagePerBlk }">
						<li class="page-item"><a class="page-link"
							href="mypage_list?page=${page.startPage-1}">Previous</a></li>
					</c:if>
					<c:forEach begin="${page.startPage}" end="${page.endPage}"
						var="pageNum">
						<li
							class="page-item <c:if test="${page.currentPage==pageNum}">active</c:if>"><a
							class="page-link" href="mypage_list?page=${pageNum}">${pageNum}</a></li>
					</c:forEach>
					<c:if test="${page.endPage < page.totalPage}">
						<li class="page-item"><a class="page-link"
							href="mypage_list?page=${page.startPage-1}">Next</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>

	<!-- 하단 내비바 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
<!-- load 함수로 동적 교체 -->
<script>
	$(".category").load("<c:url value='navbar' />");
</script>
</html>