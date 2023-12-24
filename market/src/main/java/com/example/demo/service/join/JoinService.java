package com.example.demo.service.join;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.model.Member;

@Service
public class JoinService {
	
	@Autowired
	private MemberDao dao;
	
	@Autowired
	public PasswordEncoder passwordEncoder;
	
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
	
	// 비번 암호화
	public String encode_password(String pw) {
		String encode_pw = passwordEncoder.encode(pw);
		return encode_pw;
	}
	
	// 비번 암호화 된거랑 사용자가 입력한 비밀번호 일치하는지 확인
	public boolean match_password(String pw, String encode_pw) {
		boolean result = passwordEncoder.matches(pw, encode_pw);
		return result;
	}
	
	// 가입
	public int join_member(Member member) {
		
		// 암호화 된 비번 member에 세팅
		member.setMember_pw(encode_password(member.getMember_pw()));
		int result = dao.join_member(member);
		return result;
	}
	

	
}
