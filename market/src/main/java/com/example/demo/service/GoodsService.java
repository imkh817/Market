package com.example.demo.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
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
	public String user_check(String member_id) {
		System.out.println("goods서비스 user_check메서드");
		System.out.println("굿즈 서비스 member_id"+member_id);
		Member auth_check = memberdao.get_member(member_id);
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
		System.out.println("images : " + images);
		return images;
	}

	// 글 갯수
	public int goods_listcount(Map<String, Object> find_map) {
		return GoodsDao.goods_listcount(find_map);
	}

	// 글 목록
	public List<Goods> goods_list(Map<String, Object> map) {
		return GoodsDao.goods_list(map);
	}

	// 인기글 목록
	public List<Goods> best_list(){
		return GoodsDao.best_list();
	}

	// 특정게시글 정보 불러오기
	public Goods get_goods(Goods goods) {
		return GoodsDao.get_goods(goods);
	}
	
	// 다중 이미지 파싱해서 list
	public String[] iamge_parsing(Goods goods){
		
		Goods get_goods = GoodsDao.get_goods(goods);
		String images = get_goods.getGoods_image();
		System.out.println("이미지 파싱을 위해 이미지 불어오기: "+images);
		
		String[] image_list = images.split(",");
		
		return image_list;
	}
	
	// 게시글 수정시 upload폴더 기존 사진 삭제


	// 판매 글 수정
	public int goods_update(Goods goods) {
		System.out.println("수정 할 goods: "+goods.toString());
		return GoodsDao.goods_update(goods);
	}
}
