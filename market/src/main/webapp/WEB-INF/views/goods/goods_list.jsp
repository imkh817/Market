<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="d-flex justify-content-center my-3 py-3">
	<div class="row row-cols-1 row-cols-md-3" style="max-width: 768px;">
		<c:forEach var="gd" items="${goods_list}">
			<div class="col">
				<div class="card" style="border: none;">
					<img src="../images/example.png" class="card-img-top mx-auto my-2"
						alt="" style="width: 200px; height: 200px;">
					<div class="card-body mx-1">
						<p class="card-text lh-1">${gd.goods_name}</p>
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
								<i class="fa-solid fa-heart"></i> <span>&nbsp;관심</span>
							</p>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>