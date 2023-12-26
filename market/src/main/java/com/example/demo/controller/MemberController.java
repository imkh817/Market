package com.example.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.Member;
import com.example.demo.service.MemberService;
import com.example.demo.service.login.LoginService;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	// 위치 인증
	@RequestMapping("auth")
	@ResponseBody
	public int auth(HttpSession session, @RequestParam("member_auth_add") String member_auth_add, Member member){
		// 로그인 세션으로 아이디 조회
		String member_id = (String)session.getAttribute("member_id");
		// 세션 아이디값 부여
		member.setMember_id(member_id);
		// 위치정보 부여
		member.setMember_auth_add(member_auth_add);

		int result = memberService.update_member_add(member);
		return result;
	}	
}
