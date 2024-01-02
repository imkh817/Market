package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Liked;

@Mapper
public interface LikedDao {

//	상세페이지 하트 확인
	Liked liked_heart(Liked liked);
	
//	상세페이지 하트 클릭
	int insert_heart(Liked liked);

//	상세페이지 하트 취소
	int delete_heart(Liked liked);

//	상세페이지 하트 개수
	int heart_count(int goods_no);


}
