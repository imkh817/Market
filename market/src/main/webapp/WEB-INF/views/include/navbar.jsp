<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:url var="chat_link"
	value="${sessionScope.member_no == null ? 'login_form' : 'message_list'}">
	<c:param name="member_no" value="20" />
	<c:param name="session_member_no" value="${sessionScope.member_no}" />
</c:url> 
<c:set var="join"
	value="${sessionScope.member_id==null ? '회원가입' : '마이페이지'}" />
<c:set var="join_link"
	value="${sessionScope.member_id==null ? 'join_form' : 'mypage_list'}" />
<c:set var="loginout"
	value="${sessionScope.member_id==null ? '로그인' : '로그아웃'}" />
<c:set var="loginout_link"
	value="${sessionScope.member_id==null ? 'login_form' : '/logout'}" />
<nav class="navbar navbar-expand-lg fixed-top"
	style="background-color: #fff">
	<div class="container-fluid ms-5 my-auto">
		<div class="btn-group">
			<button class="btn btn-sm dropdown-toggle" type="button"
				data-bs-toggle="dropdown" aria-expanded="false"
				style="color: #47C83E; font-size: 20px;"></button>
			<div class="category">
				<ul class="dropdown-menu" style="font-size: 13px;">
					<c:forEach var="cg" items="${cg_list}">
						<li class="dropdown-item"><a
							href="${path}/board?category=${cg.category_no}"
							style="text-decoration: none; color: #333;"> ${cg.category_name} </a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<a class="navbar-brand fs-3 ms-3" href="home"><div
				class="hstack gap-2">
				<img src="./images/cabbage.png" width="40px" height="40px">
				<p class="fw-bold my-auto fs-3">양배추마켓</p>
			</div></a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbar_toggler" aria-controls="navbar_toggler"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse ms-3" id="navbar_toggler">
			<form class="d-flex me-auto w-40" 
				action="${path}/board?category=${category}&keyword=${keyword}" role="search">
				<input class="form-control mx-1 px-5 my-auto" id="keyword"
					name="keyword" type="search" placeholder="어떤 상품을 찾으시나요?"
					aria-label="Search"
					style="position: relative; border: 2px solid #47C83E; font-size: 13px; width: 330px;"><i
					class="fa-solid fa-magnifying-glass"
					style="position: absolute; transform: translate(80%, 60%); color: #47C83E;"></i>
			</form>
			<ul class="navbar-nav me-auto mb-2">
				<li class="nav-item px-2 fs-2 me-4 my-auto"><a class="sell"
					href="<c:url value='lowest_baechu_form'/>"
					style="color: inherit; text-decoration: none;"><div
							class="hstack gap-2">
							<i class="fa-solid fa-chart-simple"></i>
							<p class="my-auto" style="font-size: 13px">최저가 비교</p>
						</div></a></li>
				<li class="nav-item px-2 fs-2 me-3 my-auto"><a class="sell"
					href="<c:url value='job_main'/>"
					style="color: inherit; text-decoration: none;"><div
							class="hstack gap-2">
							<i class="fa-solid fa-person-running"></i>
							<p class="my-auto" style="font-size: 13px">알바</p>
						</div></a></li>
				<li class="nav-item px-2 fs-2 me-4 my-auto"><a class="chat"
					href="<c:url value='${chat_link}'/>"
					style="color: inherit; text-decoration: none;"><div
							class="hstack gap-2">
							<i class="fa-regular fa-comment-dots" style="position: relative;"></i>
							<span style="background-color: #47C83E; color: #fff; font-weight: bold; font-size: 10px; border-radius: 5px;
							padding-left: 5px; padding-right: 5px; position: absolute; transform: translate(150%, -70%);">
								${sessionScope.unread_msg}</span>
							<p class="my-auto" style="font-size: 13px">채팅하기</p>
						</div></a></li>
				<li class="nav-item px-2 fs-2 me-4 my-auto"><a class="sell"
					href="sell_form"
					style="color: inherit; text-decoration: none;"><div
							class="hstack gap-2">
							<i class="fa-solid fa-money-check-dollar"></i>
							<p class="my-auto" style="font-size: 13px">판매하기</p>
						</div></a></li>
				<li class="nav-item px-2 me-2 fs-2 my-auto">
					<div class="dropdown">
						<div data-bs-toggle="dropdown" aria-expanded="false"
							style="position: relative;">
							<div class="hstack gap-2">
								<i class="fa-solid fa-user"></i>
								<p class="my-auto fw-bolder" style="font-size: 13px">${sessionScope.member_nickname}</p>
							</div>
						</div>
						<ul class="dropdown-menu"
							style="font-size: 13px; position: absolute; transform: translate(-20%, -20%);">
							<li><a class="dropdown-item border-bottom pt-0"
								href="<c:url value='${join_link}'/>">${join}</a></li>
							<li><a class="dropdown-item border-bottom"
								href="<c:url value='${loginout_link}'/>">${loginout}</a></li>
							<li><a class="dropdown-item pb-0"
								href="auth_location">내 위치 인증</a></li>
						</ul>
					</div>
				</li>
			</ul>
		</div>
	</div>
</nav>