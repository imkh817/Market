package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Member;

@Mapper
public interface MemberDao {
	
	// 아이디 중복 검사
	int id_valiable(String member_id);
	// 닉네임 중복 검사
	int nickname_valiable(String member_nickname);
	// 번호 중복 검사
	int phone_num_valiable(String number);
	// 회원 가입
	int join_member(Member member);



}
