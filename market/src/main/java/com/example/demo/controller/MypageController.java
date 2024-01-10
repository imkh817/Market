package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.Goods;
import com.example.demo.model.Job;
import com.example.demo.model.Member;
import com.example.demo.model.PagingPgm;
import com.example.demo.model.Translation;
import com.example.demo.service.join.JoinService;
import com.example.demo.service.login.LoginService;
import com.example.demo.service.mypage.CreateImageService;
import com.example.demo.service.mypage.MypageService;
import com.example.demo.service.mypage.TranslationService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

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
	
	@Autowired
	JoinService joinService;

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
		Member member = mypageService.get_member((int)session.getAttribute("member_no"));
		
		int sell_count = pp.getTotal();
		int liked_count = mypageService.paging_liked(page,(int)session.getAttribute("member_no")).getTotal();
		
		model.addAttribute("member", member);
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
		model.addAttribute("result", result);
		if(result == 1) {
			session.invalidate();
		}
		return "mypage/member_delete_result";
	}
	
	// 찜한 상품
	@RequestMapping("member_liked_form")
	public String member_liked_form(Model model, HttpSession session, String page) {
		PagingPgm pp = mypageService.paging_liked(page, (int)session.getAttribute("member_no"));
		List<Map<String, Object>> liked_list = mypageService.liked_list(pp, (int)session.getAttribute("member_no"));
		System.out.println("liked_list : " + liked_list);
		Member member = mypageService.get_member((int)session.getAttribute("member_no"));
		
		int sell_count = mypageService.paging(page,(int)session.getAttribute("member_no")).getTotal();;
		int liked_count = pp.getTotal();
		
		model.addAttribute("member", member);
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
		
	// 마이페이지 정보 수정
	@RequestMapping("member_update_form")
	public String member_update_form(HttpSession session,Model model) {
		
		Member member = mypageService.getMember(session);
		ObjectMapper mapper = new ObjectMapper();
		String jsonMember ="";
		try {
			jsonMember = mapper.writeValueAsString(member);
		} catch (JsonProcessingException e) {
			System.out.println("Json형태로 반환 실패!");
			e.printStackTrace();
		}
		System.out.println(jsonMember);
		model.addAttribute("jsonMember" , jsonMember);
		model.addAttribute("member" , member);
		return "mypage/member_update_form";
	}
	
	// 마이페이지 프로필 이미지 생성
	@RequestMapping("image_ai")
	public String image_ai(String prompt,HttpServletRequest requset,HttpSession session,Model model) {
		if(prompt == "" || prompt == null) {
			return "생성하고싶은 이미지의 설명을 적어주세요.";
		}
		
		// 번역기 api 호출 및 결과 받아오기
		String responseBody = translationService.tanslation(prompt);
		// 번역된 결과 파싱해서 원하는 결과(텍스트 문장) 뽑아오기
		String result = translationService.result(responseBody);
		
		
		String imageResult = imageService.request(result,requset,session);
		
		
		model.addAttribute("result", imageResult);
		
		return "mypage/image_ai_result";
	}
	// 핸드폰 유효성 검사(정보수정)
	@PostMapping("phone_autorization_update")
	@ResponseBody
	public String autorization(String number) {
		// 중복 검사
		int number_valiable = joinService.phone_num_valiable(number);
		
		if(number_valiable == 1) return "이미 가입되어 있는 번호 입니다.";
		else return "사용 가능한 핸드폰 번호 입니다.";
	}
	
	@RequestMapping("member_update")
	public String member_update(@RequestParam("image") MultipartFile mf,HttpServletRequest request,HttpSession session,Member member,Model model) {
		// 1: 성공
		// -1 : 파일 저장 실패
		// -2 : 파일 형식 안맞음
		int result = mypageService.update_member(mf, request, session, member);
		System.out.println("update_result : " + result);
		model.addAttribute("result",result);
		return "mypage/update_result";
	}
	
	@RequestMapping("practice")
	public String practice() {
		return "mypage/practice";
	}
	
	// 마이페이지 구인 공고 리스트
	@RequestMapping("mypage_job_list")
	public String mypage_job_list(String page, HttpSession session, Model model) {
		int member_no = (int)session.getAttribute("member_no");
		PagingPgm pp = mypageService.job_paging(page, member_no);
		List<Job> list = mypageService.get_job(pp, member_no);
		System.out.println("mypage job list : " + list);
		
		model.addAttribute("page", pp);
		model.addAttribute("list", list);
		
		return "mypage/mypage_job_list";
	}
}



















