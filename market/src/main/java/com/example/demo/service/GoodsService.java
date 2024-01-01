package com.example.demo.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.GoodsDao;
import com.example.demo.dao.MemberDao;
import com.example.demo.model.Goods;
import com.example.demo.model.Member;

@Service
public class GoodsService {
	
	@Autowired
	private GoodsDao GoodsDao;
	
	@Autowired
	private MemberDao memberdao;
	
	// 로그인 유저 확인
	public String user_check(Member member) {
		System.out.println("서비스 들어옴");
		Member auth_check = memberdao.user_check(member);
		String result = auth_check.getMember_auth_check();
		System.out.println("주소인증값 확인"+result);
		return result;
	}

	// 판매 글 등록
	public int goods_reg(Goods goods) {
		return GoodsDao.goods_reg(goods);
	}
	
	// 이미지 등록 전처리
	public String image_upload(MultipartFile[] mf, HttpServletRequest request)throws Exception{
		
		String newfilename = "";
		String images = "";
		
		// 이미지 배열 mf 만큼 반복문 
		for (MultipartFile MultipartFile : mf) {
			String filename = MultipartFile.getOriginalFilename(); // 첨부파일명
			int size = (int) MultipartFile.getSize(); // 첨부파일의 크기 (단위:Byte)

			String path = request.getRealPath("upload");
			
			System.out.println("filename=" + filename);
			System.out.println("size=" + size);
			System.out.println("Path=" + path);

			String file[] = new String[2];


			if (size > 0) { // 첨부파일이 전송된 경우

				// 파일 중복문제 해결
				String extension = filename.substring(filename.lastIndexOf("."), filename.length());
				System.out.println("extension:" + extension);

				UUID uuid = UUID.randomUUID();

				newfilename = uuid.toString() + extension;
				System.out.println("newfilename:" + newfilename);

				StringTokenizer st = new StringTokenizer(filename, ".");
				file[0] = st.nextToken(); // 파일명
				file[1] = st.nextToken(); // 확장자

				// 첨부파일 크기가 클 경우
				if (size > 10000000) { // 약 9.5 MB
					return "FileSizeOver";

					// 확장자가 다를 경우
				} else if (!file[1].equals("jpg") && !file[1].equals("jpeg") && !file[1].equals("gif")
						&& !file[1].equals("png")) {
					return "FileNotMatch";
				}
			}

			if (size > 0) { // 첨부파일이 전송된 경우
				MultipartFile.transferTo(new File(path + "/" + newfilename));
			}
			
			images += newfilename+",";
		} // end for문
		
		return images;
	}
	
	// 글 목록
	public List<Goods> select_goods_list() {
		/*
		 * // 페이징 처리 final int list_per_page = 15; // 화면당 출력수
		 * 
		 * if(page_no == null || page_no.equals("")) { page_no = "1"; }
		 * 
		 * int page_current = Integer.parseInt(page_no); // 현재 페이지 int total =
		 * goodsDao.select_goods_list().size(); // 리스트 총 갯수 int start_list =
		 * (page_current - 1) * list_per_page + 1; // 현재 페이지에서 출력될 첫번째 리스트 int end_list
		 * = start_list + list_per_page - 1; // 현재 페이지에서 출력될 마지막 리스트
		 * 
		 * Paging pg = new Paging(total, list_per_page, page_current);
		 * 
		 * goods.setStart_list(start_list); goods.setEnd_list(end_list);
		 * 
		 * List<Goods> goods_list = goodsDao.select_goods_list(goods);
		 * 
		 * model.addAttribute("gd_list", goods_list); model.addAttribute("pg", pg);
		 * 
		 * // 정렬 model.addAttribute("sort_order", goods.getSort_order());
		 * 
		 * // 검색 model.addAttribute("search", goods.getKeyword());
		 */
		return GoodsDao.select_goods_list();
	}


}
