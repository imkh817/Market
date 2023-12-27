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
