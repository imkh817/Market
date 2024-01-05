package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Goods;
import com.example.demo.model.Member;

@Mapper
public interface MemberDao {
	
	// 유저 확인
	Member get_member(String member_id);
	
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
	
	// 아이디 찾기 - 유저 확인
	Member find_id(Member member);
	
	// 비밀번호 찾기 - 임시 비밀번호 발송 후 임시 비밀번호 디비 저장
	int update_pw(Member member);


//	상세페이지 회원명 가져오기
	String detail_nick(Goods goods);

	int setImage(Member member);

	int update_member(Member member);

	int no_image_update_member(Member member);

	



}
