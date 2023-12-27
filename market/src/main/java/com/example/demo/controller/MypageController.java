package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.Goods;
import com.example.demo.model.Liked;
import com.example.demo.model.Member;
import com.example.demo.model.PagingPgm;
import com.example.demo.service.login.LoginService;
import com.example.demo.service.mypage.MypageService;

@Controller
public class MypageController {
	
	@Autowired
	MypageService mypageSerive;
	@Autowired
	LoginService loginService;

	// 마이페이지 첫화면 내가 판매한 상품 리스트
	@RequestMapping("mypage_form")
	public String mypage(Model model, String page, HttpSession session) {
		PagingPgm pp = mypageSerive.paging(page, (int)session.getAttribute("member_no"));
		List<Goods> mypage_list = mypageSerive.getList(pp, (int)session.getAttribute("member_no"));
		System.out.println("list : " + mypage_list);
		
		int sell_count = pp.getTotal();
		int liked_count = mypageSerive.paging_liked(page,(int)session.getAttribute("member_no")).getTotal();
		
		model.addAttribute("member_nickname", session.getAttribute("member_nickname"));
		model.addAttribute("sell_count", sell_count);
		model.addAttribute("liked_count", liked_count);
		model.addAttribute("list", mypage_list);
		model.addAttribute("page", pp);
		
		return "mypage/mypage_form";
	}
	
	// 회원 삭제 폼
	@RequestMapping("member_delete_form")
	public String member_delete_form() {
		return "mypage/member_delete_form";
	}
	
	// 회원 삭제
	@RequestMapping("member_delete")
	public String member_delete(Member member, Model model, HttpSession session) {
	
		int result = mypageSerive.member_delete(member, session);
		System.out.println("멤버 삭제 됐는지 확인 : " + result);
		model.addAttribute("result", result);
		
		return "mypage/member_delete_result";
	}
	
	// 찜한 상품
	@RequestMapping("member_liked_form")
	public String member_liked_form(Model model, HttpSession session, String page) {
		PagingPgm pp = mypageSerive.paging_liked(page, (int)session.getAttribute("member_no"));
		List<Map<String, Object>> liked_list = mypageSerive.liked_list(pp, (int)session.getAttribute("member_no"));
		System.out.println("liked_list : " + liked_list);
		
		int sell_count = mypageSerive.paging(page,(int)session.getAttribute("member_no")).getTotal();;
		int liked_count = pp.getTotal();
		
		model.addAttribute("sell_count", sell_count);
		model.addAttribute("liked_count", liked_count);
		model.addAttribute("list", liked_list);
		model.addAttribute("page", pp);
		
		return "mypage/member_liked_form";
	}
	
	
	
}


