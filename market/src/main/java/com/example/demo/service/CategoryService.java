package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.CategoryDao;
import com.example.demo.model.Category;

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

}