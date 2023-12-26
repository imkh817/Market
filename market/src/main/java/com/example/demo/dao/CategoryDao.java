package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Category;

@Mapper
public interface CategoryDao {

	// 카테고리 전체 목록
	List<Category> get_category();
	

}
