package com.example.demo.controller;

import org.springframework.web.bind.annotation.RequestMapping;

public class HomeController {
	
	@RequestMapping("home")
	public String home(){
		return "home";
	}
	
	@RequestMapping("auth_location")
	public String auth_location(){
		return "auth_location";
	}
	
}
