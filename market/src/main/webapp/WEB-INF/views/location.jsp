<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- <script>
	function access_geo(position) {
		latitude = position.coords.latitude;
		longitude = position.coords.longitude;
		//		console.log(latitude);
		//		console.log(longitude);

		$.ajax({
			type : 'POST',
			url : 'auth',
			data : {
				'lat' : latitude,
				'lng' : longitude
			},
			success : function(result) {
				if (result == 1) {
					alert("인증되었습니다.");
				} else {
					alert("인증에 실패했습니다.");
				}
			},
			error : function(error) {
				alert("Error: " + error.message);
			}
		});
	}
	function ask_geo() {
		navigator.geolocation.getCurrentPosition(access_geo)
	}
</script> -->

<div class="d-flex flex-column align-items-center my-5">
	<div>
		<button class="btn btn-secondary btn-lg mb-5 fw-bold"
			onClick="javascript:ask_geo()">내 위치 인증하기</button>
	</div>
	<div class="map_wrap">
		<div id="map"
			style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
		<div class="hAddr">
			<span class="title">지도중심기준 행정동 주소정보</span> <span id="centerAddr"></span>
		</div>
	</div>
</div>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=28e4f2b3af20081fc75e959954bdc8d5&libraries=services"></script>
<script>
	// 2. 받아온 위치값을 지도로 표시
	function access_geo(position) {
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(position.coords.latitude,
					position.coords.longitude), // 지도의 중심좌표
			level : 1
		// 지도의 확대 레벨
		};

		// 지도 생성 
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 주소-좌표 변환 객체 생성
		var geocoder = new kakao.maps.services.Geocoder();

		// 현재 지도 중심좌표로 주소를 검색해 지도 좌측 상단에 표시
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);

		function searchAddrFromCoords(coords, callback) {
			// 좌표로 행정동 주소 정보를 요청
			geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
		}

		// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출
		function displayCenterInfo(result, status) {
			if (status === kakao.maps.services.Status.OK) {
				var infoDiv = document.getElementById('centerAddr');
				// console.log(result[0].address_name);

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