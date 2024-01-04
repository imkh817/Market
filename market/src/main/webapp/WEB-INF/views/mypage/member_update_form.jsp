<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<script src="./js/join/join.js"></script>
<!-- 로더 표시 -->
<script>
	function loader_show(){
		$("#load_bf").hide();
		$("#load_ing").show();
	//	setTimeout("loader_hide()", 10000);	// 10초
	}
	function loader_hide(){
		$("#load_ing").hide();
	}
</script>
<link rel="stylesheet" href="./css/join.css">
<link rel="stylesheet" href="./css/pagination.css">
<link rel="stylesheet" href="./css/navbar.css">
<link rel="stylesheet" href="./css/update.css">
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

	<div id="mask"
		style="position: absolute; z-index: 100; background-color: #555;"></div>

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
					data-bs-toggle="modal" data-bs-target="#ai_modal"
					style="width: 220px;">
					<i class="fs-5 fa-solid fa-wand-magic-sparkles text-light"
						style="translate: -50% 0%;"></i> AI이미지생성
				</button>
				<div class="ai-text opacity-75">
					원하는 이미지를 간단하게<br>글로 설명하면 AI가 생성해줘요
				</div>
				<div class="modal fade" id="ai_modal" tabindex="-1"
					aria-labelledby="ai_modal_label" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content" id="modal-content">
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
								<button type="button" class="btn col" id="load_bf"
									onclick="loader_show()">생성</button>
								<button type="button" class="btn col" id="load_ing" style="display: none;" disabled>
									<span class="spinner-border spinner-border-sm"></span>
									<span role="status">Loading...</span>
								</button>
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