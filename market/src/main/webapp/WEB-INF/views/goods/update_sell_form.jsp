<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>상품 판매 수정</title>
<link rel="stylesheet" href="./css/goods.css">
<link rel="stylesheet" href="./css/navbar.css">
</head>

<script type="text/javascript">
	
	var goods_name, goods_price, goods_content;
	
	// 글작성 유효성 검사
 	function validate_write() {
		
		if ($.trim($("#goods_name").val())==="") {
			alert("상품 제목을 입력하세요!");
			$("#goods_name").val("").focus();
			return false;
		}
		
		if ($("#category_no option:selected").val()==="0") {
			alert("카테고리를 선택하세요!");
			$("#category_no").val("").focus();
			return false;
		}
		
		if ($.trim($("#goods_price").val())==="") {
			alert("상품 가격을 입력하세요!");
			$("#goods_price").val("").focus();
			return false;
		}
		
		if ($.trim($("#goods_content").val())==="") {
			alert("상품 설명을 입력하세요!");
			$("#goods_content").val("").focus();
			return false;
		}
		
		/* if ($("#images")[0].files.length === 0) {
			console.log($("#images")[0].files.length);
			alert("파일을 한 개 이상 선택해 주세요!");
			$("#images").val("").focus();
			return false;
		} */
		
	}
	
	
	// AI 글작성 유효성 검사
	function validate_gpt_write() {
		
		if ($.trim($("#goods_name").val())=="") {
			alert("글을 검토하려면 상품 제목을 입력하세요!");
			$("#goods_name").val("").focus();
			return false;
		}
		
		if ($.trim($("#goods_price").val())=="") {
			alert("글을 검토하려면 상품 가격을 입력하세요!");
			$("#goods_price").val("").focus();
			return false;
		}
		
		if ($.trim($("#goods_content").val())=="") {
			alert("글을 검토하려면 상품 설명을 입력하세요!");
			$("#goods_content").val("").focus();
			return false;
		}
		
		// 변수에 값 저장
		goods_name = $("#goods_name").val();
		goods_price = $("#goods_price").val();
		goods_content = $("#goods_content").val();
		
		return true;
	}
	
	// 유효한 값이 들어오면 GPT 요청
	function gpt_write(){
		if(validate_gpt_write()){
			console.log(goods_name, goods_price, goods_content);
			
			 
			// 버튼을 비활성화하고 로딩 중 메시지 표시
			var button = document.getElementById("gptButton");
			button.disabled = true;
			button.innerHTML = "로딩 중...";

			$.ajax({
				url : "gpt_write/prompt",
				method : "post",
				data : JSON.stringify({
					goods_name : goods_name,
					goods_price : goods_price,
					goods_content : goods_content
				}), // 데이터를 JSON 문자열로 변환
				contentType : "application/json", // 서버에게 전송하는 데이터 유형을 알려줌
				success : function(result) {
					console.log(result);
					$("#goods_content").val(result);
				}, // end success
				complete:function(){
					// AJAX 요청 완료 후 버튼을 다시 활성화
					button.disabled = false;
				    button.innerHTML = "AI 글 검토";
				}, // end complete
				error : function(xhr, status, error) {
					console.log(data)
					console.error("API 호출 실패: ", status, error);
				} //  end error
			});// end ajax 

		}// end if
	}

	/* if(content.value.length > 200){
		alert("내용을 200자 이내로 입력 하세요.");
		content.focus();
		return false;
	} */
</script>

<body class="pt-5">
	<!-- header : 부트스트랩, 제이쿼리 불러오기-->
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<!-- navbar -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

	<div class="container my-5 goods_form">
		<br>
		<!-- 상품 수정 폼 -->
		<form action="goods_update?goods_no=${goods.goods_no }" method="post" enctype="multipart/form-data">
			<div class="form-group row mt-1">
				<label for="title" class="col-sm-2 col-form-label fw-bold">상품 제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="goods_name" name="goods_name" placeholder="상품 제목" value="${goods.goods_name }">
				</div>
			</div>

			<div class="form-group row mt-3">
				<label for="goods_category" class="col-sm-2 col-form-label fw-bold">카테고리</label>
				<div class="col-sm-10">
					<select class="form-select" id="category_no" name="category_no">
						<option value="0">카테고리 선택</option>
						<c:forEach items="${Category}" var="Category">
							<option value="${Category.category_no }"
								<c:if test="${Category.category_no eq goods.category_no }"> selected</c:if>
								>${Category.category_name}</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="form-group row mt-3">
				<label for="goods_price" class="col-sm-2 col-form-label fw-bold">가격</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="goods_price" name="goods_price" min="0" max="99999999"
					placeholder="숫자만 입력해주세요." value="${goods.goods_price }">
				</div>
			</div>

			<div class="form-group row mt-3">
				<label for="goods_content" class="col-sm-2 col-form-label fw-bold">상품 설명</label>
				<div class="col-sm-8">
					<textarea class="form-control" id="goods_content" name="goods_content" rows="5" 
					placeholder="AI가 작성한 글을 검토해드려요!">${goods.goods_content }</textarea>
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-primary btn-sm" id="gptButton" onClick="gpt_write()">AI 글 검토</button>
				</div>
			</div>
			
			<div class="form-group row mt-3">
				<label for="images" class="col-sm-2 col-form-label fw-bold">상품 이미지</label>
				<div class="col-sm-6 input_container my-auto">
					<input type="file" class="form-control-file" id="images" name="images" multiple value="${goods.goods_image}">
					<p class="fst-italic">파일은 3장까지 업로드 가능하며, 9MB가 넘지 않아야 합니다.</p>
				</div>
			</div>

			<div class="form-group row mt-3">
				<label for="image_list" class="col-sm-2 col-form-label fw-bold">현재 등록된 파일</label>
				<c:forEach items="${image_list}" var="image_list">
					<div class="col-sm-2 input_container my-auto img-container">
						<img src="upload/${image_list }" class="img-fluid" alt="...">
					</div>
				</c:forEach>
			</div>

			<div class="text-center mt-3">
				<button type="submit" class="btn btn-primary" onclick="return validate_write()">상품 등록</button>
			</div>
		</form>
	</div><!-- end 상품 등록 작성 폼 -->

</body>
<!-- footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>