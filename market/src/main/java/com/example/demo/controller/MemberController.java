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

	@RequestMapping("auth")
	@ResponseBody
	public int auth(HttpSession session, @RequestParam("member_auth_add") String member_auth_add, Member member){
		
		String member_id = (String)session.getAttribute("member_id");
		
		member.setMember_id(member_id);
		member.setMember_auth_add(member_auth_add);

		int result = memberService.update_member_add(member);
		return result;
	}	

}
