package com.example.demo.controller;

import java.io.File;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.MemberDao;
import com.example.demo.model.Category;
import com.example.demo.model.Goods;
import com.example.demo.model.Member;
import com.example.demo.service.CategoryService;
import com.example.demo.service.GoodsService;

@Controller
public class GoodsController {
	
	@Autowired 
	private CategoryService CategoryService; 
	
	@Autowired
	private GoodsService GoodsService;
	
	@Autowired
	private MemberDao MemberDao;

	// 글 목록
	@RequestMapping("list")
	public String list(Model model) {
		List<Goods> goods_list = GoodsService.select_goods_list();
		model.addAttribute("goods_list", goods_list);
		return "goods/goods_list";
	}
	
	// 상품판매 글 등록 폼
	@RequestMapping("sell_form")
	public String sell_form(Model model) {
		
		// 카테고리 불러오기
		List<Category> Category = CategoryService.get_category();
		
		model.addAttribute("Category",Category);
		return "goods/sell_form";
	}
	
	// 상품 판매 글 등록
	@RequestMapping(value="goods_reg", method = RequestMethod.POST)
	public String goods_reg(@RequestParam(name="images") MultipartFile[] mf, Goods goods, Member member,
						HttpServletRequest request, HttpSession session, Model model) throws Exception {
		
		for(MultipartFile MultipartFile : mf) {
			System.out.println("컨트롤러 받아온 이미지: "+ MultipartFile);
		}
		
		// 첨부파일 갯수가 3개 넘어갈때
		if (mf.length > 3) {
			model.addAttribute("result", 1);
			return "goods/uploadResult";  
		}
		
		// 이미지 업로드
		String upload_result = GoodsService.image_upload(mf, request);
		
		// 첨부파일 사이즈가 클 때
		if (upload_result.equals("FileSizeOver")){
			model.addAttribute("result", 2);
			return "goods/uploadResult";
			
		// 파일 확장자가 다를 때
		}else if (upload_result.equals("FileNotMatch")){
			model.addAttribute("result", 3);
			return "goods/uploadResult";
		}else {
			goods.setGoods_image(upload_result);
		}
		
		// 세션에 저장된 member_no를 goods객체 member_no에 저장
		goods.setMember_no((int)session.getAttribute("member_no"));
		
		// 세션에 저장된 member_id로 member 위치정보를 조회
		member.setMember_id((String)session.getAttribute("member_id"));
		
		// 사용자 위치 인증받은 주소를 goods_place에 저장
		goods.setGoods_place(MemberDao.user_check(member).getMember_auth_add());
		
		System.out.println(goods.toString());
		
		int result = GoodsService.goods_reg(goods);
		
		model.addAttribute("result",result);
		return "goods/reg_result";
	}
}