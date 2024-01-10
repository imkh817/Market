<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최저가 비교</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/banner.css">
<link rel="stylesheet" href="./css/navbar.css">
<style>
.lowest_price a {
	text-decoration: none; /* 밑줄 없애기 */
	color: #000; /* 기본 텍스트 색상 */
	transition: color 0.3s; /* 호버 시 색상 전환 애니메이션 */
}

.lowest_price a:hover {
	color: #47C83E; /* 호버 시 텍스트 색상 변경 */
}

.price {
	display: flex; /* Flexbox를 사용하여 자식 요소를 수평으로 배열합니다. */
	justify-content: space-between; /* 각 자식 요소 간에 공간을 균등하게 배분합니다. */
}

.
div {
	flex: 1; /* 자식 요소가 동일한 너비를 가지도록 합니다. */
	margin: 0 5px; /* 각 자식 요소 사이의 여백을 조절합니다. */
}

.price {
	display: flex;
	justify-content: space-between;
	max-width: 850px; /* 최대 너비를 설정 */
	margin: 0 auto; /* 가운데 정렬을 위해 margin 추가 */
}

.price div {
	flex: 1;
	margin: 0 5px;
}
</style>
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
	<div align="center">
		<h2>시세조회</h2>
		<h4>원하는 상품이 얼마에 거래되고 있는지 알아보세요</h4>
	</div>
	<br>
	<form action="lowest_baechu" method="post"
		class="d-flex me-auto w-25 mx-auto" role="search" id="search"
		style="text-align: center;">
		<input class="form-control me-2 px-2" type="search"
			id="compare_product" name="compare_product"
			placeholder="최저가 비교할 물품명을 입력해주세요" aria-label="Search"
			style="border: 2px solid #47C83E; width: 100%;"> <i
			class="fa-solid fa-magnifying-glass fs-4 my-auto"
			style="color: #47C83E;"></i>
	</form>
	<br>
	<div class="lowest_price mb-5" align="center">
		<a href="lowest_baechu_form" style="color: #47C83E;">양배추 마켓 최저가</a>&nbsp;
		&nbsp;|&nbsp; &nbsp;<a href="lowest_naver_form">네이버 신제품 최저가</a>
	</div>

	<c:if test="${list != null }">
		<br>
		<br>
		<div
			style="border: 1px solid #008000; background-color: #E0FFE0; padding: 10px; margin: 10px auto; max-width: 700px;"
			class="rounded-4 shadow p-3 mb-5 bg-body-tertiary rounded">
			<div class="price" align="center">
				<div class="fw-bolder opacity-75">평균 가격이에요</div>
				<div class="fw-semibold opacity-75">가장 높은 가격이에요</div>
				<div class="fw-bolder opacity-75">가장 낮은 가격이에요</div>
			</div>
			<br>
			<div class="price" align="center">
				<div>
					<span>평균 </span><span class="fs-4 fw-bolder opacity-75">${compare_price.avg_price}원</span>
				</div>
				<div>
					<span class="text-danger">최고 </span><span
						class="text-danger fs-4 fw-bolder opacity-75">${compare_price.high_price}원</span>
				</div>
				<div>
					<span class="text-primary">최저 </span> <span
						class="text-primary fs-4 fw-bolder opacity-75">${compare_price.low_price}원</span>
				</div>
			</div>
		</div>

		
		<div class="container mb-3" style="max-width: 768px">
		<div class="row d-flex row-cols-1 row-cols-md-3">
			<c:forEach var="list" items="${list}">
				<div class="col">
					<div class="card text-center" style="border: none;">
						<a href="detail?goods_no=${list.goods_no}">
							<img src="./upload/${list.goods_image}" class="card-img-top my-2"
							alt="" style="width: 200px; height: 200px;">
						</a>
						<div class="card-body mx-1 px-0">
							<p class="card-text text-start mx-3 px-1 lh-1" style="font-size: 0.9rem;">
								<c:set var="truncated_sub"
									value="${fn:substring(list.goods_name, 0, 12)}" />
								<a href="detail?goods_no=${list.goods_no}"
									style="text-decoration: none; color: black;"> <c:if
										test="${fn:trim(list.goods_state)=='2'}">
										<span class="badge bg-warning my-auto"
											style="font-size: 0.6rem;">예약중</span>
									</c:if> <c:if test="${fn:trim(list.goods_state)=='3'}">
										<span class="badge bg-secondary my-auto"
											style="font-size: 0.6rem;">판매완료</span>
									</c:if> ${truncated_sub}
								</a>
								<c:if test="${fn:length(list.goods_name)>12}">...</c:if>
							</p>
							<p class="card-text text-start mx-3 px-1 lh-1 fw-bold">${list.goods_price}</p>
							<p class="card-text text-start mx-3 px-1 lh-1"
								style="font-size: 0.8rem;">
								<i class="fa-solid fa-location-dot"></i> <span>&nbsp;${list.goods_place}</span>
							</p>
							<div class="row">
								<p class="col card-text text-body-tertiary lh-1"
									style="font-size: 0.8rem;">
									<i class="fa-solid fa-eye"></i> <span>&nbsp;${list.goods_readcount}</span>
								</p>
								<p class="col card-text text-body-tertiary lh-1"
									style="font-size: 0.8rem;">
									<i class="fa-solid fa-heart"></i> <span>&nbsp;${list.liked.liked_no}</span>
								</p>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
		
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<c:if test="${page.startPage > page.pagePerBlk }">
					<li class="page-item"><a class="page-link"
						href="lowest_baechu?compare_product=${compare_product}&page=${page.startPage-1 }">Previous</a>
					</li>
				</c:if>
				<c:forEach begin="${page.startPage }" end="${page.endPage }"
					var="pageNum">
					<li class="page-item"><a class="page-link"
						href="lowest_baechu?compare_product=${compare_product}&page=${pageNum }">${pageNum }</a></li>
				</c:forEach>

				<c:if test="${page.endPage < page.totalPage}">
					<li class="page-item"><a class="page-link"
						href="lowest_baechu?compare_product=${compare_product}&page=${page.endPage+1}">Next</a></li>
				</c:if>
			</ul>
		</nav>
	</c:if>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
<!-- load 함수로 동적 교체 -->
<script>
	$(".category").load("<c:url value='navbar' />");
</script>
</html>