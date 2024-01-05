package com.example.demo.service.login;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.model.Member;
import com.example.demo.service.join.JoinService;

@Service
public class LoginService {

	@Autowired
	MemberDao memberDao;
	
	@Autowired
	JoinService joinService;
	
	// 유저 체크
	public Member user_check(Member member) {
		Member user = memberDao.user_check(member);
		return user;
	}
	
	// 로그인 체크
	public int login_check(Member member,HttpSession session) {
		
		Member user = user_check(member);
		
		if(user == null) { // DB에 회원 아이디 없는 경우
			return -1;
		}else {
			if(joinService.match_password(member.getMember_pw(), user.getMember_pw())) { // 로그인 성공!
				session.setAttribute("member_id", user.getMember_id());
				session.setAttribute("member_nickname", user.getMember_nickname());
				session.setAttribute("member_no", user.getMember_no());
				return 1;
			}
		}
		// DB에는 아이디가 있지만 비번 불일치 한 경우
		return 0;
	}
}
