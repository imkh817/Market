package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.Goods;
import com.example.demo.model.Member;
import com.example.demo.model.PagingPgm;
import com.example.demo.service.login.LoginService;
import com.example.demo.service.mypage.MypageService;

@Controller
public class MypageController {
	
	@Autowired
	MypageService mypageService;
	@Autowired
	LoginService loginService;

//	// 마이페이지 홈화면
//	@RequestMapping("mypage_form")
//	public String mypage() {
//		return "mypage/mypage_form";
//	}
	
	// 판매 내역
	@RequestMapping("mypage_list")
	public String mypagelist(Model model, String page, HttpSession session) {
		PagingPgm pp = mypageService.paging(page, (int)session.getAttribute("member_no"));
		List<Goods> mypage_list = mypageService.getList(pp, (int)session.getAttribute("member_no"));
		System.out.println("list : " + mypage_list);
		
		int sell_count = pp.getTotal();
		int liked_count = mypageService.paging_liked(page,(int)session.getAttribute("member_no")).getTotal();
		
		model.addAttribute("member_nickname", session.getAttribute("member_nickname"));
		model.addAttribute("sell_count", sell_count);
		model.addAttribute("liked_count", liked_count);
		model.addAttribute("list", mypage_list);
		model.addAttribute("page", pp);
		
		return "mypage/mypage_list";
	}
	
	// 회원 삭제 폼
	@RequestMapping("member_delete_form")
	public String member_delete_form() {
		return "mypage/member_delete_form";
	}
	
	// 회원 삭제
	@RequestMapping("member_delete")
	public String member_delete(Member member, Model model, HttpSession session) {
	
		int result = mypageService.member_delete(member, session);
		System.out.println("멤버 삭제 됐는지 확인 : " + result);
		model.addAttribute("result", result);
		
		return "mypage/member_delete_result";
	}
	
	// 찜한 상품
	@RequestMapping("member_liked_form")
	public String member_liked_form(Model model, HttpSession session, String page) {
		PagingPgm pp = mypageService.paging_liked(page, (int)session.getAttribute("member_no"));
		List<Map<String, Object>> liked_list = mypageService.liked_list(pp, (int)session.getAttribute("member_no"));
		System.out.println("liked_list : " + liked_list);
		
		int sell_count = mypageService.paging(page,(int)session.getAttribute("member_no")).getTotal();;
		int liked_count = pp.getTotal();
		
		model.addAttribute("sell_count", sell_count);
		model.addAttribute("liked_count", liked_count);
		model.addAttribute("list", liked_list);
		model.addAttribute("page", pp);
		
		return "mypage/member_liked_form";
	}
	
	// 상품 상태 업데이트
	@RequestMapping("goods_state_update")
	public String goods_state_update(Goods goods, Model model) {
		System.out.println("goods_state_update 입성");
		int result = mypageService.goods_state_update(goods);
		System.out.println("goods_state_update 실행 완료");
		
		model.addAttribute("result", result);
		return"mypage/goods_state_update_result";
	}
	
}


