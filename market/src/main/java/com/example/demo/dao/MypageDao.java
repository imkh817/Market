package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Goods;
import com.example.demo.model.Liked;
import com.example.demo.model.Member;
import com.example.demo.model.PagingPgm;

@Mapper
public interface MypageDao {

	int getTotal(int member_no);

	List<Goods> getList(Goods goods);

	int member_delete(String member_pw);

	List<Map<String, Object>> liked_list(Goods goods);

	int get_liked_total(int member_no);

	int goods_state_update(Goods goods);

}
