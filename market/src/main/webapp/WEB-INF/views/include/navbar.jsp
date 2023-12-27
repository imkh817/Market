<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="chat" value="${sessionScope.member_id==null ? '5' : ''}" />
<c:set var="chat_link"
	value="${sessionScope.member_id==null ? 'login_form' : 'chat'}" />
<c:set var="sell_link"
	value="${sessionScope.member_id==null ? 'login_form' : 'sell_form'}" />
<c:set var="join"
	value="${sessionScope.member_id==null ? '회원가입' : '마이페이지'}" />
<c:set var="join_link"
	value="${sessionScope.member_id==null ? 'join_form' : 'mypage_form'}" />
<c:set var="loginout"
	value="${sessionScope.member_id==null ? '로그인' : '로그아웃'}" />
<c:set var="loginout_link"
	value="${sessionScope.member_id==null ? 'login_form' : '/logout'}" />

<nav class="navbar navbar-expand-lg fixed-top"
	style="background-color: #fff">
	<div class="container-fluid ms-5 my-auto">
		<a class="navbar-brand fs-2" href="home"><div class="hstack gap-3">
				<img src="./images/cabbage.png" width="70px" height="70px">
				<p class="fw-bold">양배추마켓</p>
			</div></a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbar_toggler" aria-controls="navbar_toggler"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse ms-5" id="navbar_toggler">
			<form class="d-flex me-auto w-50" role="search" id="search">
				<input class="form-control me-2 px-5" type="search"
					placeholder="어떤 상품을 찾으시나요?" aria-label="Search"
					style="position: relative; border-color: #21F11C;"><i
					class="fa-solid fa-magnifying-glass"
					style="position: absolute; transform: translate(60%, 70%); color: #21F11C;"></i>
			</form>
			<ul class="navbar-nav me-auto mb-2">
				<li class="nav-item px-2 fs-2 me-3 my-auto"><a class="sell"
					href="<c:url value='lowest_baechu_form'/>"
					style="color: inherit; text-decoration: none;"><div
							class="hstack gap-2">
							<i class="fa-solid fa-chart-simple"></i>
							<p class="my-auto" style="font-size: 0.8rem">최저가 비교</p>
						</div></a></li>
				<li class="nav-item px-2 fs-2 me-3 my-auto"><a class="chat"
					href="<c:url value='${chat_link}'/>"
					style="color: inherit; text-decoration: none;"><div
							class="hstack gap-2">
							<i class="fa-regular fa-comment-dots" style="position: relative;"></i>
							<span class="badge"
								style="background-color: #21F11C; font-size: 0.6rem; position: absolute; transform: translate(100%, -70%);">${chat}</span>
							<p class="my-auto" style="font-size: 0.8rem">채팅하기</p>
						</div></a></li>
				<li class="nav-item px-2 fs-2 me-3 my-auto"><a class="sell"
					href="<c:url value='${sell_link}'/>"
					style="color: inherit; text-decoration: none;"><div
							class="hstack gap-2">
							<i class="fa-solid fa-money-check-dollar"></i>
							<p class="my-auto" style="font-size: 0.8rem">판매하기</p>
						</div></a></li>
				<li class="nav-item px-2 me-3 fs-2">
					<div class="dropdown">
						<div data-bs-toggle="dropdown" aria-expanded="false"
							style="position: relative;">
							<div class="hstack gap-2">
								<i class="fa-regular fa-user"></i>
								<p class="my-auto fw-bolder" style="font-size: 0.8rem">${sessionScope.member_nickname}</p>
							</div>
						</div>
						<ul class="dropdown-menu"
							style="font-size: 0.8rem; position: absolute; transform: translate(-10%, -10%);">
							<li><a class="dropdown-item border-bottom pt-0"
								href="<c:url value='${join_link}'/>">${join}</a></li>
							<li><a class="dropdown-item border-bottom"
								href="<c:url value='${loginout_link}'/>">${loginout}</a></li>
							<li><a class="dropdown-item pb-0" href="auth_location">내
									위치 인증</a></li>
						</ul>
					</div>
				</li>
			</ul>
		</div>
	</div>
</nav>
