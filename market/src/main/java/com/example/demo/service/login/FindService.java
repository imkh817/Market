package com.example.demo.service.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.model.Member;

@Service
public class FindService {

	@Autowired
	MemberDao memberDao;
	
	public Member find_id(Member member) {
		return memberDao.find_id(member);
	}
	
	// 아이디 찾기 시 앞 3글자 제외 *처리
	public String replace_id(String id) {
		StringBuilder resultBuilder = new StringBuilder(id);
		for (int i = 3; i < id.length(); i++) {
		    resultBuilder.replace(i, id.length(), "*");
		}
		return resultBuilder.toString();
	}

	public int update_pw(Member member) {
		return memberDao.update_pw(member); 
	}


}
