package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.model.Goods;
import com.example.demo.model.Member;

@Service
public class MemberService {
	@Autowired
	private MemberDao MemberDao;
	
	// 유저 확인
	public Member get_member(String member_id) {
		return MemberDao.get_member(member_id);
	}
	
	// 위치 인증
	public int update_member_add(Member member) {
		return MemberDao.update_member_add(member);
	}

//	상세페이지 회원명 가져오기
	public String detail_nick(Goods goods) {
		return MemberDao.detail_nick(goods);
	}
}
