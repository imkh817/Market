<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="col">
	<div class="card" style="border: none;">
		<img src="./images/example.png" class="card-img-top mx-auto my-3"
			alt="" style="width: 250px; height: 250px;">
		<div class="card-body mx-2">
			<h5 class="card-title">상품명</h5>
			<p class="card-text">판매가</p>
			<p class="card-text">
				<i class="fa-solid fa-location-dot"></i> <span>&nbsp;거래장소</span>
			</p>
			<div class="row">
				<p class="col card-text text-body-tertiary">
					<i class="fa-solid fa-eye"></i> <span>&nbsp;조회수</span>
				</p>
				<p class="col card-text text-body-tertiary">
					<i class="fa-solid fa-heart"></i> <span>&nbsp;관심</span>
				</p>
			</div>
		</div>
	</div>
</div>

	<%-- 		<c:forEach var="gd" items="${Goods}">
			<div class="col">
				<div class="card" style="border: none;">
					<img src="../images/example.png" class="card-img-top mx-auto my-3"
						alt="" style="width: 250px; height: 250px;">
					<div class="card-body mx-2">
						<h5 class="card-title">${gd.goods_name}</h5>
						<p class="card-text">${gd.goods_price}</p>
						<p class="card-text">
							<i class="fa-solid fa-location-dot"></i> <span>&nbsp;${gd.goods_place}</span>
						</p>
						<div class="row">
							<p class="col card-text text-body-tertiary">
								<i class="fa-solid fa-eye"></i> <span>&nbsp;${gd.goods_readcount}</span>
							</p>
							<p class="col card-text text-body-tertiary">
								<i class="fa-solid fa-heart"></i> <span>&nbsp;${gd.goods_liked_no}</span>
							</p>
						</div>
					</div>
				</div>
		</c:forEach> --%>