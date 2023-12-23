package com.example.demo.controller.member;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	@RequestMapping("login_form")
	public String login() {
		return "access/login_form";
	}
}
