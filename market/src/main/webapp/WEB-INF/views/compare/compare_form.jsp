<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최저가 비교</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/banner.css">
</head>
<body>
<section class="banner my-5 py-5">
	<div class="title">
		<h1>
			가장 가까운 플리마켓<br> <b>양배추마켓</b>
		</h1>
	</div>
</section>
<%@ include file="/WEB-INF/views/include/navbar.jsp"%>


<form action="compare" method="post" class="d-flex me-auto w-50 mx-auto" role="search" id="search">
    <input class="form-control me-2 px-5" type="search" id="compare_product" name="compare_product"
           placeholder="최저가 비교할 물품명을 입력해주세요" aria-label="Search"
           style="border-color: #21F11C;">
    <i class="fa-solid fa-magnifying-glass"
       style="position: absolute; transform: translate(60%, 70%); color: #21F11C;"></i>
</form>
<br><br><br><br>


	<c:if test="${list != null }">
		<div class="container">
			<div class="row">
				<c:forEach var="list" items="${list}" varStatus="loopStatus">
					<div class="col-2" align="center" style="border: 1px solid #ddd; padding: 10px;">
						<div>
							<a href="${list.link}" class="thumb" target="_blank"
								style="text-decoration: none; color: #000;"><img
								src="${list.image}" width="120" height="120"
								alt="${list.title }
								onerror="shp_no_image(this, 'bg_nimg');"></a>
						</div>
						<div>
							<a href="${list.link}" class="title"
								target="_blank" style="text-decoration: none; color: #000;">${list.title } </a>
						</div>
						<div class="price_area">
							<div class="price">
								<strong>최저 ${list.lprice}</strong>원
							</div>
						</div>
					</div>
					<c:if test="${loopStatus.index == 5 }">
					 <br><br><br><!-- 항상 새로운 행 시작 -->
					</c:if>
				</c:forEach>
			</div>
			<br><br>
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<c:if test="${page.startPage > page.pagePerBlk }">
						<li class="page-item"><a class="page-link"
							href="compare?compare_product=${compare_product}&page=${page.startPage-1 }">Previous</a>
						</li>
					</c:if>
					<c:forEach begin="${page.startPage }" end="${page.endPage }"
						var="pageNum">
						<li class="page-item"><a class="page-link"
							href="compare?compare_product=${compare_product}&page=${pageNum }">${pageNum }</a></li>
					</c:forEach>

					<c:if test="${page.endPage < page.totalPage}">
						<li class="page-item"><a class="page-link"
							href="compare?compare_product=${compare_product}&page=${page.endPage+1}">Next</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
	</c:if>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>