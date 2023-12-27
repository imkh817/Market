package com.example.demo.service.mypage;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.dao.MypageDao;
import com.example.demo.model.Goods;
import com.example.demo.model.Liked;
import com.example.demo.model.Member;
import com.example.demo.model.PagingPgm;
import com.example.demo.service.join.JoinService;
import com.example.demo.service.login.LoginService;

@Service
public class MypageService {

	@Autowired
	MypageDao mypageDao;

	@Autowired
	JoinService joinService;

	@Autowired
	LoginService loginService;

	// 페이징
	public PagingPgm paging(String page, int member_no) {

		if (page == null || page.equals("")) {
			page = "1";
		}
		int currentPage = Integer.parseInt(page);
		int rowPerPage = 6;
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = (startRow + rowPerPage) - 1;
		int total = mypageDao.getTotal(member_no);

		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage, startRow, endRow);

		return pp;
	}

	// 회원이 등록한 구매글 리스트 가지고 오기
	public List<Goods> getList(PagingPgm pp, int member_no) {

		System.out.println("getList - startRow" + pp.getStartRow());
		Goods goods = new Goods();
		goods.setStart_list(pp.getStartRow() - 1);
		goods.setEnd_list(pp.getEndRow());
		goods.setMember_no(member_no);

		return mypageDao.getList(goods);
	}

	// 회원 탈퇴
	public int member_delete(Member member, HttpSession session) {
		Member user = new Member();
		user.setMember_id((String) session.getAttribute("member_id"));
		Member db = loginService.user_check(user);

		// 이미 여기서 비번확인을 했으니 xml파일에서는 그냥 절차만 밟아도 됨
		if (joinService.match_password(member.getMember_pw(), db.getMember_pw())) {

			return mypageDao.member_delete(db.getMember_pw());
		}
		return -1;
	}

	// 페이징
	public PagingPgm paging_liked(String page, int member_no) {

		if (page == null || page.equals("")) {
			page = "1";
		}
		int currentPage = Integer.parseInt(page);
		int rowPerPage = 6;
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = (startRow + rowPerPage) - 1;
		int total = mypageDao.get_liked_total(member_no);

		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage, startRow, endRow);

		return pp;
	}

	// 찜한 상품 리스트
	public List<Map<String, Object>> liked_list(PagingPgm pp, int member_no) {
		System.out.println("liked_list - startRow" + pp.getStartRow());
		Goods goods = new Goods();
		goods.setStart_list(pp.getStartRow() - 1);
		goods.setMember_no(member_no);

		return mypageDao.liked_list(goods);
	}

}
