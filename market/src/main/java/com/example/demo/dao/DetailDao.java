package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Goods;
import com.example.demo.model.Member;

@Mapper
public interface DetailDao {

//	상세페이지 이동 및 데이터 불러오기
	List<Map<String, Object>> detail_goods(Goods goods);

//	인기상품 이동
	List<Map<String, Object>> best_detail(int goods_no);
	
//	member 데이터 불러오기
	List<Member> detail_member(Member member);
	
//	시간 분단위 출력
	int goods_reg_minute(int goods_no);

//	조회수 증가
	int read_count_up(Goods goods);

	
//	상품 삭제 - 비가시처리
	int detail_delete(int goods_no);













}
