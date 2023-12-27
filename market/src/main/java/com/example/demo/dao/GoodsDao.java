package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Goods;

@Mapper
public interface GoodsDao {

	// 판매 글 등록
	int goods_reg(Goods goods);

	// 글 목록
	List<Goods> select_goods_list();

	// 글 갯수
	int goods_listcount();
	
	// 글 목록
	List<Goods> goods_list(int start);
	
	// 인기글 목록
	List<Goods> best_list();
}
