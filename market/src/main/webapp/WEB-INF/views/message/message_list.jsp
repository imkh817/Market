<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방</title>

<!-- CSS File -->
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/navbar.css">
<link rel="stylesheet" href="./css/message_list.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.17.0/font/bootstrap-icons.css">
<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"
	type="text/css" rel="stylesheet" />
</head>
<body>
<br><br><br><br><br>
	<!-- 메뉴바 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<div class="msg-container">
		<div class="messaging">
			<div class="inbox_msg">
				<!-- 메세지 목록 영역 -->
				<div class="inbox_people">
					<div class="headind_srch">
						<div class="recent_heading">
							<input class="btn" type="button" value="채팅">
						</div>
					</div>
					<!-- 메세지 리스트 -->
					<div class="inbox_chat"></div>
				</div>

				<!-- 메세지 내용 영역 -->
				<div class="mesgs">
					<!-- 메세지 내용 목록 -->
					<div class="msg_history" name="contentList">
						<!-- 메세지 내용이 올 자리 -->
					</div>
					<div class="send_message"></div>
					<!-- 메세지 입력란이 올자리 -->
				</div>
			</div>

		</div>
	</div>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
	
    // JSTL을 사용하여 JSP 내에서 Java 변수를 JavaScript로 가져오기
    var memberNo = ${param.member_no};
    
    
