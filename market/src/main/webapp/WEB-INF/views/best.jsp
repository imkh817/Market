<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="d-flex justify-content-center my-3 py-3">
	<h3 class="fw-bold">중고거래 인기매물</h3>
</div>

<div class="d-flex justify-content-center my-3 py-3">
	<div class="row row-cols-1 row-cols-md-3" style="max-width: 768px;">
		<c:forEach var="gd" items="${goods_list}" varStatus="status">
			<div class="col">
				<div class="card" style="border: none;">
					<p class="card-text lh-1 mx-auto fw-bold">TOP ${status.count}</p>
					<img src="./upload/${gd.goods_image}"
						class="card-img-top mx-auto my-2" alt=""
						style="width: 200px; height: 200px;">
					<div class="card-body mx-1">
						<p class="card-text lh-1">
							<c:set var="truncated_sub"
								value="${fn:substring(gd.goods_name, 0, 12)}" /><a href="detail?goods_no=${gd.goods_no }" style="text-decoration: none; color: black;">${truncated_sub}</a><c:if
								test="${fn:length(gd.goods_name)>12}">...</c:if>
						</p>
						<p class="card-text lh-1 fw-bold">${gd.goods_price}</p>
						<p class="card-text lh-1" style="font-size: 0.8rem;">
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

<div class="d-flex justify-content-center mb-5">
	<a href="board" class="text-decoration-underline text-dark fw-bold"><p>중고거래
			매물 더보기</p> </a>
</div>