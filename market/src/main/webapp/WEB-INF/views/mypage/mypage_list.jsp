<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row row-cols-1 row-cols-md-3" style="max-width: 768px; position: relative;">
				<c:forEach var="list" items="${list}">
					<div class="col">
						<div class="card" style="border: none;">
							<img src="../images/example.png"
								class="card-img-top mx-auto my-2" alt=""
								style="width: 200px; height: 200px;">
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

<div style="margin-bottom: 80px;"></div>
		<!-- 페이징 버튼 -->
		<nav aria-label="Page navigation example" style="position: absolute; bottom: 0; left: 50%; transform: translateX(-50%); background-color: white; z-index: 100;">
    <ul class="pagination justify-content-center">
        <c:if test="${page.startPage > page.pagePerBlk }">
            <li class="page-item"><a class="page-link" style="color: #47C83E;" href="mypage_form?page=${page.startPage-1}">Previous</a></li>
        </c:if>
        <c:forEach begin="${page.startPage}" end="${page.endPage}" var="pageNum">
            <li class="page-item"><a class="page-link" style="color: #47C83E;" href="mypage_form?page=${pageNum}">${pageNum}</a></li>
        </c:forEach>
        <c:if test="${page.endPage < page.totalPage}">
            <li class="page-item"><a class="page-link" style="color: #47C83E;" href="mypage_form?page=${page.startPage-1}">Next</a></li>
        </c:if>
    </ul>
</nav>

			</div>
