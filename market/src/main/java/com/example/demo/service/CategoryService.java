package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.CategoryDao;
import com.example.demo.model.Category;
import com.example.demo.model.Goods;

@Service
public class CategoryService {

	@Autowired
	CategoryDao CategoryDao;

	// 카테고리 전체목록 불러오기
	public List<Category> get_category() {
		List<Category> Category = new ArrayList<Category>();
		Category = CategoryDao.get_category();
		return Category;
	}

//	상세페이지 카테고리 불러오기
	public String detail_category(Goods goods) {
		return CategoryDao.detail_category(goods);
	}

}
