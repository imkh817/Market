package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {
	@RequestMapping("test")
	public String test(){
		System.out.println("컨트롤러 들어옴");
		
		return "test";
	}
}