/* 	const intervalId = setInterval(function () {
	   }(), 3000); */
    
    // 채팅방 만들기
       $(document).ready(function() {
        // Ajax를 사용하여 서버로 데이터 전송
        $.ajax({
            type: "POST",  // 또는 "GET" 등 필요에 따라 변경
            url: "message_list",
            data: {
                member_no: memberNo
            },
            success: function(response) {
            	// 채팅방 리스트 주기적으로 리로드
            	RoomInterval = setInterval(function () {
            	FirstMessageList();
            	       }, 3000);
                // 서버 응답에 대한 처리
                console.log(response);
            }
        });
    });
	   
	// 가장 처음 웹페이지를 로드 했을 시에 채팅룸 리스트를 가져온다.
	const FirstMessageList = function(){
		$.ajax({
			url:"message_ajax_list",
			method:"get",
			data:{
			},
			success:function(data){
				// <div class="inbox_chat"></div> 에 데이터를 넣는다.
				$('.inbox_chat').html(data);
				 
				// message_ajax_list.jsp의 'chat_list' 버튼 중 하나를 클릭했을 때
				$('.chat_list').on('click', function(){

					// 포함된 html 요소에서 room과 other_nick의 값을 가져와 각각 할당한다.
					let room = $(this).attr('room');
					let other_nick = $(this).attr('other-nick');
					
					// 선택한 메세지빼고 나머지는 active 효과 해제하기
					$('.chat_list_box').not('.chat_list_box.chat_list_box'+room).removeClass('active_chat');
					// 선택한 메세지만 active 효과 주기
					$('.chat_list_box'+room).addClass('active_chat');
					
					let send_msg = "";
					send_msg += "<div class='type_msg'>";
					send_msg += "	<div class='input_msg_write row'>";
					send_msg += "		<div class='col-11'>";
					send_msg += "			<input type='text' class='write_msg form-control' placeholder='메세지를 입력...' />";
					send_msg += "		</div>";
					send_msg += "		<div class='col-1'>";
					send_msg += "			<button class='msg_send_btn' type='button'><i class='fa fa-paper-plane-o' aria-hidden='true'></i></button>";
					send_msg += "		</div>";
					send_msg += "	</div>";
					send_msg += "</div>";
			          
					// 메세지 입력, 전송 칸을 보인다.
					$('.send_message').html(send_msg);
					
					// 메세지 전송버튼을 눌렀을 때
					$('.msg_send_btn').on('click',function(){
						
						// 메세지 전송 함수 호출
						SendMessage(room, other_nick);
						// 전송버튼을 누르면 메세지 리스트가 리로드 되면서 현재 열린 메세지의 선택됨 표시가 사라진다.
						// 이걸 해결하기 위해 메세지 전송버튼을 누르고 메세지 리스트가 리로드되면 메세지 리스트의 첫번째 메세지(현재 열린 메세지)가 선택됨 표시 되도록 한다.
						// $('.chat_list_box:first').addClass('active_chat');
						
					});
					
					// 엔터 키 이벤트
				    $('.write_msg').on('keypress', function(event) {
				        // event.which는 브라우저 호환성을 위한 것으로 엔터 키의 경우 13입니다.
				        if (event.which === 13) {
				            // 엔터 키가 눌렸을 때 SendMessage 함수 호출
				            SendMessage(room, other_nick);
				        }
				    });
					
					// 메세지 내용을 가져온다.
					MessageContentList(room, other_nick);
					
			        // 채팅방 내의 메세지 자동 로드 기능
			        if (typeof intervalId === 'undefined') {
			            // 전역 변수에 할당
			            intervalId = setInterval(function () {
			                // 클로저를 사용하여 외부 변수에 접근
			                

			            IntervalMessageContentList(room, other_nick);
			            RoomInterval();
			            }, 3000);
			        } else {
			            // 이미 intervalId가 정의되어 있다면 clearInterval 호출
			            clearInterval(intervalId);
			            // 초기화
			            intervalId = undefined;
		          	  	intervalId = setInterval(function () {
		                // 클로저를 사용하여 외부 변수에 접근
		                IntervalMessageContentList(room, other_nick);
		                RoomInterval();
		            }, 3000);
			        }
				});
			}
		}) 
	};
	
	
	// 메세지 리스트를 다시 가져온다.
	const MessageList = function(){

		$.ajax({
			url:"message_ajax_list",
			method:"get",
			data:{
			},
			success:function(data){
				console.log("메세지 리스트 리로드 성공");
				
				$('.inbox_chat').html(data);
				
				// 메세지 리스트중 하나를 클릭했을 때
				$('.chat_list').on('click', function(){
					let room = $(this).attr('room');
					let other_nick = $(this).attr('other-nick');
					// 선택한 메세지빼고 나머지는 active 효과 해제하기
					$('.chat_list_box').not('.chat_list_box.chat_list_box'+room).removeClass('active_chat');
					// 선택한 메세지만 active 효과 주기
					$('.chat_list_box'+room).addClass('active_chat');
					// 메세지 입력 및 출력란 보이기
					let send_msg = "";
					send_msg += "<div class='type_msg'>";
					send_msg += "	<div class='input_msg_write row'>";
					send_msg += "		<div class='col-11'>";
					send_msg += "			<input type='text' class='write_msg form-control' placeholder='메세지를 입력...' />";
					send_msg += "		</div>";
					send_msg += "		<div class='col-1'>";
					send_msg += "			<button class='msg_send_btn' type='button'><i class='fa fa-paper-plane-o' aria-hidden='true'></i></button>";
					send_msg += "		</div>";
					send_msg += "	</div>";
					send_msg += "</div>";
			          
					// 메세지 입력, 전송 칸을 보인다.
					$('.send_message').html(send_msg);
					
					// 메세지 전송버튼을 눌렀을 때
					$('.msg_send_btn').on('click',function(){
						
						// 메세지 전송 함수 호출
						SendMessage(room, other_nick);
						
						// 전송버튼을 누르면 메세지 리스트가 리로드 되면서 현재 열린 메세지의 선택됨 표시가 사라진다.
						// 이걸 해결하기 위해 메세지 전송버튼을 누르고 메세지 리스트가 리로드되면 메세지 리스트의 첫번째 메세지(현재 열린 메세지)가 선택됨 표시 되도록 한다.
						 $('.chat_list_box:first').addClass('active_chat');
					});
					
					// 메세지 내용을 불러오는 함수 호출
					MessageContentList(room);

				});
				
				// 전송버튼을 누르면 메세지 리스트가 리로드 되면서 현재 열린 메세지의 선택됨 표시가 사라진다.
				// 이걸 해결하기 위해 메세지 전송버튼을 누르고 메세지 리스트가 리로드되면 메세지 리스트의 첫번째 메세지(현재 열린 메세지)가 선택됨 표시 되도록 한다.
				$('.chat_list_box:first').addClass('active_chat');
			}
		})
	};
