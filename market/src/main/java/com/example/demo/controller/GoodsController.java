package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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

	// 인기글 목록
	@RequestMapping("best")
	public String best(Model model) {
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

		// 이미지 다중 업로드 되었을때 첫 번째 이미지를 썸네일로 설정
		for (Goods gd : goods_list) {
			System.out.println("파싱전 이미지: " + gd.getGoods_image());

			String image = gd.getGoods_image();
			String[] goods_img = image.split(",");

			if (goods_img.length > 1) {
				String thum_img = goods_img[0];
				gd.setGoods_image(thum_img);
			}
		}

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
	public String goods_reg(@RequestParam(name = "images") MultipartFile[] mf, Goods goods, Member member,
			HttpServletRequest request, HttpSession session, Model model) throws Exception {

		for (MultipartFile MultipartFile : mf) {
			System.out.println("컨트롤러 받아온 이미지: " + MultipartFile);
		}

		// 첨부파일 갯수가 3개 넘어갈때
		if (mf.length > 3) {
			model.addAttribute("result", 1);
			return "goods/uploadResult";
		}

		// 이미지 업로드
		String upload_result = GoodsService.image_upload(mf, request);

		// 첨부파일 사이즈가 클 때
		if (upload_result.equals("FileSizeOver")) {
			model.addAttribute("result", 2);
			return "goods/uploadResult";

			// 파일 확장자가 다를 때
		} else if (upload_result.equals("FileNotMatch")) {
			model.addAttribute("result", 3);
			return "goods/uploadResult";
		} else {
			goods.setGoods_image(upload_result);
		}

		// 세션에 저장된 member_no를 goods객체 member_no에 저장
		goods.setMember_no((int) session.getAttribute("member_no"));

		// 세션에 저장된 member_id로 member 위치정보를 조회
		member.setMember_id((String) session.getAttribute("member_id"));

		// 사용자 위치 인증받은 주소를 goods_place에 저장
		goods.setGoods_place(MemberDao.user_check(member).getMember_auth_add());

		System.out.println(goods.toString());

		int result = GoodsService.goods_reg(goods);

		model.addAttribute("result", result);
		return "goods/reg_result";
	}
}