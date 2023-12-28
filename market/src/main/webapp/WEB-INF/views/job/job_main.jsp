<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알바 게시판</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/alba_banner.css">
<link rel="stylesheet" href="./css/job_button.css">
</head>
<body>

<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<section class="banner my-5 py-5">
		<div class="title">
			<h1>
				우리 동네, 나의 일자리<br> <b>양배추마켓</b>
			</h1>
		</div>
	</section>
	
<div class="d-flex justify-content-center my-3 py-3">
	<h3 class="fw-bold">우리 동네 알바</h3>
</div>

<div class="position-relative"> <!-- 부모 요소에 position: relative; 추가 -->
	<button class="green-border-button write-button" onClick="location.href='job_insert_form'">글 작성</button>

<div class="row row-cols-1 row-cols-md-3 d-flex justify-content-center" style="max-width: 768px; position: relative; margin: 0 auto;">
				<c:forEach var="list" items="${list}">
					<div class="col">
						<div class="card" style="border: none;">
							<img src="../images/example.png"
								class="card-img-top mx-auto my-2" alt=""
								style="width: 200px; height: 200px;">
							<div class="card-body mx-1">
								<p class="card-text lh-1">${list.job_title}</p>
								<p class="card-text lh-1 fw-bold">${list.job_price}</p>
								<p class="card-text lh-1" style="font-size: 0.8rem;">
									<i class="fa-solid fa-location-dot"></i> <span>&nbsp;${list.job_place}</span>
								</p>
								<div class="row">
									<p class="col card-text text-body-tertiary lh-1"
										style="font-size: 0.8rem;">
										<i class="fa-solid fa-eye"></i> <span>&nbsp;${list.member_no}</span>
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
            <li class="page-item"><a class="page-link" style="color: #47C83E;" href="job_main?page=${page.startPage-1}">Previous</a></li>
        </c:if>
        <c:forEach begin="${page.startPage}" end="${page.endPage}" var="pageNum">
            <li class="page-item"><a class="page-link" style="color: #47C83E;" href="job_main?page=${pageNum}">${pageNum}</a></li>
        </c:forEach>
        <c:if test="${page.endPage < page.totalPage}">
            <li class="page-item"><a class="page-link" style="color: #47C83E;" href="job_main?page=${page.startPage-1}">Next</a></li>
        </c:if>
    </ul>
</nav>
</div>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>