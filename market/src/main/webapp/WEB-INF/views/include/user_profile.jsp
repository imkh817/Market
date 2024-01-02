<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>사용자 프로필</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.profile-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px;
	background-color: #f8f9fa;
	border-radius: 10px;
	margin-top: 20px;
}

.profile-image {
	border-radius: 50%;
	overflow: hidden;
	width: 50px;
	height: 50px;
}

.stats-container {
	display: flex;
	justify-content: space-between;
	padding: 10px;
	background-color: #f8f9fa;
	border-radius: 10px;
	margin-top: 20px;
}
</style>
</head>
<body>
	<!-- 프로필 정보 및 통계 영역 -->
	<div class="container mt-6 ">
		<div class="row ">
			<!-- 왼쪽 칸: 프로필 이미지 및 닉네임 -->
			<div class="col-md-12 " align="center">
				<div class="profile-container col-7 rounded- 4 shadow p-3 mb-5 bg-body-tertiary rounded">
					<div class="profile-image col-4" >
						<img src="https://placekitten.com/50/50" class="img-fluid"
							alt="프로필 이미지">
					</div>
					<!-- <div class="col-4">
						<h5 class="mb-0 ml-3">#${member_nickname}</h5>
					</div> -->
					<div class="col-3">
						<i class="fa-solid fa-gift fa-2x " style="color: #5ba95d;"></i>
						<p></p>
						<h6>판매 ${sell_count }</h6>
					</div>
					<div class="col-3">
						<i class="fa-solid fa-heart fa-2x" style="color: #e84a62;"></i>
						<p></p>
						<h6>좋아요 ${liked_count }</h6>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br>

	<!-- 부트스트랩 및 자바스크립트 파일 로드 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
