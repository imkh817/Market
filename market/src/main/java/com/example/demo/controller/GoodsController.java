package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.Category;
import com.example.demo.model.Goods;
import com.example.demo.service.CategoryService;
import com.example.demo.service.GoodsService;

@Controller
public class GoodsController {

	@Autowired
	private CategoryService CategoryService;

	@Autowired
	private GoodsService GoodsService;

	// 인기글 목록
	@RequestMapping("best")
	public String list(Model model) {
		List<Goods> goods_list = GoodsService.best_list();
		model.addAttribute("goods_list", goods_list);
		return "best";
	}

	// 글 목록
	@RequestMapping("board")
	public String board(HttpServletRequest request, Goods goods, Model model) {

		List<Goods> goods_list = new ArrayList<Goods>();

		int page = 1;
		int limit = 12; // 화면당 출력수
		int paging = 10; // 페이지 분할수

		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		int listcount = GoodsService.goods_listcount();

		int start = (page - 1) * paging;

		goods_list = GoodsService.goods_list(start);

		int maxpage = listcount / limit + ((listcount % limit == 0) ? 0 : 1);
		int startpage = ((page - 1) / paging) * limit + 1;
		int endpage = startpage + paging - 1;

		if (endpage > maxpage)
			endpage = maxpage;

		model.addAttribute("page", page);
		model.addAttribute("startpage", startpage);
		model.addAttribute("endpage", endpage);
		model.addAttribute("maxpage", maxpage);
		model.addAttribute("listcount", listcount);
		model.addAttribute("goods_list", goods_list);

		// 정렬
		model.addAttribute("order", goods.getOrder());
		// 검색
		model.addAttribute("keyword", goods.getKeyword());

		return "board";
	}

	// 상품판매 글 등록 폼
	@RequestMapping("sell_form")
	public String sell_form(Model model) {

		// 카테고리 불러오기
		List<Category> Category = CategoryService.get_category();

		model.addAttribute("Category", Category);
		return "goods/sell_form";
	}

	// 상품 판매 글 등록
	@RequestMapping(value = "goods_reg", method = RequestMethod.POST)
	public String goods_reg(@RequestParam(name = "images") MultipartFile mf, Goods goods, HttpServletRequest request,
			HttpSession session, Model model) throws Exception {

		// 이미지 업로드
		String upload_result = GoodsService.image_upload(mf, request, model);

		// 첨부파일 사이즈가 클 때
		if (upload_result.equals("FileSizeOver")) {
			model.addAttribute("result", 1);
			return "goods/uploadResult";

			// 파일 확장자가 다를 때
		} else if (upload_result.equals("FileNotMatch")) {
			model.addAttribute("result", 2);
			return "goods/uploadResult";
		} else {
			goods.setGoods_image(upload_result);
		}

//		goods.setMember_no((int)session.getAttribute("no")); // 세션에 no저장되면 이걸로
		goods.setMember_no(7); // 임의로 넣기

		System.out.println(goods.toString());

		int result = GoodsService.goods_reg(goods);

		model.addAttribute("result", result);
		return "goods/reg_result";
	}
}