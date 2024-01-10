package com.example.demo.controller.compare;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.ComparePrice;
import com.example.demo.model.Goods;
import com.example.demo.model.Item;
import com.example.demo.model.PagingPgm;
import com.example.demo.service.compare.ComparePaging;
import com.example.demo.service.compare.CompareService;

@Controller
public class CompareController {
	
	@Autowired
	CompareService compareService;
	
	@RequestMapping("lowest_naver_form")
	public String compare_form(String page) {
		return "compare/compare_form";
	}
	@RequestMapping("lowest_baechu_form")
	public String lowest_price_form(String page) {
		return "compare/lowest_price_form";
	}
	
	@RequestMapping("lowest_baechu")
	public String lowest_baechu(String page,String compare_product,Model model) {
		PagingPgm paging = compareService.paing(page, compare_product);
		List<Goods> list = compareService.getList(paging, compare_product);
		for(int i=0; i<list.size(); i++) {
			String tmp[] = list.get(i).getGoods_image().split(",");
			list.get(i).setGoods_image(tmp[0]);
			System.out.println(list.get(i).getGoods_image());
		}
		ComparePrice compare_price = compareService.get_Compare_price(list);
		System.out.println("list의 사이즈 : " + list.size());
		model.addAttribute("list",list);
		model.addAttribute("page",paging);
		model.addAttribute("compare_product",compare_product);
		model.addAttribute("compare_price",compare_price);
		return"compare/lowest_price_form";
	}
	
	
	@RequestMapping("lowest_naver")
	public String compare(String compare_product,String page,Model model) {
		ComparePaging paging = compareService.paging(page); // 페이징 객체 생성
		String response = compareService.search(compare_product,paging); // 검색API 사용
		List<Item> list = compareService.getList(response); // 검색 결과 파싱 후 리스트로 담기
		int total = compareService.getTotal(response); // 검색한 결과 total 데이터 갯수
		paging.setTotal(total); // ComparePaging 객체에 total 담아줌 
		// -> 이유? API로 불러오기 때문에 애초에 값을 불러와야 그때 total값을 알 수 있다..total 값이 필요한 이유는 페이징 표시 때문에!
		
		model.addAttribute("list",list);
		model.addAttribute("page",paging);
		model.addAttribute("compare_product",compare_product);
		return "compare/compare_form";
	}
}
