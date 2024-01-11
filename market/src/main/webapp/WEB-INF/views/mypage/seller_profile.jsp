<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>판매자 상품페이지</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/pagination.css">
<link rel="stylesheet" href="./css/navbar.css">
</head>
<body class="my-5 py-5">
	<!-- 상단 내비바 -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

	<!-- 프로필 정보 및 통계 영역 -->
	<div class="mx-auto my-3 py-3" style="max-width: 768px;">
		<div
			class="container p-4 mb-3 bg-body-tertiary shadow rounded rounded-4">
			<div class="row">
				<div class="col my-auto text-center">
						<p class="fs-4 fw-bold mb-2">#${member.member_nickname}</p>
						<c:if test="${member.member_image == null }">
							<img src="./images/user.png" class="img_preview rounded-circle"
								style="width: 100px; height: 100px;" />
						</c:if>
						<c:if test="${member.member_image != null }">
							<img src="./upload/${member.member_image }"
								class="img_preview rounded-circle" alt="프로필 이미지"
								style="width: 100px; height: 100px;">
						</c:if>
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
	</div>

	<div class="mx-auto my-3 py-3" style="max-width: 768px;">
		<div class="container row row-cols-1 row-cols-md-3"
			style="max-width: 768px; position: relative;">
			<c:forEach var="list" items="${list}">
				<div class="col">
					<div class="card" style="border: none;">

					<a href="detail?goods_no=${list.goods_no}">
						<img src="./upload/${list.goods_image}"
							class="card-img-top mx-auto my-2" alt=""
							style="width: 200px; height: 200px;"></a>
						<div class="card-body mx-1">
							<p class="card-text lh-1">
								<a href="detail?goods_no=${list.goods_no}"
									style="text-decoration: none; color: black;">${list.goods_name}</a>
							</p>
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
									<i class="fa-solid fa-heart"></i> <span>&nbsp;${heart_count }</span>
								</p>
								<div class="btn-group dropup">
									<button type="button" class="btn dropdown-toggle"
										data-bs-toggle="dropdown" aria-expanded="false"
										style="background-color: #47C83E">
										<c:if test="${list.goods_state == 1}">
											<span style="color: white;">판매중</span>
										</c:if>
										<c:if test="${list.goods_state == 2}">
											<span style="color: white;">예약중</span>
										</c:if>
										<c:if test="${list.goods_state == 3}">
											<span style="color: white;">판매완료</span>
										</c:if>
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>

			</c:forEach>
			<!-- 페이징 버튼 -->
		</div>
		<c:forEach var="list" items="${list}" end="0">
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
							class="page-link"
							href="seller_profile?goods_no=${list.goods_no }&member_no=${list.member_no }&page=${pageNum}">${pageNum}</a></li>
					</c:forEach>
					<c:if test="${page.endPage < page.totalPage}">
						<li class="page-item"><a class="page-link"
							href="seller_profile?goods_no=${list.goods_no }&member_no=${list.member_no }&page=${page.startPage-1}">Next</a></li>
					</c:if>
				</ul>
			</div>
		</c:forEach>
	</div>
	<!-- 하단 내비바 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>