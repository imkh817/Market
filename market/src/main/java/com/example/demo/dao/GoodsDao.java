package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Goods;

@Mapper
public interface GoodsDao {

	// 판매 글 등록
	int goods_reg(Goods goods);

	// 최저가 비교 -> 검색한 매물 판매 완료된 갯수 가지고 오기 조건: 날짜 
	int compare_list_count(String compare_prodcut);

	// 양배추 마켓 최저가 비교 리스트
	List<Goods> get_compare_list(Goods tmp);
	
	// 글 갯수
	int goods_listcount(Map<String, Object> find_map);
	
	// 글 목록
	List<Goods> goods_list(Map<String, Object> map);
	
	// 인기글 목록
	List<Goods> best_list();

	// 특정게시글 정보 불러오기
	Goods get_goods(Goods goods);
	
	// 판매 글 수정
	int goods_update(Goods goods);
}
