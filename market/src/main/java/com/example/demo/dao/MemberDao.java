package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Member;

@Mapper
public interface MemberDao {
	
	// 위치 인증
	int update_member_add(Member member);

	// 회원가입 - 아이디 중복 검사
	int id_valiable(String member_id);
	// 회원가입 - 닉네임 중복 검사
	int nickname_valiable(String member_nickname);
	// 회원가입 - 번호 중복 검사
	int phone_num_valiable(String number);
	// 회원가입
	int join_member(Member member);
	
	// 로그인 - 유저 확인
	Member user_check(Member member);



}
