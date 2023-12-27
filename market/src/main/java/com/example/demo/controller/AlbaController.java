package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AlbaController {

	// 알바 메인 페이지 이동
	@RequestMapping("alba_main")
	public String alba_main() {
		return "alba/alba_main";
	}
}
