package com.example.demo.service.join;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.model.Member;

@Service
public class JoinService {
	
	@Autowired
	MemberDao dao;
	
	// 아이디 체크
	public int id_valiable(String member_id) {
		int result = dao.id_valiable(member_id);
		return result;
	}
	
	// 닉네임 체크
	public int nickname_valiable(String member_nickname) {
		int result = dao.nickname_valiable(member_nickname);
		return result;
	}
	// 번호 체크
	public int phone_num_valiable(String number) {
		int result = dao.phone_num_valiable(number);
		return result;
		
	}
	
	// 가입
	public int join_member(Member member) {
		int result = dao.join_member(member);
		return result;
	}

	
}
