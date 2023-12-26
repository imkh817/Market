function id_valiable1(){
	var member_id = document.getElementById('member_id').value;
	
	$.ajax({
		url : "id_valiable",
		type : "POST",
		data : {"member_id":member_id},
		success : function(data){
 			if(data != "사용 가능한 아이디 입니다."){
				document.getElementById('member_id').value = "";
				document.getElementById('member_id').focus(); 
				document.getElementById('id_valiable').value = data;
				document.getElementById('id_valiable').style.display = 'block';
				 }else{
					document.getElementById('id_valiable').value = data;
					document.getElementById('id_valiable').style.display = 'block';
				} 
			}
		})
	} 

function name_valiable1(){
	var member_nickname = document.getElementById('member_nickname').value;
	
	$.ajax({
		url : "nickname_valiable",
		type : "POST",
		data : {"member_nickname" : member_nickname},
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

function phone_authorization1() {
    var number = document.getElementById('member_phone_num').value
    $.ajax({
    	url : "phone_autorization",
    	type : "POST",
    	data : {"number" : number},
    	success : function(data){
    		if(data == '이미 가입되어 있는 번호 입니다.'){
    			document.getElementById('member_phone_num').value = '';
    			document.getElementById('member_phone_num').focus(); 
    			document.getElementById('phone_number_valiable').value = data;
				document.getElementById('phone_number_valiable').style.display = 'block';
    		}else{
    		document.getElementById('phone_number_valiable').style.display = 'none';	
    		document.getElementById('phone_authorization_value').value = data;
    		document.getElementById('phone_authorization').style.display = 'block';
    		 console.log(data);
    		}
    	}
    })
}

function phone_autorization_pw1(){
	var number = document.getElementById('member_phone_num').value
	 $.ajax({
    	url : "phone_autorization_pw",
    	type : "POST",
    	data : {"number" : number},
    		success : function(data){
    		document.getElementById('phone_authorization_value').value = data;
    		document.getElementById('phone_authorization').style.display = 'block';
    		 console.log(data);
    		}
    	})    
}


function check_phone_authorization1(){
	var server_num = document.getElementById('phone_authorization_value').value;
	var client_num = document.getElementById('client_num').value;
	
	if(server_num == client_num){
		alert('인증완료!');
		$("#joinButton").attr('disabled',false);
	}
	else{
		alert('인증실패!');
	}
}