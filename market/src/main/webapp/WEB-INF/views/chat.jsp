<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<meta charset="UTF-8">
<title>Chating</title>
<style>
* {
	margin: 0;
	padding: 0;
}

.container {
	width: 500px;
	margin: 0 auto;
	padding: 25px;
}

.container h1 {
	text-align: left;
	padding: 5px 5px 5px 15px;
	color: #FFBB00;
	border-left: 3px solid #FFBB00;
	margin-bottom: 20px;
}

.chating {
	background-color: #000;
	width: 500px;
	height: 500px;
	overflow: auto;
}

.chating p {
	color: #fff;
	text-align: left;
}

input {
	width: 330px;
	height: 25px;
}

#yourMsg {
	display: none;
}
</style>
</head>

<script type="text/javascript">
	// ws 객체 생성
	var ws;
	
	function wsOpen() {
		// ws 객체를 웹소켓 객체로 선언
		ws=new WebSocket("ws://" + location.host + "/chating");
		// ws 웹소켓 객체(/chating)가 실행되면 wsEvt() 메소드를 실행
		wsEvt();
	}
	
	function wsEvt() {
		// 소켓이 열리면 초기화를 진행
		ws.onopen = function (data) {
		}
		// 웹소켓에서 메세지를 수신할 때 실행
		ws.onmessage = function (data) {
			// 수신된 메세지를 msg 변수에 저장
			var msg = data.data;
			// 수신된 메세지가 null이 아니고 공백이 아닌 경우
			if(msg != null && msg.trim()!=""){
				// #chating에 msg를 출력한다.
				$("#chating").append("<p>" + msg + "</p>");
			}
		}
		// enter 키를 누를 때, send() 메소드 실행
		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){ //enter press
				send();
			}
		});
	}
	
	function chatName(){
		var userName = $("#userName").val();
		// userName이 null 값이거나 공백일 경우
		if(userName == null || userName.trim() == ""){
			alert("사용자 이름을 입력해주세요.")
			$("#userName").focus();
		}else{
		// userName이 null 값이 아니거나 공백이 아닌 경우
		// wsOpen() 메소드를 실행한다.
			wsOpen();
			$("#yourName").hide();
			$("#yourMsg").show();
		}
	}
	function send(){
		var uN = $("#userName").val();
		var msg = $("#chatting").val();
		ws.send(uN + ":" + msg);
		$("#chatting").val("");
	}
</script>

<body>
	<div id="container" class="container">
		<h1>채팅</h1>
		<div id="chating" class="chating">
		</div>
		<div id="yourName">
			<table class="inputTable">
				<tr>
				<th>사용자명</th>
					<th><input type="text" name="userName" id="userName"></th>
					<th><button onclick="chatName()" id="starBtn">이름 등록</button></th>
				</tr>
			</table>
		</div>
		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th>메세지</th>
					<th><input id="chatting" placeholder="메세지를 입력하세요."></th>
					<th><button onclick="send()" id="sendBtn">보내기</button></th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>