<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.temporal.ChronoUnit"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Job Detail</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/detail.css">
<link rel="stylesheet" href="./css/navbar.css">

</head>
<body>

	<!-- header -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

		<c:forEach var="list" items="${list}">
	<div
		class="d-flex flex-column justify-content-center mx-auto px-3 my-5 py-5"
		id="detail">

			<div class="container" id="detail_goods">
				<div class="row">
					<!-- 상품 이미지 carousel -->
					<div id="carouselIndicators" class="carousel slide col-5">
						

						<div class="image">
								<img id="goods_image" src="./upload/${list.job_image}"
									class="d-block w-100" alt="..."  style="width: 600px; height: 550px;">
						</div>
					</div>

					<!-- 상품명, 가격 등등 -->
					<div class="col-7">

						<div class="row">
							<div class="col-9">
								<h3 class="mb-3" id="goods_name">${list.job_title }&nbsp;
								</h3>
							</div>
							<div class="col-3">
							
							<c:if test="${member_no eq list.member_no }">
								<div class="btn-group btn-group-sm" role="group"
									aria-label="Small button group" id="edit">
									<button type="button" class="btn btn-outline-primary"
									onClick="location.href='job_update_form?job_no=${list.job_no}'">수정</button>
									<button type="button" class="btn btn-outline-danger"
										data-bs-toggle="modal" data-bs-target="#staticBackdrop">삭제</button>
								</div>
							</c:if>
								
								<div class="modal fade" id="staticBackdrop"
									data-bs-backdrop="static" data-bs-keyboard="false"
									tabindex="-1" aria-labelledby="staticBackdropLabel"
									aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h1 class="modal-title fs-5" id="staticBackdropLabel">상품 삭제</h1>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">[${list.job_title }]을 삭제하시겠습니까?</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">닫기</button>
												<button type="button" class="btn btn-danger" onclick="location.href='job_delete?job_no=${list.job_no}'">삭제</button>
											</div>
										</div>
									</div>
								</div>

								<script>
								const myModal = document.getElementById('myModal') const myInput
								= document.getElementById('myInput')

								myModal.addEventListener('shown.bs.modal', () => {
								myInput.focus() })
								</script>

							</div>
						</div>
						<div class="row">
							<div class="col-7">
								<h5>시급 ${list.job_price }원&nbsp;<br>
								</h5>
									${list.job_day } / 시간 : ${list.job_time1 } ~ ${list.job_time2 }
							</div>
							<div class="col-5" id="time_div">
								<!-- 시간 변환 출력 -->
								<c:if test="${minute <= 60}">
									<p class="text-muted" id="detail_indicator">&nbsp;${minute }분&nbsp;전</p>
								</c:if>
								<c:if test="${minute > 60 && minute <= 1440}">
									<p class="text-muted" id="detail_indicator">
										<!-- &nbsp; -->${Math.round(minute / 60) }시간&nbsp;전</p>
								</c:if>
								<c:if test="${minute > 1440 && minute <= 10080}">
									<p class="text-muted" id="detail_indicator">&nbsp;${Math.round(minute / 1440) }일&nbsp;전</p>
								</c:if>
								<c:if test="${minute > 10080}">
									<p class="text-muted" id="detail_indicator">&nbsp;${list.job_regdate }</p>
								</c:if>
							</div>

							<!-- 수평선1 -->
							<hr>

						</div>

						<!-- 조회수, 관심, 내용 -->
						<div class="row">
							<div class="col-8">
								<a 
									id="member_nick"><i class="fa-regular fa-user" id="user_img"></i>
									${list.member_nickname }</a>
							</div>
							<div class="col-4" id="view_div">
								<p><i class="fa-solid fa-eye"></i> 조회 &nbsp;${list.job_readcount }&nbsp;</p>
							</div>
						</div>

						<div class="row">
							<div>
								<textarea id="goods_content" readonly>${list.job_content }</textarea>
							</div>
						</div>

						<!-- 희망거래장소 -->
						<div class="row">
							<div class="col-10" id="trade_here">
								<i class="fa-solid fa-location-dot" id="trade_marker"></i>&nbsp;<span>여기서
									근무해요!</span>
								<div class="">
								<h5>${list.job_place}</h5>
								</div>
								<div id="map"></div>
							</div>
							<div class="col-2 text-end" style="position: absolute; bottom: 140px; right: 70px; margin: 10px;">
							<c:if test="${list.member_no != member_no}">
								<button class="btn btn-outline-dark mt-2" id="chat" onclick="location.href='message_list?member_no=${list.member_no }'">채팅하기</button>
							</c:if>
							</div>
						</div>

					</div>
				</div>

				<!-- 수평선2 -->
				<hr>

			</div>
	</div>
	<!-- detail_store_container end -->

	<!-- 인기상품 목록 -->
	<div class="container" id="detail_hit">

		<div class="row mx-auto">
			<h5 id="hit_goods">주변 공고 보고가세요!</h5>
			<c:forEach var="job_place" items="${job_place}">
				<div class="col-2 mx-auto" id="hit_image">
					<img alt="" style="width: 200px; height: 200px;"
						src="./upload/${job_place.job_image}"<%-- ${best.goods_image } --%>>
					<p>
						<a href="job_detail?job_no=${job_place.job_no }" id="hit_name">${job_place.job_title}</a>
					</p>
					<p>${job_place.job_price}원</p>
				</div>
			</c:forEach>
		</div>
	</div>
	<!-- detail_container end -->

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>

	<!-- 카카오맵 api -->
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=977ee17ba59e7721767fe0fdf92b13a5&libraries=services"></script>

		<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.499593, 127.030474), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('${list.job_place}', function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	        
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	   /*      var infowindow = new kakao.maps.InfoWindow({
            	content : '<div id="place_info">${list.job_place}</div>'
       		 });
	        infowindow.open(map, marker); */

	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	   		 } 
			});    
			</script>
		</c:forEach>

</body>
<!-- load 함수로 동적 교체 -->
<script>
	$(".category").load("<c:url value='navbar' />");
</script>
</html>
