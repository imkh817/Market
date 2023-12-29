package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.Goods;
import com.example.demo.service.DetailService;

@Controller

public class DetailController {

	@Autowired
	private DetailService detailService;

//	상세페이지 이동 및 데이터 불러오기
	@RequestMapping("detail")
	public String detail_goods(Goods goods, HttpSession session, Model model) {

		System.out.println("상세페이지 들어옴");

//		데이터 불러오기
		List<Map<String, Object>> detail_result = detailService.detail_goods(goods);
		System.out.println("상세 goods_no 기반 데이터 = " + detail_result);
		
//		인기상품 5개
		List<Map<String, Object>> best_detail = detailService.best_detail(goods.getGoods_no());
		System.out.println("상세 goods_readcount 기반 데이터 = " + best_detail);
		
//		시간 분단위 출력
		int minute = detailService.goods_reg_minute(goods.getGoods_no());
		
//		조회수 증가
		int read_count_up = detailService.read_count_up(goods);
		
//		회원 별명 불러오기
//		String member_nick_load = detailService.member_nick_load(goods.getGoods_no());
		
		int session_member_no = (int) session.getAttribute("member_no");
		
		model.addAttribute("detail_result", detail_result);
		model.addAttribute("minute", minute);
		model.addAttribute("read_count_up", read_count_up);
		model.addAttribute("best_detail", best_detail);
//		model.addAttribute("member_nick_load", member_nick_load);
		model.addAttribute("session_member_no", session_member_no);
//		model.addAttribute("heart_click", heart_click);
		
		return "goods/detail";
	}
	
//	상품 삭제
	@RequestMapping("detail_delete")
	public String detail_delete(int goods_no, Model model) {
		int detail_delete = detailService.detail_delete(goods_no);
		
		model.addAttribute("detail_delete", detail_delete);
		System.out.println("상품 삭제 detail_delete = " + detail_delete);
		
		
		return "goods/detail_delete";
	}
		
	
	
	
}
