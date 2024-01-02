package com.example.demo.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
		
		// Goods 객체에 없는 컬럼값 넘기기 위해 Map 사용
		Map<String, Object> map = new HashMap<String, Object>();
		
		int page;
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}else {
			page = 1;
		}
		
		String order = request.getParameter("order");
		if(order == null)
			order = "regdate";
		
		String keyword = request.getParameter("keyword");
		
		// 페이징 처리
		int listcount = GoodsService.goods_listcount(keyword);
		int limit = 12; // 화면당 출력수
		int paging = 10; // 페이지 분할수
		int start = (page - 1) * paging;
		
		int maxpage = listcount / limit + ((listcount % limit == 0) ? 0 : 1);
		int startpage = ((page - 1) / paging) * limit + 1;
		int endpage = startpage + paging - 1;
		if (endpage > maxpage)
			endpage = maxpage;

		// Goods 객체에 없는 컬럼 입력
		map.put("order", order);
		map.put("keyword", keyword);
		map.put("start", start);
		
		// Goods 객체 컬럼 입력
		map.put("goods_no", goods.getGoods_no());
		map.put("member_no", goods.getMember_no());
		map.put("category_no", goods.getCategory_no());
		map.put("goods_name", goods.getGoods_name());
		map.put("goods_content", goods.getGoods_content());
		map.put("goods_price", goods.getGoods_price());
		map.put("goods_place", goods.getGoods_place());
		map.put("goods_readcount", goods.getGoods_readcount());
		map.put("goods_regdate", goods.getGoods_regdate());
		map.put("goods_state", goods.getGoods_state());
		map.put("goods_image", goods.getGoods_image());
		
		// 글 목록 select 실행
		goods_list = GoodsService.goods_list(map);
		
		// 이미지 다중 업로드 되었을때 첫번째 이미지를 썸네일로 설정
		for (Goods gd : goods_list) {
		
			String image = gd.getGoods_image();
			String[] goods_img = image.split(",");

			if (goods_img.length > 0) {
				String thum_img = goods_img[0];
				gd.setGoods_image(thum_img);
			}
		map.put("goods_image", gd.getGoods_image());
		}
		
		// 페이지에 값 전달
		model.addAttribute("page", page);
		model.addAttribute("order", order);
		model.addAttribute("keyword", keyword);
		model.addAttribute("startpage", startpage);
		model.addAttribute("endpage", endpage);
		model.addAttribute("maxpage", maxpage);
		model.addAttribute("listcount", listcount);
		model.addAttribute("goods_list", goods_list);

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
		
		String place = MemberDao.user_check(member).getMember_auth_add();
		goods.setGoods_place(place);
		
		System.out.println(goods.toString());

		int result = GoodsService.goods_reg(goods);

		model.addAttribute("result", result);
		return "goods/reg_result";
	}
	
	// 상품판매 글 수정 폼
		@RequestMapping("update_sell_form")
		public String update_sell_form(Goods goods, Model model) {

			// 카테고리 불러오기
			List<Category> Category = CategoryService.get_category();
			
			goods.setGoods_no(130); // board_no를 130이라 가정
			System.out.println("글 수정 굿즈 no: " + goods.getGoods_no() );
			
			// 게시글 정보 불러오기
//			List<Goods> get_goods = GoodsService.get_goods(goods);

			model.addAttribute("Category", Category);
			return "goods/update_sell_form";
		}
}