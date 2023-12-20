<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container-sm mx-5 px-5 my-5 py-5">
	<div class="row row-cols-1 row-cols-md-4 g-4">

<%-- 		<c:forEach var="item" items=""> --%>
			<div class="col">
				<div class="card" style="border: none;">
					<img src="../images/example.png" class="card-img-top mx-auto my-3"
						alt="" style="width: 250px; height: 250px;">
					<div class="card-body mx-2">
						<h5 class="card-title">상품명</h5>
						<p class="card-text">판매가격</p>
						<p class="card-text">
							<i class="fa-solid fa-location-dot"></i>&nbsp;거래장소
						</p>
						<div class="row">
							<p class="col card-text">
								<i class="fa-solid fa-eye"></i>&nbsp;조회
							</p>
							<p class="col card-text">
								<i class="fa-solid fa-heart"></i>&nbsp;찜
							</p>
						</div>
					</div>
				</div>
<%-- 		</c:forEach> --%>

	</div>
</div>