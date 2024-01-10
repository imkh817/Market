<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<form action="lowest_naver"
		class="d-flex me-auto w-25 mx-auto" role="search" id="search"
		style="text-align: center;">
		<input class="form-control me-2 px-2" type="search"
			id="compare_product" name="compare_product"
			placeholder="최저가 비교할 물품명을 입력해주세요" aria-label="Search"
			style="border: 2px solid #47C83E; width: 100%;"> <i class="fa-solid fa-magnifying-glass fs-4 my-auto" style="color: #47C83E;"></i>
	</form>
	<br>
	<div class="lowest_price" align="center">
		<a href="lowest_baechu_form">양배추 마켓 최저가</a>&nbsp; &nbsp;|&nbsp; &nbsp;<a
			href="lowest_naver_form" style="color: #47C83E;">네이버 신제품 최저가</a>
	</div>


	<br>
	<br>


	<c:if test="${list != null }">
		<div class="d-flex justify-content-center my-3 py-3" align="center">
			<div class="row row-cols-1 row-cols-md-3" style="max-width: 800px;">
				<c:forEach var="list" items="${list}">
					<div class="col">
						<div class="card" style="border: none;">
						<a href="${list.link }">
							<img src="${list.image}" class="card-img-top mx-auto my-2" alt=""
								style="width: 200px; height: 200px;">
						</a>		
							<div class="card-body mx-1">
							<a href="${list.link }" style="text-decoration: none; color:#000">
								<p class="card-text lh-1">${list.title}</p>
								</a>
								<br>
								<a href="${list.link }" style="text-decoration: none; color:#000">
								<p class="card-text lh-1 fw-bold">${list.lprice}원</p>
								</a>
								<br> 
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
						href="lowest_naver?compare_product=${compare_product}&page=${page.startPage-1 }">Previous</a>
					</li>
				</c:if>
				<c:forEach begin="${page.startPage }" end="${page.endPage }"
					var="pageNum">
					<li class="page-item"><a class="page-link"
						href="lowest_naver?compare_product=${compare_product}&page=${pageNum }">${pageNum }</a></li>
				</c:forEach>

				<c:if test="${page.endPage < page.totalPage}">
					<li class="page-item"><a class="page-link"
						href="lowest_naver?compare_product=${compare_product}&page=${page.endPage+1}">Next</a></li>
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