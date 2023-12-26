package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.GoodsDao;
import com.example.demo.model.Goods;

@Service
public class GoodsService {
	
	@Autowired
	private GoodsDao GoodsDao;

	public int goods_reg(Goods goods) {
		return GoodsDao.goods_reg(goods);
	}
	
	

	
	// 글 목록
	public List<Goods> select_goods_list() {
		/*
		 * // 페이징 처리 final int list_per_page = 15; // 화면당 출력수
		 * 
		 * if(page_no == null || page_no.equals("")) { page_no = "1"; }
		 * 
		 * int page_current = Integer.parseInt(page_no); // 현재 페이지 int total =
		 * goodsDao.select_goods_list().size(); // 리스트 총 갯수 int start_list =
		 * (page_current - 1) * list_per_page + 1; // 현재 페이지에서 출력될 첫번째 리스트 int end_list
		 * = start_list + list_per_page - 1; // 현재 페이지에서 출력될 마지막 리스트
		 * 
		 * Paging pg = new Paging(total, list_per_page, page_current);
		 * 
		 * goods.setStart_list(start_list); goods.setEnd_list(end_list);
		 * 
		 * List<Goods> goods_list = goodsDao.select_goods_list(goods);
		 * 
		 * model.addAttribute("gd_list", goods_list); model.addAttribute("pg", pg);
		 * 
		 * // 정렬 model.addAttribute("sort_order", goods.getSort_order());
		 * 
		 * // 검색 model.addAttribute("search", goods.getKeyword());
		 */
		return GoodsDao.select_goods_list();
	}

}
