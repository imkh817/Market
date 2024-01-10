package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.Goods;
import com.example.demo.model.Liked;
import com.example.demo.model.Member;
import com.example.demo.model.PagingPgm;
import com.example.demo.service.CategoryService;
import com.example.demo.service.DetailService;
import com.example.demo.service.LikedService;
import com.example.demo.service.MemberService;
import com.example.demo.service.mypage.MypageService;

@Controller

public class DetailController {

	@Autowired
	private DetailService detailService;

	@Autowired
	private LikedService likedService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MypageService mypageService;

//	상세페이지 이동 및 데이터 불러오기
	@RequestMapping("detail")
	public String detail_goods(Goods goods, Member member, HttpSession session, Model model) {

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

//		하트 개수
		int heart_count = likedService.heart_count(goods.getGoods_no());
		
//		카테고리명 가져오기
		String detail_category = categoryService.detail_category(goods);
		
//		회원 닉네임 가져오기
		String detail_nick = memberService.detail_nick(goods);

		model.addAttribute("detail_result", detail_result);
		model.addAttribute("minute", minute);
		model.addAttribute("read_count_up", read_count_up);
		model.addAttribute("best_detail", best_detail);
		model.addAttribute("heart_count", heart_count);
		model.addAttribute("detail_category", detail_category);
		model.addAttribute("detail_nick", detail_nick);

//		하트
		if (session.getAttribute("member_no") != null) {
			int session_member_no = (int) session.getAttribute("member_no");
			System.out.println("session에 저장된 값:" + session_member_no);
			System.out.println("상세 하트 goods_no = " + goods.getGoods_no());
			if (session_member_no != 0) {
				Liked liked = new Liked();
				liked.setGoods_no(goods.getGoods_no());
				liked.setMember_no(session_member_no);
				Liked liked_heart = likedService.liked_heart(liked);
				int heart_result = 0;

				if (liked_heart != null) {
					heart_result = 1;
				}

				System.out.println("상세 하트 liked_heart = " + liked_heart);
				model.addAttribute("session_member_no", session_member_no);
				model.addAttribute("heart_result", heart_result);
			}
		} else {
			System.out.println("member_no가 없어요! 로그인이 필요해요!");
		}

		return "goods/detail";
	}

//	상품 삭제 - 비가시처리
	@RequestMapping("detail_delete")
	public String detail_delete(int goods_no, Model model) {
		int detail_delete = detailService.detail_delete(goods_no);

		model.addAttribute("detail_delete", detail_delete);
		System.out.println("상품 삭제 detail_delete = " + detail_delete);

		return "goods/detail_delete";
	}

//	하트 클릭
	@RequestMapping("/heart_click")
	public void heart_click(int goods_no, int liked_state, HttpSession session, Model model) {
		int session_member_no = (int) session.getAttribute("member_no");
		System.out.println("session으로 가져온 member_no : " + session_member_no);

		Liked liked = new Liked();
		liked.setGoods_no(goods_no);
		liked.setMember_no(session_member_no);
		Liked liked_heart = likedService.liked_heart(liked);
		System.out.println("하트 누른 goods_no = " + goods_no);
		System.out.println("liked_state : " + liked_state);

		if (liked_state == 1) {
			likedService.insert_heart(liked);
		} else {
			likedService.delete_heart(liked);
		}

		model.addAttribute("liked_state", liked_state);

	}
	
//	판매자 프로필
	@RequestMapping("/seller_profile")
	public String seller_profile(String page, Goods goods, HttpSession session, Model model) {
		PagingPgm pp = mypageService.paging(page, goods.getMember_no());
		List<Goods> mypage_list = mypageService.getList(pp, goods.getMember_no());
		
		int sell_count = pp.getTotal();
		int liked_count = mypageService.paging_liked(page,goods.getMember_no()).getTotal();
		
		Member member = mypageService.get_member(goods.getMember_no());
		
		int heart_count = likedService.heart_count(goods.getGoods_no());
		
		model.addAttribute("sell_count", sell_count);
		model.addAttribute("liked_count", liked_count);
		model.addAttribute("list", mypage_list);
		model.addAttribute("page", pp);
		model.addAttribute("member", member);
		model.addAttribute("heart_count", heart_count);
		
		return "mypage/seller_profile";
	}

}
