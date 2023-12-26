package com.example.demo.controller.compare;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.Item;
import com.example.demo.service.compare.ComparePaging;
import com.example.demo.service.compare.CompareService;

import lombok.Value;

@Controller
public class CompareController {
	
	@Autowired
	CompareService compareService;
	
	@RequestMapping("compare_form")
	public String compare_form(String page) {
		return "compare/compare_form";
	}
	
	@RequestMapping("compare")
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