package com.example.demo.service.join;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Service
public class SendMessageService {

	DefaultMessageService messageService;
	
	private String sendMessageId="NCSIG1FRC0ARBTNI";
	private String sendMessageSecret="YSO3D2MDNESAY2SBOOPPYUQRSHYZ7LXN";

	@Autowired
	public SendMessageService() {
		this.messageService = NurigoApp.INSTANCE.initialize(sendMessageId, sendMessageSecret,
				"https://api.coolsms.co.kr");
	}

	// 인증 번호 생성
	public String get_autorization_number() {
		Random random = new Random();
		int num = random.nextInt(9999) + 1000;
		return String.valueOf(num);
	}
	
	// 인증번호 전송
	public String sendOne(String number) {
		Message message = new Message();
		System.out.println("번호 : " + number);
		String random_number = get_autorization_number();
		System.out.println("인증 번호 : " +random_number);
		message.setFrom("01076841581");
		message.setTo(number);
		message.setText("[양배추 마켓] 회원가입 인증번호는 " + random_number+"입니다.");
		try {
			SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
			System.out.println(response);
			return random_number;
		} catch (Exception e) {
			return "0";
		}

	}
	
	// 비밀번호 전송
	public String sendOne(String number,String pw) {
		Message message = new Message();
		System.out.println("번호 : " + number);
		// 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
		message.setFrom("01076841581");
		message.setTo(number);
		message.setText("[양배추 마켓] 회원님의 재설정된 비밀번호는 " + pw+" 입니다.");
		try {
			SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
			System.out.println(response);
			return pw;
		} catch (Exception e) {
			return "0";
		}

	}
}