/* 	
	// 검색한 메세지 리스트 가져오기
	const ResearchMessageList = function(){

		$.ajax({
			url:"research_message_ajax_list",
			method:"get",
			data:{
			},
			success:function(data){
				console.log("메세지 리스트 리로드 성공");
				
				$('.inbox_chat').html(data);
				
				// 메세지 리스트중 하나를 클릭했을 때
				$('.chat_list').on('click', function(){
					let room = $(this).attr('room');
					let other_nick = $(this).attr('other-nick');
					// 선택한 메세지빼고 나머지는 active 효과 해제하기
					$('.chat_list_box').not('.chat_list_box.chat_list_box'+room).removeClass('active_chat');
					// 선택한 메세지만 active 효과 주기
					$('.chat_list_box'+room).addClass('active_chat');
					// 메세지 입력 및 출력란 보이기
					let send_msg = "";
					send_msg += "<div class='type_msg'>";
					send_msg += "	<div class='input_msg_write row'>";
					send_msg += "		<div class='col-11'>";
					send_msg += "			<input type='text' class='write_msg form-control' placeholder='메세지를 입력...' />";
					send_msg += "		</div>";
					send_msg += "		<div class='col-1'>";
					send_msg += "			<button class='msg_send_btn' type='button'><i class='fa fa-paper-plane-o' aria-hidden='true'></i></button>";
					send_msg += "		</div>";
					send_msg += "	</div>";
					send_msg += "</div>";
			          
					// 메세지 입력, 전송 칸을 보인다.
					$('.send_message').html(send_msg);
					
					// 메세지 전송버튼을 눌렀을 때
					$('.msg_send_btn').on('click',function(){
						
						// 메세지 전송 함수 호출
						SendMessage(room, other_nick);
						
						// 전송버튼을 누르면 메세지 리스트가 리로드 되면서 현재 열린 메세지의 선택됨 표시가 사라진다.
						// 이걸 해결하기 위해 메세지 전송버튼을 누르고 메세지 리스트가 리로드되면 메세지 리스트의 첫번째 메세지(현재 열린 메세지)가 선택됨 표시 되도록 한다.
						 $('.chat_list_box:first').addClass('active_chat');
					});
					
					// 메세지 내용을 불러오는 함수 호출
					MessageContentList(room);

				});
				
				// 전송버튼을 누르면 메세지 리스트가 리로드 되면서 현재 열린 메세지의 선택됨 표시가 사라진다.
				// 이걸 해결하기 위해 메세지 전송버튼을 누르고 메세지 리스트가 리로드되면 메세지 리스트의 첫번째 메세지(현재 열린 메세지)가 선택됨 표시 되도록 한다.
				$('.chat_list_box:first').addClass('active_chat');
			}
		})
	}; */
	
	// 메세지 내용을 가져온다.
	// 읽지 않은 메세지들을 읽음으로 바꾼다.
		const MessageContentList = function(room, other_nick) {
			$.ajax({
				url : "message_content_list",
				method : "GET",
				data : {
					room : room,
					other_nick : other_nick
				},
				success : function(data) {
					// 메세지 내용을 html에 넣는다
					// html(data)를 활용하여 ajax로 구해온 message_content_list.jsp의 양식을 
					// data 값을 넣어 그대로 넣는다
					$('.msg_history').html(data);

					// 이 함수로 메세지 내용을 가져올때마다 스크롤을 맨아래로 가게 한다.
					$(".msg_history").scrollTop(
							$(".msg_history")[0].scrollHeight);
				},
				error : function() {
					alert('서버 에러');
				}
			})
			// 데이터가 아닌 함수 자체의 값을 비워준다.
			$('.unread' + room).empty();
		};
		
		// 반복 하기 위한 MessageContentList
		const IntervalMessageContentList = function(room, other_nick) {
			$.ajax({
				url : "message_content_list",
				method : "GET",
				data : {
					room : room,
					other_nick : other_nick
				},
				success : function(data) {
					// 메세지 내용을 html에 넣는다
					$('.msg_history').html(data);
				},
				error : function() {
					alert('서버 에러');
				}
			})
			// 데이터가 아닌 함수 자체의 값을 비워준다.
			$('.unread' + room).empty();
		};


		// 메세지를 전송하는 함수
		const SendMessage = function(room, other_nick) {
			let message_content = $('.write_msg').val().trim();
			//alert("content: " + content);
			if (message_content == "") {
				alert("메세지를 입력하세요!");
			} else {
				$.ajax({
					url : "message_send_inlist",
					method : "GET",
					data : {
						room : room,
						other_nick : other_nick,
						content : message_content
					},
					success : function(data) {
						console.log("메세지 전송 성공");

						// 메세지 입력칸 비우기
						$('.write_msg').val("");

  						// 메세지 내용  리로드
						MessageContentList(room);

						// 메세지 리스트 리로드
						MessageList();
						
						FirstMessageList();
						
					},
					error : function() {
						alert('서버 에러');
					}
				});
			}

		};
		
		
		$(document).ready(function() {
			// 메세지 리스트 리로드
			FirstMessageList();
		});
		
		// 자동 로드 기능 구현하자.    
/*		const intervalId = setInterval(function (room, other_nick) {
	        // 클로저를 사용하여 외부 변수에 접근
	        return function () {
		            // 메세지 내용 리로드
	            MessageContentList(room, other_nick);
	        };
	    }(room, other_nick), 3000); */
	</script>
</body>
<!-- load 함수로 동적 교체 -->
<script>
	$(".category").load("<c:url value='navbar' />");
</script>
</html>