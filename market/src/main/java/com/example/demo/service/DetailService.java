package com.example.demo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.DetailDao;
import com.example.demo.model.Goods;

@Service
public class DetailService {

	@Autowired
	private DetailDao dao;

//	상세페이지 이동 및 데이터 불러오기
	public List<Map<String, Object>> detail_goods(Goods goods) {

		List<Map<String, Object>> detail_result = dao.detail_goods(goods);
		System.out.println("상세 goods_no 기반 데이터 = " + detail_result);

		return dao.detail_goods(goods);
	}
	
//	인기상품 5개
	public List<Map<String, Object>> best_detail(int goods_no) {
		
		return dao.best_detail(goods_no);
	}

//	시간 분단위 출력
	public int goods_reg_minute(int goods_no) {
		return dao.goods_reg_minute(goods_no);
	}

//	조회수 증가
	public int read_count_up(Goods goods) {
		return dao.read_count_up(goods);
	}



}
