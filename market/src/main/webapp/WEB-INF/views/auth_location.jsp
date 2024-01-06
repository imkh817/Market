<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>위치인증</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/navbar.css">
<style>
.auth:not(:hover) {
	background-color: #47C83E;
	color: #fff;
	border: none;
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
	transition: all 0.3s cubic-bezier(.25, .8, .25, 1);
}

.auth:hover {
	background-color: #47C83E;
	color: #fff;
	border: none;
	box-shadow: 0 3px 5px rgba(0, 0, 0, 0.25), 0 3px 5px rgba(0, 0, 0, 0.22);
}
</style>
</head>
<body style="padding-top:100px;">
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<!-- 각 페이지 변동 부분 시작 -->
	<div class="d-flex flex-column align-items-center mx-auto my-3">
		<div class="mb-3">
			<p class="mb-5">
				#${mem.member_nickname} 님의 현재 인증 위치 : <b>${mem.member_auth_add}</b>
				<span id="centerAddr" hidden></span>
			</p>
		</div>
		<div class="mb-3">
			<button class="auth btn btn-secondary btn-lg fw-bold mb-3"
				onClick="javascript:ask_geo()"
				style="position: relative; transform: translate(0, -50%);">새로
				인증하기</button>
		</div>
		<div class="map_wrap" style="width: 100%; height: 350px;">
			<div id="map" style="width: 100%; height: 100%;"></div>
		</div>
	</div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=28e4f2b3af20081fc75e959954bdc8d5&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		//지도 생성  
		var map = new kakao.maps.Map(mapContainer, mapOption);

		//주소-좌표 변환 객체 생성
		var geocoder = new kakao.maps.services.Geocoder();
		
		//저장된 주소로 좌표를 검색
		geocoder.addressSearch('${mem.member_auth_add}', function(result,
				status) {

			// 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {

				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				
				// 지도의 중심을 결과값으로 받은 위치로 이동
				map.setCenter(coords);
			}
		});
	</script>
	<script>
		// 2. 받아온 위치값을 지도로 표시
		function access_geo(position) {

			var lat = position.coords.latitude, // 위도
			lng = position.coords.longitude; // 경도
			
			var latlng = new kakao.maps.LatLng(lat, lng);

			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center : latlng, // 지도의 중심좌표
				level : 3
			// 지도의 확대 레벨
			};

			// 지도 생성 
			var map = new kakao.maps.Map(mapContainer, mapOption);

			// 주소-좌표 변환 객체 생성
			var geocoder = new kakao.maps.services.Geocoder();

			// 현재 지도 중심좌표로 주소를 검색해 지도 좌측 상단에 표시
			searchAddrFromCoords(latlng, displayCenterInfo);

			function searchAddrFromCoords(latlng, callback) {
				// 좌표로 행정동 주소 정보를 요청
				geocoder.coord2RegionCode(latlng.getLng(), latlng.getLat(),
						callback);
			}

			// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출
			function displayCenterInfo(result, status) {
				if (status === kakao.maps.services.Status.OK) {
					var infoDiv = document.getElementById('centerAddr');

					for (var i = 0; i < result.length; i++) {
						// 행정동의 region_type 값은 'H'
						if (result[i].region_type === 'H') {
							infoDiv.innerHTML = result[i].address_name;
							break;
						}
					}

					// 행정동 주소로 인증값 저장
					$.ajax({
						type : 'POST',
						url : 'auth',
						data : {
							'member_auth_add' : result[0].address_name
						},
						success : function(result) {
							if (result == 1) {
								alert("인증되었습니다.");
								history.go(0);
							} else {
								alert("인증에 실패했습니다.");
							}
						},
						error : function(error) {
							alert("Error: " + error.message);
						}
					});
				}
			}
		}

		// 1. 버튼 클릭 시 위치값 받아옴
		function ask_geo() {
			navigator.geolocation.getCurrentPosition(access_geo);
		}
	</script>
	<!-- 각 페이지 변동 부분 끝 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
<!-- load 함수로 동적 교체 -->
<script>
	$(".category").load("<c:url value='navbar' />");
</script>
</html>