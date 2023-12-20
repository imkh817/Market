<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<nav class="navbar navbar-expand-lg fixed-top"
	style="background-color: #fff">
	<div class="container-fluid ms-5 my-auto">
		<a class="navbar-brand fs-2" href="#"><div class="hstack gap-3">
				<i class="fa-solid fa-seedling" style="color: #21F11C"></i>
				<p class="fw-bold">양배추마켓</p>
			</div></a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarTogglerDemo02"
			aria-controls="navbarTogglerDemo02" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse ms-5" id="navbarTogglerDemo02">
			<form class="d-flex me-auto w-50" role="search">
				<input class="form-control me-2 px-5" type="search"
					placeholder="어떤 상품을 찾으시나요?" aria-label="Search"
					style="position: relative; border-color: #21F11C;"><i
					class="fa-solid fa-magnifying-glass"
					style="position: absolute; transform: translate(60%, 70%); color: #21F11C;"></i>
			</form>
			<ul class="navbar-nav me-auto mb-2">
				<li class="nav-item px-2 fs-2"><a class="nav-link" href="#"><div
							class="hstack gap-2">
							<i class="fa-regular fa-comment-dots"></i>
							<p class="my-auto" style="font-size: 0.8rem">채팅하기</p>
						</div></a></li>
				<li class="nav-item px-2 fs-2"><a class="nav-link" href="#"><div
							class="hstack gap-2">
							<i class="fa-solid fa-money-check-dollar"></i>
							<p class="my-auto" style="font-size: 0.8rem">판매하기</p>
						</div></a></li>
				<li class="nav-item px-2 fs-2"><a class="nav-link" href="#"><div
							class="hstack gap-2">
							<i class="fa-regular fa-user"></i>
							<p class="my-auto" style="font-size: 0.8rem">#000000</p>
						</div></a></li>
			</ul>
		</div>
	</div>
</nav>