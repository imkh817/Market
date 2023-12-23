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

	@Autowired
	public SendMessageService() {
		// 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
		this.messageService = NurigoApp.INSTANCE.initialize("NCSUZM7NEUI3V6RD", "BWKIZZXINCK9SUV8AKMCTFLN4CB9FS1Q",
				"https://api.coolsms.co.kr");
	}

	// 인증 번호 생성
	public String get_autorization_number() {
		Random random = new Random();
		int num = random.nextInt(9999) + 1000;
		return String.valueOf(num);
	}

	public String sendOne(String number) {
		Message message = new Message();
		System.out.println("번호 : " + number);
		// 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
		String random_number = get_autorization_number();
		System.out.println("인증 번호 : " +random_number);
		message.setFrom("01048553512");
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
}
