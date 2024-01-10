<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.temporal.ChronoUnit"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>상품 상세페이지</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/detail.css">
<link rel="stylesheet" href="./css/navbar.css">
</head>
<body>
	<c:forEach var="dl" items="${detail_result }">
		<c:set var="member_no" value="${dl.member_no}" />

		<c:url var="seller_profile_link"
			value="${sessionScope.member_no == member_no ? 'mypage_list' : 'seller_profile'}">
			<c:param name="goods_no" value="${dl.goods_no}" />
			<c:param name="member_no" value="${dl.member_no}" />
		</c:url>
		<%-- 
      <c:url var="detail_chat_link" value="${sessionScope.member_no == null ? 'login_form' : 'message_list'}">
            <c:param name="member_no" value="${dl.member_no}" />
        </c:url> --%>

		<!-- header -->
		<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

		<div
			class="d-flex flex-column justify-content-center mx-auto px-3 my-5 py-5"
			id="detail">

			<div class="container" id="detail_goods">
				<div class="row">
					<!-- 상품 이미지 carousel -->
					<div id="carouselIndicators" class="carousel slide col-5">
						<div class="carousel-indicators">
							<c:forEach var="detail_img"
								items="${fn:split(dl.goods_image, ',')}" varStatus="num">
								<button type="button" data-bs-target="#carouselIndicators"
									data-bs-slide-to="${num.index}"
									class="${num.first ? 'active' : ''}"
									aria-current="${num.first}" aria-label="Slide ${num.index + 1}"></button>
							</c:forEach>
						</div>

						<div class="carousel-inner">
							<c:forEach var="detail_img"
								items="${fn:split(dl.goods_image, ',')}" varStatus="num">
								<div class="carousel-item ${num.first ? 'active' : ''}">
									<img id="goods_image" src="./upload/${detail_img}"
										onerror="this.src='https://via.placeholder.com/600'"
										class="d-block w-100" alt="상품 이미지">
								</div>
							</c:forEach>
						</div>
						<c:if test="${fn:length(fn:split(dl.goods_image, ',')) > 1}">
							<button class="carousel-control-prev" type="button"
								data-bs-target="#carouselIndicators" data-bs-slide="prev">
								<span class="carousel-control-prev-icon" aria-hidden="true"></span>
								<span class="visually-hidden">Previous</span>
							</button>
							<button class="carousel-control-next" type="button"
								data-bs-target="#carouselIndicators" data-bs-slide="next">
								<span class="carousel-control-next-icon" aria-hidden="true"></span>
								<span class="visually-hidden">Next</span>
							</button>
						</c:if>
					</div>

					<!-- 상품명, 가격 등등 -->
					<div class="col-7">
						<div class="row">
							<div class="col-9">
								<h3 class="mb-3" id="goods_name">${dl.goods_name }

									<!-- 하트 클릭 -->
									<input type="hidden" name="liked_state" value="${heart_result}">
									<i id="heart_icon" class="far fa-heart"></i>

								</h3>
							</div>
							<div class="col-3" id="detail_category">${detail_category }

							</div>
						</div>
						<div class="row">
							<div class="col-7">
								<h5>${dl.goods_price }원&nbsp;
									<a href="lowest_baechu?compare_product=${dl.goods_name }"
										id="recent_price">최근 가격 확인하기</a>
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
									<p class="text-muted" id="detail_indicator">&nbsp;${dl.goods_regdate }</p>
								</c:if>
							</div>

							<!-- 수평선1 -->
							<hr>

						</div>

						<!-- 조회수, 관심, 내용 -->
						<div class="row">
							<div class="col-8" id="social">
								<a href="<c:url value='${seller_profile_link}'/>"
									id="member_nick"><i class="fa-regular fa-user"
									id="user_img"></i>&nbsp;${detail_nick }</a>&nbsp;&nbsp;

								<!-- 카카오톡 공유하기 -->
								<a id="kakaotalk-sharing-btn" href="javascript:;"> <img
									src="https://ifh.cc/g/bndvfy.png" id="kakaotalk-sharing-img">&nbsp;카톡
									공유하기
								</a>
							</div>
							<div class="col-4" id="view_div">
								<p>조회&nbsp;${dl.goods_readcount }&nbsp;·&nbsp;관심&nbsp;${heart_count }</p>
							</div>
						</div>

						<div class="row">
							<div>
								<textarea id="goods_content" readonly>${dl.goods_content }</textarea>
							</div>
						</div>

						<!-- 희망거래장소 -->
						<div class="row">
							<div class="col-10" id="trade_here">
								<c:if test="${dl.goods_place != null }">
									<i class="fa-solid fa-location-dot" id="trade_marker"></i>&nbsp;<span>여기서
										거래해요!</span>
									<div id="map"></div>
								</c:if>
								<c:if test="${dl.goods_place == null }">
									<i class="fa-solid fa-location-dot" id="trade_marker"></i>&nbsp;<span>거래장소는
										판매자에게 채팅해주세요!</span>
								</c:if>
							</div>


							<!-- 채팅 버튼 또는 수정, 삭제 -->

							<!-- 한희 수정 시작 -->
							<div class="col-2 text-end">

								<div id="goods_state">
									<c:if test="${dl.goods_state eq '1'}">
										<strong>판매중</strong>
									</c:if>
									<c:if test="${dl.goods_state eq '2'}">
										<strong>예약중</strong>
									</c:if>
									<c:if test="${dl.goods_state eq '3'}">
										<strong>판매완료</strong>
									</c:if>
								</div>

								<div>
									<c:if
										test="${dl.goods_state eq '3' && dl.member_no != session_member_no }">
										<button class="btn btn-outline-dark mt-2" id="chat"
											onclick="location.href='message_list?member_no=${dl.member_no}'"
											disabled="disabled">채팅하기</button>
									</c:if>
									<c:if
										test="${dl.goods_state ne '3' && dl.member_no != session_member_no }">
										<button class="btn btn-outline-dark mt-2" id="chat"
											onclick="location.href='message_list?member_no=${dl.member_no}'">채팅하기</button>
									</c:if>

									<c:if
										test="${dl.member_no == session_member_no }">
										<div class="btn-group btn-group-sm" role="group"
											aria-label="Small button group" id="edit">
											<button type="button" class="btn btn-outline-primary"
												onclick="location.href='update_sell_form?goods_no=${dl.goods_no}'">수정</button>
											<button type="button" class="btn btn-outline-danger"
												data-bs-toggle="modal" data-bs-target="#staticBackdrop">삭제</button>
										</div>
									</c:if>


								</div>
								<!-- 삭제 확인 모달창 -->
								<div class="modal fade" id="staticBackdrop"
									data-bs-backdrop="static" data-bs-keyboard="false"
									tabindex="-1" aria-labelledby="staticBackdropLabel"
									aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h1 class="modal-title fs-5" id="staticBackdropLabel">상품
													삭제</h1>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">[${dl.goods_name }]을&nbsp;삭제하시겠습니까?</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">닫기</button>
												<button type="button" class="btn btn-danger"
													onclick="location.href='detail_delete?goods_no=${dl.goods_no}'">삭제</button>
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
							<!-- 한희 수정 끝 -->
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
			<div class="row">
				<h5 id="hit_goods">인기상품 보고가세요!</h5>
				<c:forEach var="best" items="${best_detail }">
					<div class="col-2 mx-auto" id="hit_info">
						<a href="detail?goods_no=${best.goods_no }" id="hit_name"> <img
							alt="인기상품" id="hit_img"
							src="./upload/${fn:split(best.goods_image, ',')[0]}"
							onerror="this.src='https://via.placeholder.com/200x200'">
							${best.goods_name }
						</a>
						<p>${best.goods_price}원</p>
					</div>
				</c:forEach>
			</div>
		</div>
		<!-- detail_container end -->

		<%@ include file="/WEB-INF/views/include/footer.jsp"%>

		<!-- 하트 -->
		<script>
      document.addEventListener('DOMContentLoaded', function() {
       var heart_icon = document.getElementById('heart_icon');
       var heart_value = document.querySelector('input[name="liked_state"]');
       
       if (heart_value.value == '1') {
          heart_icon.classList.add('fas', 'text-danger');
       } else {
          heart_icon.classList.add('far');
       }

       heart_icon.addEventListener('click', function() {
           var session_member_no = "<c:out value='${sessionScope.member_no}'/>";   
           if (!session_member_no || session_member_no === "null" || session_member_no === "undefined") {
              
               alert("로그인 후 이용해주세요.");
           } else {
              // 클래스를 모두 제거
               heart_icon.classList.remove('far', 'fas', 'text-danger');
               
               if (heart_value.value == '1') {
                  heart_value.value = '0'; 
                   heart_icon.classList.add('far');
               } else {
                  heart_value.value = '1'; 
                   heart_icon.classList.add('fas', 'text-danger');
               }
           
               // 서버에 하트 클릭 이벤트를 전달하는 Ajax 요청
               $.ajax({
                   type: "GET",
                   url: "heart_click",
                   data: { 'goods_no': '<c:out value="${dl.goods_no}" />', 'liked_state': heart_value.value },
                   success: function(response) {
                   }
               });
           }
       });
   });
      
   </script>
		<!-- 카카오맵 api -->
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=977ee17ba59e7721767fe0fdf92b13a5&libraries=services"></script>

		<script>
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       mapOption = {
           center: new kakao.maps.LatLng(37.499593, 127.030474), // 지도의 중심좌표
           level: 4 // 지도의 확대 레벨
       };  

      var map = new kakao.maps.Map(mapContainer, mapOption); 

      var geocoder = new kakao.maps.services.Geocoder();

      geocoder.addressSearch('${dl.goods_place}', function(result, status) {

        if (status === kakao.maps.services.Status.OK) {

           var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

          var marker = new kakao.maps.Marker({
              map: map,
              position: coords
          });

          var infowindow = new kakao.maps.InfoWindow({
              content: '<div id="place_info">${dl.goods_place}<br>' +
                          '<a id="place_a" href="https://map.kakao.com/link/map/${dl.goods_place},' + 
                              result[0].y + ',' + 
                              result[0].x + 
                              '">큰지도보기</a>&nbsp;' +
                          '<a id="place_a" href="https://map.kakao.com/link/to/${dl.goods_place},' + 
                              result[0].y + ',' + 
                              result[0].x + 
                              '">길찾기</a>' + '</div>'
          });

          infowindow.open(map, marker);


           map.setCenter(coords);
             } 
         });    
         </script>

		<!-- 카카오톡 공유하기 -->
		<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.6.0/kakao.min.js"></script>
		<script> Kakao.init('977ee17ba59e7721767fe0fdf92b13a5'); </script>

		<script>
        Kakao.Share.createDefaultButton({
        container: '#kakaotalk-sharing-btn',
         objectType: 'commerce',
       content: {
         title: '가장 가까운 플리마켓, 양배추마켓',
         imageUrl:
        'https://ifh.cc/g/MLlxfz.png',
         link: {
        webUrl: 'http://localhost/market/detail?goods_no=${dl.goods_no}',
         },
       },
       commerce: {
         productName: '${dl.goods_name}',
         regularPrice: ${dl.goods_price},
       },
       buttons: [
         {
        title: '이동하기',
        link: {
          webUrl: 'http://localhost/market/detail?goods_no=${dl.goods_no}',
        },
         },
         {
        title: '공유하기',
        link: {
         webUrl: 'http://localhost/market/detail?goods_no=${dl.goods_no}',
        },
         },
       ],
        });
   </script>
	</c:forEach>
</body>
<!-- load 함수로 동적 교체 -->
<script>
	$(".category").load("<c:url value='navbar' />");
</script>
</html>