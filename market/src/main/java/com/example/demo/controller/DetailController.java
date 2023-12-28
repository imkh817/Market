package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.model.Goods;
import com.example.demo.model.Member;
import com.example.demo.service.DetailService;

@Controller

public class DetailController {

	@Autowired
	private DetailService detailService;

//	상세페이지 이동 및 데이터 불러오기
	@RequestMapping("detail")
	public String detail_goods(@RequestParam int goods_no, Goods goods, Member member, HttpSession session, Model model) {

		System.out.println("상세페이지 들어옴");

		goods.setGoods_no(goods_no);
		System.out.println("세션으로 가져온 goods_no = " + goods.getGoods_no());
		
//		임시 세션
		goods.setMember_no(7);
		
//		System.out.println("세션으로 가져온 member_no = " + (int) session.getAttribute("member_no"));

//		데이터 불러오기
		List<Map<String, Object>> detail_result = detailService.detail_goods(goods);
		
//		인기상품 5개
		List<Map<String, Object>> best_detail = detailService.best_detail(goods_no);
		System.out.println("상세 goods_readcount 기반 데이터 = " + best_detail);
		
//		시간 분단위 출력
		int minute = detailService.goods_reg_minute(goods_no);
		
//		조회수 증가
		int read_count_up = detailService.read_count_up(goods);
		
		model.addAttribute("detail_result", detail_result);
		model.addAttribute("minute", minute);
		model.addAttribute("read_count_up", read_count_up);
		model.addAttribute("best_detail", best_detail);
		
		
		
		return "goods/detail";
	}
	
//	인기상품 출력
		
		

	
	
	
	
}
