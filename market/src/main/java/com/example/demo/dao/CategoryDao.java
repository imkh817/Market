package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Category;
import com.example.demo.model.Goods;

@Mapper
public interface CategoryDao {

	// 카테고리 전체 목록
	List<Category> get_category();

//	상세페이지 카테고리 불러오기
	String detail_category(Goods goods);
	

}
