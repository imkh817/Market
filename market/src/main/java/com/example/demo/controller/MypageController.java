package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.Goods;
import com.example.demo.model.Member;
import com.example.demo.model.PagingPgm;
import com.example.demo.model.Translation;
import com.example.demo.service.login.LoginService;
import com.example.demo.service.mypage.CreateImageService;
import com.example.demo.service.mypage.MypageService;
import com.example.demo.service.mypage.TranslationService;

@Controller
public class MypageController {
	
	@Autowired
	MypageService mypageService;
	@Autowired
	LoginService loginService;
	
	@Autowired
	TranslationService translationService;
	
	@Autowired
	CreateImageService imageService;

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
	
	// 마이페이지 정보 수정
	@RequestMapping("member_update_form")
	public String member_update_form(HttpSession session) {
		
		return "mypage/member_update_form";
	}
	
	// 마이페이지 프로필 이미지 생성
	@RequestMapping("image_ai")
	@ResponseBody
	public String image_ai(String prompt,HttpServletRequest requset,HttpSession session) {
		if(prompt == "" || prompt == null) {
			return "생성하고싶은 이미지의 설명을 적어주세요.";
		}
		
		// 번역기 api 호출 및 결과 받아오기
		String responseBody = translationService.tanslation(prompt);
		// 번역된 결과 파싱해서 원하는 결과(텍스트 문장) 뽑아오기
		String result = translationService.result(responseBody);
		
		System.out.println("번역 : " + result);
		
		String imageResult = imageService.request(result,requset,session);
		
		return imageResult;
	}
	
	@RequestMapping("practice")
	public String practice() {
		return "mypage/practice";
	}
}

