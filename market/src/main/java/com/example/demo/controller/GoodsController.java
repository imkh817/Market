package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GoodsController {
	@RequestMapping("list")
	public String test(){
		return "goods_list";
	}
}
