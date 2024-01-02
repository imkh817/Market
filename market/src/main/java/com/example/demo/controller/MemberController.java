package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.Goods;
import com.example.demo.model.Member;
import com.example.demo.service.MemberService;
import com.example.demo.service.login.LoginService;

@Controller
public class MemberController {

	@Autowired
	private MemberService MemberService;

	// 위치 인증 폼
	@RequestMapping("auth_location")
	public String auth_form(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String member_id = (String)session.getAttribute("member_id");
		
		if(member_id == null)
			return "redirect:/login";
			
		Member member = MemberService.get_member(member_id);
		
		model.addAttribute("mem", member);
		
		return "auth_location";
	}
	
	// 위치 인증 실행
	@RequestMapping("auth")
	@ResponseBody
	public int auth(HttpSession session, @RequestParam("member_auth_add") String member_auth_add, Member member){
		// 로그인 세션으로 아이디 조회
		String member_id = (String)session.getAttribute("member_id");
		// 세션 아이디값 부여
		member.setMember_id(member_id);
		// 위치정보 부여
		member.setMember_auth_add(member_auth_add);

		int result = MemberService.update_member_add(member);
		return result;
	}	
}
