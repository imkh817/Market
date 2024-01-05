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

		goods.setGoods_no(goods.getGoods_no());
		System.out.println("세션으로 가져온 goods_no = " + goods.getGoods_no());

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

//	상품 삭제 - 비가시처리
	public int detail_delete(int goods_no) {
		return dao.detail_delete(goods_no);
	}


}
