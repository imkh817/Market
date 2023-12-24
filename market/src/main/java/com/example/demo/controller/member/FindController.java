package com.example.demo.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.MemberDao;
import com.example.demo.model.Member;
import com.example.demo.service.join.JoinService;
import com.example.demo.service.join.SendMessageService;
import com.example.demo.service.login.FindService;
import com.example.demo.service.login.LoginService;

@Controller
public class FindController {
	
	@Autowired
	JoinService joinService;
	
	@Autowired
	FindService findService;
	
	@Autowired
	SendMessageService smsService;
	
	@Autowired
	MemberDao memberDao;
	
	// 아이디 찾기 페이지로 이동
	@RequestMapping("find_id_form")
	public String find_id_form() {
		return "access/find_id_form";
	}
	
	// 아이디 찾기
	@RequestMapping("find_id")
	public String find_id(Member member,Model model) {
		Member user = findService.find_id(member);
		// 아이디 찾기 실패시 uesr = null -> 뷰에서 되돌아가기 처리
		if(user != null) user.setMember_id(findService.replace_id(user.getMember_id())); // 아이디 앞에 3글자만 표시!
		model.addAttribute("member",user);
		
		return "access/find_id_result";
	}
	
	// 비밀번호 찾기 페이지로 이동
	@RequestMapping("find_pw_form")
	public String find_pw_form() {
		return "access/find_pw_form";
	}
	
	// 비밀번호 찾기 문자발송
	@PostMapping("phone_autorization_pw")
	@ResponseBody
	public String phone_autorization_pw(String number) {
		String result = smsService.sendOne(number);
		return result;
	}
	
	// 비밀번호 찾기
	@PostMapping("find_pw")
	public String find_pw(Member member,Model model) {
		String new_pw = smsService.get_autorization_number(); // 새로운 암호
		String result = smsService.sendOne(member.getMember_phone_num(),new_pw);
		member.setMember_pw(joinService.encode_password(new_pw));
		int update = findService.update_pw(member);
		
		model.addAttribute("result",result);
		return "access/find_pw_result";
		
	}
}
