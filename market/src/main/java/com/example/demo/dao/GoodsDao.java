package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Goods;

@Mapper
public interface GoodsDao {
	// 글 목록
	List<Goods> select_goods_list();
}