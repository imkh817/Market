package com.example.demo.service.mypage;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.MemberDao;
import com.example.demo.dao.MypageDao;
import com.example.demo.model.Goods;
import com.example.demo.model.Job;
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
	
	@Autowired
	MemberDao memberDao;
	

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
		
		List<Goods> list = mypageDao.getList(goods);
		for(int i = 0; i<list.size(); i++) {
			list.get(i).setGoods_image(list.get(i).getGoods_image().substring(0,list.get(i).getGoods_image().length()-1));
			// 이미지 다중 업로드 되었을때 첫번째 이미지를 썸네일로 설정
			String image = list.get(i).getGoods_image();
			String[] goods_img = image.split(",");
			if (goods_img.length > 1) {
				String thum_img = goods_img[0];
				list.get(i).setGoods_image(thum_img);
			}
		}
		
		return list;
	}

	// 회원 탈퇴
	public int member_delete(Member member, HttpSession session) {
		Member user = new Member();
		user.setMember_id((String) session.getAttribute("member_id"));
		Member db = loginService.user_check(user);
		
		// 이미 여기서 비번확인을 했으니 xml파일에서는 그냥 절차만 밟아도 됨
		if (joinService.match_password(member.getMember_pw(), db.getMember_pw())) {
			mypageDao.goods_state_update_two((int)session.getAttribute("member_no"));

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
		
		List<Map<String, Object>> list = mypageDao.liked_list(goods);;
		for(int i=0; i<list.size(); i++) {
			String image = (String)list.get(i).get("goods_image");
			list.get(i).put("goods_image", image.substring(0,image.length()-1));
			// 이미지 다중 업로드 되었을때 첫번째 이미지를 썸네일로 설정
			String tmp = (String)list.get(i).get("goods_image");
			String[] goods_img = tmp.split(",");
			
			if (goods_img.length > 1) {
				String thum_img = goods_img[0];
				list.get(i).put("goods_image", thum_img);
			}
		}
		
		return list;
	}
	

	// 상품 상태 업데이트
	public int goods_state_update(Goods goods) {
		return mypageDao.goods_state_update(goods);
	}

	// 회원 정보 수정 폼으로 넘어갈때 회원의 정보 가지고 가기
	public Member getMember(HttpSession session) {
		Member member = memberDao.get_member((String)session.getAttribute("member_id"));
		return member;
	}
	
	// 회원  업데이트
	public int update_member(@RequestParam("image") MultipartFile mf,HttpServletRequest request,HttpSession session,Member member) {
		String path = request.getRealPath("upload");
		System.out.println("path :" +path);
		String extension ="";
		if(mf.getSize()>0) {
			System.out.println("mf.name : " + mf.getOriginalFilename());
			extension = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."),mf.getOriginalFilename().length()); // 파일을 .을 기준으로 자르고 배열의 1번가지고 오기!
			
			if(extension.equals(".jpeg") || extension.equals(".png") || extension.equals(".gif")) {
				try {
					System.out.println("파일 전송!");
					mf.transferTo(new File(path+"/"+ session.getAttribute("member_id")+extension));
					member.setMember_image(session.getAttribute("member_id")+extension);
					 // 회원 이미지는 어차피 1개이므로 중복 신경X, 파일 명은 회원아이디로 한다.
					int result = memberDao.update_member(member);
					return result;
				} catch (Exception e) {
					return -1; // 파일 저장 실패
				} 
			}else {
				return -2; // 형식 안맞아서 실패
			}
		}else {
			System.out.println("사진 이미지 설정을 안했습니다!");
			int result = memberDao.no_image_update_member(member);
			return result;
		}
	}
	
	// 회원 정보 가져오기
	public Member get_member(int member_no) {
		return mypageDao.get_member(member_no);
	}

	// 마이페이지 내에서 구인공고 목록 페이징
	public PagingPgm job_paging(String page, int member_no) {
		if(page == null || page.equals("")) {
			page = "1";
		}
		int currentPage = Integer.parseInt(page);
		int rowPerPage = 6;
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = (startRow + rowPerPage) - 1;
		int total = mypageDao.get_total(member_no);
		
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage, startRow, endRow);
		
		return pp;
	}

	public List<Job> get_job(PagingPgm pp, int member_no) {
		Job job = new Job();
		job.setStartRow(pp.getStartRow() - 1);
		job.setEndRow(pp.getEndPage());
		job.setMember_no(member_no);
		
		return mypageDao.get_job_list(job);
	}

}
