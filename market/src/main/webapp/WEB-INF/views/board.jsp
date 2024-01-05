<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.example.demo.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>홈</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/banner.css">
<link rel="stylesheet" href="./css/pagination.css">
<link rel="stylesheet" href="./css/navbar.css">
<!-- 게시판 정렬 -->
<script>
	function sort() {
		var order = $("#order").val();
		location.href = "${path}/board?category=${category}&keyword=${keyword}&order="
				+ order;
	}
</script>
</head>
<body style="padding-top: 20px;">
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<!-- 배너 -->
	<section class="banner my-5 py-5">
		<div class="title">
			<h1>
				가장 가까운 플리마켓<br> <b>양배추마켓</b>
			</h1>
		</div>
	</section>

	<!-- 정렬 아이콘 -->
	<div class="container mb-3" style="max-width: 768px">
		<div class="row d-flex">
			<a class="col-auto ps-4 me-auto"
				onClick="location.replace(location.href)"> <i
				class="p-2 fs-4 fa-solid fa-rotate-right" style="color: #21F11C;"></i>
			</a>
			<div class="col-auto me-5">
				<div class="row">
					<i class="col p-2 fs-4 fa-solid fa-bars"></i> <select
						class="col form-select mx-auto my-auto" id="order" name="order"
						onchange="sort()"
						style="border: none; font-size: 15px; font-weight: bold; width: 100px;">
						<option value="regdate"
							<c:if test="${order == 'regdate'}">${'selected'}</c:if>>최신순</option>
						<option value="readcount"
							<c:if test="${order == 'readcount'}">${'selected'}</c:if>>인기순</option>
					</select>
				</div>
			</div>
		</div>
	</div>

	<!-- 글 목록 -->
	<div class="container mb-3" style="max-width: 768px">
		<div class="row d-flex row-cols-1 row-cols-md-3">
			<c:set var="no" value="${listcount-(page-1)*12}" />
			<c:forEach var="gd" items="${goods_list}">
				<div class="col">
					<div class="card text-center" style="border: none;">
						<a href="detail?goods_no=${gd.goods_no}&page=${page}&state=cont">
							<img src="./upload/${gd.goods_image}" class="card-img-top my-2"
							alt="" style="width: 200px; height: 200px;">
						</a>
						<div class="card-body mx-1 px-0">
							<p class="card-text text-start mx-3 px-1 lh-1" style="font-size: 0.9rem;">
								<c:set var="truncated_sub"
									value="${fn:substring(gd.goods_name, 0, 12)}" />
								<a href="detail?goods_no=${gd.goods_no}"
									style="text-decoration: none; color: black;"> <c:if
										test="${fn:trim(gd.goods_state)=='2'}">
										<span class="badge bg-warning my-auto"
											style="font-size: 0.6rem;">예약중</span>
									</c:if> <c:if test="${fn:trim(gd.goods_state)=='3'}">
										<span class="badge bg-secondary my-auto"
											style="font-size: 0.6rem;">판매완료</span>
									</c:if> ${truncated_sub}
								</a>
								<c:if test="${fn:length(gd.goods_name)>12}">...</c:if>
							</p>
							<p class="card-text text-start mx-3 px-1 lh-1 fw-bold">${gd.goods_price}</p>
							<p class="card-text text-start mx-3 px-1 lh-1"
								style="font-size: 0.8rem;">
								<i class="fa-solid fa-location-dot"></i> <span>&nbsp;${gd.goods_place}</span>
							</p>
							<div class="row">
								<p class="col card-text text-body-tertiary lh-1"
									style="font-size: 0.8rem;">
									<i class="fa-solid fa-eye"></i> <span>&nbsp;${gd.goods_readcount}</span>
								</p>
								<p class="col card-text text-body-tertiary lh-1"
									style="font-size: 0.8rem;">
									<i class="fa-solid fa-heart"></i> <span>&nbsp;${gd.liked.liked_no}</span>
								</p>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- 페이지네이션 -->
	<div class="container d-flex justify-content-center my-3">
		<ul class="pagination">
			<c:if test="${category == null}">
				<c:if test="${keyword == null}">
					<c:if test="${order == null}">
						<c:if test="${page>1}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?page=${page-1}">이전</a></li>
						</c:if>
						<c:forEach var="i" begin="${startpage}" end="${endpage}">
							<li class="page-item <c:if test="${page==i}">active</c:if>"><a
								class="page-link" href="${path}/board?page=${i}">${i}</a></li>
						</c:forEach>
						<c:if test="${page<maxpage}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?page=${page+1}">다음</a></li>
						</c:if>
					</c:if>
					<c:if test="${order != null}">
						<c:if test="${page>1}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?order=${order}&page=${page-1}">이전</a></li>
						</c:if>
						<c:forEach var="i" begin="${startpage}" end="${endpage}">
							<li class="page-item <c:if test="${page==i}">active</c:if>"><a
								class="page-link" href="${path}/board?order=${order}&page=${i}">${i}</a></li>
						</c:forEach>
						<c:if test="${page<maxpage}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?order=${order}&page=${page+1}">다음</a></li>
						</c:if>
					</c:if>
				</c:if>
				<c:if test="${keyword != null}">
					<c:if test="${order == null}">
						<c:if test="${page>1}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?keyword=${keyword}&page=${page-1}">이전</a></li>
						</c:if>
						<c:forEach var="i" begin="${startpage}" end="${endpage}">
							<li class="page-item <c:if test="${page==i}">active</c:if>"><a
								class="page-link"
								href="${path}/board?keyword=${keyword}&page=${i}">${i}</a></li>
						</c:forEach>
						<c:if test="${page<maxpage}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?keyword=${keyword}&page=${page+1}">다음</a></li>
						</c:if>
					</c:if>
					<c:if test="${order != null}">
						<c:if test="${page>1}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?keyword=${keyword}&order=${order}&page=${page-1}">이전</a></li>
						</c:if>
						<c:forEach var="i" begin="${startpage}" end="${endpage}">
							<li class="page-item <c:if test="${page==i}">active</c:if>"><a
								class="page-link"
								href="${path}/board?keyword=${keyword}&order=${order}&page=${i}">${i}</a></li>
						</c:forEach>
						<c:if test="${page<maxpage}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?keyword=${keyword}&order=${order}&page=${page+1}">다음</a></li>
						</c:if>
					</c:if>
				</c:if>
			</c:if>
			<c:if test="${category != null}">
				<c:if test="${keyword == null}">
					<c:if test="${order == null}">
						<c:if test="${page>1}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?category=${category}&page=${page-1}">이전</a></li>
						</c:if>
						<c:forEach var="i" begin="${startpage}" end="${endpage}">
							<li class="page-item <c:if test="${page==i}">active</c:if>"><a
								class="page-link"
								href="${path}/board?category=${category}&page=${i}">${i}</a></li>
						</c:forEach>
						<c:if test="${page<maxpage}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?category=${category}&page=${page+1}">다음</a></li>
						</c:if>
					</c:if>
					<c:if test="${order != null}">
						<c:if test="${page>1}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?category=${category}&order=${order}&page=${page-1}">이전</a></li>
						</c:if>
						<c:forEach var="i" begin="${startpage}" end="${endpage}">
							<li class="page-item <c:if test="${page==i}">active</c:if>"><a
								class="page-link"
								href="${path}/board?category=${category}&order=${order}&page=${i}">${i}</a></li>
						</c:forEach>
						<c:if test="${page<maxpage}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?category=${category}&order=${order}&page=${page+1}">다음</a></li>
						</c:if>
					</c:if>
				</c:if>
				<c:if test="${keyword != null}">
					<c:if test="${order == null}">
						<c:if test="${page>1}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?category=${category}&keyword=${keyword}&page=${page-1}">이전</a></li>
						</c:if>
						<c:forEach var="i" begin="${startpage}" end="${endpage}">
							<li class="page-item <c:if test="${page==i}">active</c:if>"><a
								class="page-link"
								href="${path}/board?category=${category}&keyword=${keyword}&page=${i}">${i}</a></li>
						</c:forEach>
						<c:if test="${page<maxpage}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?category=${category}&keyword=${keyword}&page=${page+1}">다음</a></li>
						</c:if>
					</c:if>
					<c:if test="${order != null}">
						<c:if test="${page>1}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?category=${category}&keyword=${keyword}&order=${order}&page=${page-1}">이전</a></li>
						</c:if>
						<c:forEach var="i" begin="${startpage}" end="${endpage}">
							<li class="page-item <c:if test="${page==i}">active</c:if>"><a
								class="page-link"
								href="${path}/board?category=${category}&keyword=${keyword}&order=${order}&page=${i}">${i}</a></li>
						</c:forEach>
						<c:if test="${page<maxpage}">
							<li class="page-item"><a class="page-link"
								href="${path}/board?category=${category}&keyword=${keyword}&order=${order}&page=${page+1}">다음</a></li>
						</c:if>
					</c:if>
				</c:if>
			</c:if>
		</ul>
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
<!-- load 함수로 동적 교체 -->
<script>
	$(".category").load("<c:url value='navbar' />");
</script>
</html>