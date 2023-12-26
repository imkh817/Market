<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 배너 -->
<section class="banner my-5 py-5">
	<div class="title">
		<h1>
			가장 가까운 플리마켓<br> <b>양배추마켓</b>
		</h1>
	</div>
</section>

<!-- 정렬 아이콘 -->
<div class="d-flex justify-content-center mx-auto px-3 gap-5"
	style="max-width: 768px;">
	<!-- 새로고침 -->
	<a onClick="location.replace(location.href)">
	<i class="me-auto p-2 fs-4 fa-solid fa-rotate-right"
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