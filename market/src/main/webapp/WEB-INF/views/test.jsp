<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="user"
	value="${sessionScope.member_id==null ? '' : '${sessionScope.member_id}'}" />
<c:set var="chat" value="${sessionScope.member_id==null ? '5' : ''}" />
<c:set var="chat_link"
	value="${sessionScope.member_id==null ? 'login' : 'chat'}" />
<c:set var="sell_link"
	value="${sessionScope.member_id==null ? 'login' : 'sell'}" />
<c:set var="join"
	value="${sessionScope.member_id==null ? '회원가입' : '마이페이지'}" />
<c:set var="join_link"
	value="${sessionScope.member_id==null ? 'home' : 'mypage'}" />
<c:set var="loginout"
	value="${sessionScope.member_id==null ? '로그인' : '로그아웃'}" />
<c:set var="loginout_link"
	value="${sessionScope.member_id==null ? 'home' : 'logout'}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>home</title>

<!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<!-- jquery -->
<script src="http://code.jquery.com/jquery-latest.js"></script>
<!-- fontawesome -->
<script src="https://kit.fontawesome.com/d29f7040ad.js"
	crossorigin="anonymous"></script>

<link rel="stylesheet" href="./css/banner.css">
</head>
<body class="pt-5">
	<nav class="navbar navbar-expand-lg fixed-top"
		style="background-color: #fff">
		<div class="container-fluid ms-5 my-auto">
			<a class="navbar-brand fs-2" href="home"><div
					class="hstack gap-3">
					<img src="./images/cabbage.png" width="70px" height="70px">
					<p class="fw-bold">양배추마켓</p>
				</div></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbar_toggler"
				aria-controls="navbar_toggler" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse ms-5" id="navbar_toggler">
				<form class="d-flex me-auto w-50" role="search">
					<input class="form-control me-2 px-5" type="search"
						placeholder="어떤 상품을 찾으시나요?" aria-label="Search"
						style="position: relative; border-color: #21F11C;"><i
						class="fa-solid fa-magnifying-glass"
						style="position: absolute; transform: translate(60%, 70%); color: #21F11C;"></i>
				</form>
				<ul class="navbar-nav me-auto mb-2">
					<li class="nav-item px-2 fs-2 me-3 my-auto"><a class="chat" href="<c:url value='${chat_link}'/>" style="color: inherit;
  text-decoration: none;"><div
								class="hstack gap-2">
								<i class="fa-regular fa-comment-dots"
									style="position: relative;"></i> <span class="badge"
									style="background-color: #21F11C; font-size: 0.6rem; position: absolute; transform: translate(100%, -70%);">${chat}</span>
								<p class="my-auto" style="font-size: 0.8rem">채팅하기</p>
							</div></a></li>
					<li class="nav-item px-2 fs-2 me-3 my-auto"><a class="sell" href="<c:url value='${sell_link}'/>" style="color: inherit;
  text-decoration: none;"><div
								class="hstack gap-2">
								<i class="fa-solid fa-money-check-dollar"></i>
								<p class="my-auto" style="font-size: 0.8rem">판매하기</p>
							</div></a></li>
					<li class="nav-item px-2 me-3 fs-2">
						<div class="dropdown">
							<div data-bs-toggle="dropdown" aria-expanded="false"
								style="position: relative;">
								<i class="fa-regular fa-user"></i>
								<p class="my-auto" style="font-size: 0.8rem">${user}</p>
							</div>
							<ul class="dropdown-menu"
								style="font-size: 0.8rem; position: absolute; transform: translate(-10%, -10%);">
								<li><a class="dropdown-item border-bottom pt-0"
									href="<c:url value='${join_link}'/>">${join}</a></li>
								<li><a class="dropdown-item pb-0"
									href="<c:url value='${loginout_link}'/>">${loginout}</a></li>
							</ul>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- 배너 -->
	<section class="banner my-5 py-5">
		<div class="title">
			<h1>
				가장 가까운 플리마켓<br> <b>양배추마켓</b>
			</h1>
		</div>
	</section>

	<!-- 정렬 아이콘 -->
	<div class="d-flex justify-content-center mx-auto px-3"
		style="max-width: 768px;">
		<!-- 새로고침 -->
		<a onClick="location.replace(location.href)"> <i
			class="me-auto p-2 fs-4 fa-solid fa-rotate-right"
			style="color: #21F11C;"></i>
		</a>
		<!-- 최신순 -->
		<a onClick="sort()" id="regdate"> <i
			class="p-2 fs-4 fa-solid fa-bars">&nbsp;최신순</i>
		</a>
		<!-- 인기순(조회수순) -->
		<a onClick="sort()" id="readcount"> <i
			class="p-2 fs-4 fa-solid fa-bars">&nbsp;인기순</i>
		</a>
	</div>

	<!-- 글 목록 -->
	<div class="list_content"></div>

	<div class="container">
		<footer
			class="d-flex flex-wrap justify-content-between py-3 my-3 border-top">
			<div class="row" style="font-size: 0.8rem">
				<p class="col text-body-tertiary">
					Copyright &copy; 2023 <font color="#000">(주)양배추마켓</font> All Rights
					Reserved
				</p>
			</div>
			<div class="btn_up" onclick="window.scrollTo(0,0)">
				<span class="fw-bold">Scroll to Top</span>
			</div>
		</footer>
	</div>

</body>
<script>
	$(".list_content").load("<c:url value='list' />");
</script>
<script>
	$(function() {
		$("#navbar_toggle_btn").click(function() {
			$("#navbar_menu").toggle();
			$("#navbar_icons").toggle();
		});
	});
</script>
<script>
	function access_geo(location) {
		/* console.log(location) */
		const location_geo = {
			latitude : location.coords.latitude,
			longitude : location.coords.longitude
		}
		console.log(location_geo)
	}
	function ask_geo() {
		navigator.geolocation.getCurrentPosition(access_geo)
	}
	ask_geo();
</script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous"></script>
</html>