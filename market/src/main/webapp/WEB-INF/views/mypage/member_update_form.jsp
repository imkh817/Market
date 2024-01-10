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
<script>
$(document).ready(function () {
    $("#ai_modal_button").click(function () {
        $("#ai_modal").modal("show");
        return false;
    });
});

var member = ${jsonMember};
function nickname_valiable1(){
	var nickname = document.getElementById('member_nickname').value;
	if(member.member_nickname != nickname){
	$.ajax({
		url : "nickname_valiable",
		type : "POST",
		data : {"member_nickname" : nickname},
		success : function(data){
			if(data != "사용 가능한 닉네임 입니다."){
				document.getElementById('member_nickname').value = "";
				document.getElementById('member_nickname').focus(); 
				document.getElementById('nickname_valiable').value = data;
				document.getElementById('nickname_valiable').style.display = 'block';
				 }else{
					document.getElementById('nickname_valiable').value = data;
					document.getElementById('nickname_valiable').style.display = 'block';
				} 
			}
		})
	}
	else{
		document.getElementById('nickname_valiable').style.display = 'none';
	}
}
function phone_authorization1(event) {
	event.preventDefault();
    var number = document.getElementById('member_phone_num').value
	
    if(member.member_phone_num != number){
	    $.ajax({
	    	url : "phone_autorization_update",
	    	type : "POST",
	    	data : {"number" : number},
	    	success : function(data){
	    		if(data == '이미 가입되어 있는 번호 입니다.'){
	    			document.getElementById('member_phone_num').value = '';
	    			document.getElementById('member_phone_num').focus(); 
	    			document.getElementById('phone_number_valiable').value = data;
					document.getElementById('phone_number_valiable').style.display = 'block';
	    		}else{
	    			event.target.submit();
	    		}
	    	}
	    })
   }else{
	   document.getElementById('nickname_valiable').style.display = 'none';
	   event.target.submit();
   }
}
</script>
</head>
<body class="my-5">
	<!-- 상단 내비바 -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

	<div class="mx-auto my-3 py-3" style="max-width: 768px;">
		<div class="d-flex justify-content-center my-3 py-3">
			<ul class="nav nav-underline gap-5">
				<li class="nav-item"><a class="nav-link" aria-current="page"
					href="mypage_list" style="color: #47C83E;">판매 내역</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_liked_form" style="color: #47C83E;">관심 상품</a></li>
				<li class="nav-item"><a class="nav-link"
					href="mypage_job_list" style="color: #47C83E;">내 구인 공고</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_update_form" style="color: #47C83E;">정보 수정</a></li>
				<li class="nav-item"><a class="nav-link"
					href="member_delete_form" style="color: #47C83E;">회원 탈퇴</a></li>
			</ul>
		</div>
	</div>

	<div class="join-container" style="width: 768px;">
		<div class="join-form">
			<form action="image_ai">
				<div class="modal fade" id="ai_modal" tabindex="-1"
					aria-labelledby="ai_modal_label" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-body">
								<div class="mb-3">
									<label for="message-text" class="col-form-label">내용:</label>
									<textarea class="form-control" id="message-text" name="prompt" placeholder="ex)양배추 캐릭터"></textarea>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn col" data-bs-dismiss="modal">닫기</button>
								<button type="submit" class="btn col" id="load_bf" onclick="loader_show()">생성</button>
								<button type="button" class="btn col" id="load_ing" style="display:none;" disabled>
									<span class="spinner-border spinner-border-sm"></span>
									<span role="status">생성 중...</span>
								</button>
							</div>
						</div>
					</div>
				</div>
			</form>
			<form action="member_update" method="post"
				onsubmit="return phone_authorization1(event)"
				enctype="multipart/form-data">
				<p class="fs-2 fw-medium">프로필</p>
				<hr>
				<div class="container d-flex">
					<div class="wrapper" style="position: relative;">
						<c:if test="${member.member_image == null }">
							<img src="./images/user.png" class="img_preview rounded-circle" />
						</c:if>
						<c:if test="${member.member_image != null }">
							<img src="upload/${member.member_image}"
								class="img_preview rounded-circle" />
						</c:if>

						<label for="file" class="img_upload"> <input id="file"
							type="file" accept="image/*" name="image"> <i
							class="fa-solid fa-camera text-light"
							style="position: absolute; translate: -50% -350%;"></i>
						</label>
					</div>
				</div>
				<div class="d-flex justify-content-center mx-auto mb-3">
					<button id="ai_modal_button"
						class="ai-title btn rounded-pill fw-bold" data-bs-toggle="modal"
						data-bs-target="#ai_modal" style="width: 220px;">
						<i class="fs-5 fa-solid fa-wand-magic-sparkles text-light"
							style="translate: -50% 0%;"></i> AI이미지생성
					</button>
					<div class="ai-text opacity-75">
						원하는 이미지를 간단하게<br>글로 설명하면 AI가 생성해줘요
					</div>
				</div>
				<div class="input-group mb-2">
					<label class="form-label fw-medium">아이디</label>
					<div class="input-group">
						<input
							class="form-control border-bottom border-dark-subtle rounded-0"
							type="text" style="border: none;" name="member_id"
							value="${member.member_id}">
					</div>
				</div>
				<div class="input-group mb-2">
					<label class="form-label fw-medium">이름</label>
					<div class="input-group">
						<input
							class="form-control border-bottom border-dark-subtle rounded-0"
							type="text" style="border: none;" name="member_name"
							value="${member.member_name}">
					</div>
				</div>
				<div class="input-group mb-2">
					<label class="form-label fw-medium">별명</label>
					<div class="input-group">
						<input
							class="form-control border-bottom border-dark-subtle rounded-0"
							type="text" style="border: none;" name="member_nickname"
							value="${member.member_nickname}" id="member_nickname">
					</div>
					<div class="input-group">
						<input type="text" class="rounded-pill text-danger fw-bold"
							id="nickname_valiable" value="" style="display: none">
					</div>
				</div>
				<div class="input-group mb-2">
					<label class="form-label fw-medium">전화번호</label>
					<div class="input-group">
						<input
							class="form-control border-bottom border-dark-subtle rounded-0"
							type="text" style="border: none;" name="member_phone_num"
							id="member_phone_num" value="${member.member_phone_num}"
							onfocus="nickname_valiable1()">
					</div>
					<div class="input-group">
						<input class="col-9 fw-medium text-danger rounded-pill fw-bold"
							id="phone_number_valiable" type="text" style="display: none">
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
<!-- load 함수로 동적 교체 -->
<script>
	$(".category").load("<c:url value='navbar' />");
</script>
</html>