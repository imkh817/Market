package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.LikedDao;
import com.example.demo.model.Liked;

@Service
public class LikedService {

	@Autowired
	public LikedDao dao;

//	상세페이지 하트 확인 
	public Liked liked_heart(Liked liked) {
		return dao.liked_heart(liked);
	}
	
//	상세페이지 하트 클릭
	public int insert_heart(Liked liked) {
		return dao.insert_heart(liked);
	}

//	상세페이지 하트 취소
	public int delete_heart(Liked liked) {
		return dao.delete_heart(liked);
	}

//	상세페이지 하트 개수
	public int heart_count(int goods_no) {
		return dao.heart_count(goods_no);
	}
}
