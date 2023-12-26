package com.example.demo.controller.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.Member;
import com.example.demo.service.login.LoginService;

@Controller
public class LoginController {
	
	@Autowired
	LoginService loginService;
	
	@RequestMapping("login_form")
	public String login_form() {
		return "access/login_form";
	}
	
	@RequestMapping("login")
	public String login(Member member,HttpSession session,Model model) {
		
		// 조회되지 않는 회원 : -1
		// 로그인 성공 : 1
		// 아이디는 조회되지만 비번 불일치 : 0
		int result = loginService.login_check(member, session);
		 // 로그인 성공 후 세션에서 이전 페이지의 URL을 가져옴
        String referer = (String) session.getAttribute("referer");
        String url = (referer != null) ? referer : "/home";
		model.addAttribute("url",url);
		model.addAttribute("result",result);
		
		return "access/login_result";
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session,Model model) {
		session.invalidate();
		int result = 1;
		model.addAttribute("result",result);
		return "access/logout_result";
	}
}
