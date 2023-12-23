package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GoodsController {
	@RequestMapping("list")
	public String test(){
		return "goods/goods_list";
	}
	
	// 상품판매 글 등록
	@RequestMapping("sell")
	public String sell() {
		
		return "goods/goods_sell_form";
	}
}
