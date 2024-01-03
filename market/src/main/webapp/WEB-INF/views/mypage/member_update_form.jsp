<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<script src="./js/join/join.js"></script>
<link rel="stylesheet" href="./css/join.css">
<link rel="stylesheet" href="./css/pagination.css">
<link rel="stylesheet" href="./css/navbar.css">
<style>
.ai-text {
	padding: 10px 20px;
	background-color: #444444;
	border-radius: 5px;
	color: #ffffff;
	position: absolute;
	translate: 80% -75%;
	display: none;
}

.ai-title:hover+.ai-text {
	display: block;
}

.wrapper {
	text-align: center;
	flex-grow: 1;
}

.wrapper .img_preview {
	width: 150px;
	height: 150px;
	object-fit: cover;
	display: block;
	margin: 20px auto;
	border: 1px solid #BDBDBD;
}

.wrapper .img_upload {
	border: none;
	padding: 6px 12px;
	display: inline-block;
	cursor: pointer;
}

.wrapper input[type=file] {
	display: none;
}
</style>
</head>
<body class="my-5 py-5">
	<!-- 상단 내비바 -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

	<!-- 프로필 정보 및 통계 영역 -->
	<div class="mx-auto my-3 py-3" style="max-width: 768px;">
		<div class="d-flex justify-content-center my-3 py-3">
			<ul class="nav nav-underline gap-5">
				<li class="nav-item"><a class="nav-link" aria-current="page"
					href="mypage_list" style="color: #47C83E;">판매 내역</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_liked_form" style="color: #47C83E;">관심 상품</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_delete_form" style="color: #47C83E;">회원 탈퇴</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_delete_form" style="color: #47C83E;">정보 수정</a></li>
			</ul>
		</div>
	</div>

	<div class="join-container" style="width: 768px;">
		<div class="join-form">
			<p class="fs-2 fw-medium">프로필</p>
			<hr>
			<div class="container d-flex">
				<div class="wrapper" style="position: relative;">
					<img src="../images/user.png" class="img_preview rounded-circle" />
					<label for="file" class="img_upload"> <input id="file"
						type="file" accept="image/*"> <i
						class="fa-solid fa-camera text-light"
						style="position: absolute; translate: -50% -350%;"></i>
					</label>
				</div>
			</div>
			<div class="d-flex justify-content-center mx-auto mb-3">
				<button class="ai-title btn rounded-pill fw-bold" 
					data-bs-toggle="modal" data-bs-target="#ai_modal" style="width:220px;">
					<i class="fs-5 fa-solid fa-wand-magic-sparkles text-light"
					style="translate: -50% 0%;"></i>
					AI이미지생성
					</button>
				<div class="ai-text opacity-75">
					원하는 이미지를 간단하게<br>글로 설명하면 AI가 생성해줘요
				</div>
				<div class="modal fade" id="ai_modal" tabindex="-1"
					aria-labelledby="ai_modal_label" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-body">
								<form>
									<div class="mb-3">
										<label for="message-text" class="col-form-label">내용:</label>
										<textarea class="form-control" id="message-text"></textarea>
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn col" data-bs-dismiss="modal">닫기</button>
								<button type="button" class="btn col" onclick="">생성</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<form action="member_update" method="post">
				<div class="input-group mb-2">
					<label class="form-label fw-medium">이름</label>
					<div class="input-group">
						<input
							class="form-control border-bottom border-dark-subtle rounded-0"
							type="text" style="border: none;" placeholder="입력란">
					</div>
				</div>
				<div class="input-group mb-2">
					<label class="form-label fw-medium">별명</label>
					<div class="input-group">
						<input
							class="form-control border-bottom border-dark-subtle rounded-0"
							type="text" style="border: none;" placeholder="입력란">
					</div>
				</div>
				<div class="input-group mb-2">
					<label class="form-label fw-medium">전화번호</label>
					<div class="input-group">
						<input
							class="form-control border-bottom border-dark-subtle rounded-0"
							type="text" style="border: none;" placeholder="입력란">
					</div>
				</div>
				<button type="submit" id="member_update_button">수정하기</button>
			</form>
		</div>
	</div>

	<!-- 하단 내비바 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>

	<!-- 이미지 프리뷰 -->
	<script>
	const fileDOM = document.querySelector('#file');
	const preview = document.querySelector('.img_preview');
			
	fileDOM.addEventListener('change', () => {
		if(!fileDOM.files[0].type.match("image/.*")){
			alert('이미지 파일만 업로드 가능합니다.');
			return;
		}
		const reader = new FileReader();
		reader.onload = ({target}) => {
			preview.src = target.result;
		};
		reader.readAsDataURL(fileDOM.files[0]);
	});
	</script>
</body>
</html>