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

<script>
	document.addEventListener('DOMContentLoaded', function() {
		var heartIcon = document.getElementById('heartIcon');
		var heartValue = document.querySelector('input[name="liked_no"]');

		if (heartValue.value == '1') {
			heartIcon.classList.add('fas', 'text-danger');
		} else {
			heartIcon.classList.add('far');
		}

		heartIcon.addEventListener('click', function() {
			var no = "<c:out value='${member_no}'/>";
			if (!no || no === null) {
				alert("로그인 후 이용해주세요.");
			} else {
				// 클래스를 모두 제거
				heartIcon.classList.remove('far', 'fas', 'text-danger');

				if (heartValue.value == '1') {
					heartValue.value = '0';
					heartIcon.classList.add('far');
				} else {
					heartValue.value = '1';
					heartIcon.classList.add('fas', 'text-danger');
				}

				// 서버에 하트 클릭 이벤트를 전달하는 Ajax 요청
				$.ajax({
					type : "POST",
					url : "heartClick",
					data : {
						goods_no : '<c:out value="${goods.goods_no}" />',
						liked_no : heartValue.value
					},
					success : function(response) {
					}
				});
			}
		});
	});
</script>
</head>
<body>

	<!-- header -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

	<div
		class="d-flex flex-column justify-content-center mx-auto px-3 my-5 py-5"
		id="detail">
		<c:forEach var="list" items="${list}">

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
					<input type="hidden" name="liked_state" value="${liked }">
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
								<h5>시급 ${list.job_price }원&nbsp;
								</h5>
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
								<a href="mypage_list?member_no=${list.member_no }"
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
							<div class="col-2 text-end">
								<button class="btn btn-outline-dark mt-2" id="chat" onclick="location.href='chat?goods_no=${dl.goods_no}&member_no=${dl.member_no }&session_member_no=${session_member_no }'">채팅하기</button>
							</div>
						</div>

					</div>
				</div>

				<!-- 수평선2 -->
				<hr>

			</div>
		</c:forEach>
	</div>
	<!-- detail_store_container end -->

	<!-- 인기상품 목록 -->
	<div class="container" id="detail_hit">


		<div class="row mx-auto">
			<h5 id="hit_goods">주변 공고 보고가세요!</h5>
			<c:forEach var="best" items="${best_detail }">
				<div class="col-2 mx-auto" id="hit_image">
					<img alt=""
						src="https://via.placeholder.com/200x200<%-- ${best.goods_image } --%>">
					<p>
						<a href="detail?goods_no=${best.goods_no }" id="hit_name">${best.goods_name }</a>
					</p>
					<p>${best.goods_price}원</p>
				</div>
			</c:forEach>
		</div>
	</div>
	<!-- detail_container end -->

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>



	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=977ee17ba59e7721767fe0fdf92b13a5"></script>

	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.499593, 127.030474), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 마커가 표시될 위치입니다 
		var markerPosition = new kakao.maps.LatLng(37.499593, 127.030474);

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);

		var iwContent = '<div style="padding:5px;">양배추마켓 <br><a href="https://map.kakao.com/link/map/양배추마켓,37.499593,127.030474" style="color:#47C83E; font-size:14px;" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/양배추마켓,37.499593,127.030474" style="color:#47C83E; font-size:14px;" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

		iwPosition = new kakao.maps.LatLng(37.499593, 127.030474); //인포윈도우 표시 위치입니다

		// 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
			position : iwPosition,
			content : iwContent
		});

		// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
		infowindow.open(map, marker);
	</script>
</body>
</html>
