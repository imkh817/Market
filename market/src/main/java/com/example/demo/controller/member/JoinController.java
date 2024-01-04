package com.example.demo.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.Member;
import com.example.demo.service.join.JoinService;
import com.example.demo.service.join.SendMessageService;

@Controller
public class JoinController {
	@Autowired 
	JoinService joinService;
	
	@Autowired
	SendMessageService smsService;
	
	@RequestMapping("join_form")
	public String join_form(){
		return "access/join_form";
	}
	
	@PostMapping("id_valiable")
	@ResponseBody
	public String id_valiable(String member_id) {
		// 유효성 검사
		if(member_id.equals("") || member_id == null) return "아이디를 입력해주세요.";
		if(member_id.length() < 4) return "4자리 이상 입력해주세요.";
		if(member_id.length() > 10) return "10자리 이하로 입력해주세요.";
		
		// 중복 아이디 검사
		int result = joinService.id_valiable(member_id);
		if(result == 1) return "중복된 아이디 입니다.";
		else return "사용 가능한 아이디 입니다.";
	
	}
	@PostMapping("nickname_valiable")
	@ResponseBody
	public String nickname_valiable(String member_nickname) {
		// 유효성 검사
		if(member_nickname.equals("") || member_nickname == null) return "닉네임을 입력해주세요.";
		if(member_nickname.length() < 2) return "2자리 이상 입력해주세요.";
		if(member_nickname.length() > 9) return "8자리 이하로 입력해주세요.";
		
		// 중복 아이디 검사
		int result = joinService.nickname_valiable(member_nickname);
		if(result == 1) return "중복된 닉네임 입니다.";
		else return "사용 가능한 닉네임 입니다.";
		
	}
	
	@PostMapping("phone_autorization")
	@ResponseBody
	public String autorization(String number) {
		// 중복 검사
		int number_valiable = joinService.phone_num_valiable(number);
		
		if(number_valiable == 1) return "이미 가입되어 있는 번호 입니다.";
		else {
			// 인증번호 전송 성공시 result에 인증번호 담김
			// 인증번호 전송 실패시 result값은 0
			String result = smsService.sendOne(number);
			return result;
		}
	}
	
	@RequestMapping("join_member")
	public String join_member(Member member) {
		int result = joinService.join_member(member);
		System.out.println("성공여부 : " + result);
		return "home";
	}
	
}
