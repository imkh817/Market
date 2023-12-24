package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.Goods;
import com.example.demo.service.GoodsService;

@Controller
public class GoodsController {
	@Autowired
	private GoodsService goodsService;

	// 글 목록
	@RequestMapping("list")
	public String list(Model model) {
		List<Goods> goods_list = goodsService.select_goods_list();
		model.addAttribute("goods_list", goods_list);
		return "goods/goods_list";
	}
	
	// 상품판매 글 등록
	@RequestMapping("sell")
	public String sell() {
		
		return "goods/goods_sell_form";
	}
}