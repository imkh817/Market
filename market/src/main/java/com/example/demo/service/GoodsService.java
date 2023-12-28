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
import com.example.demo.model.Goods;

@Service
public class GoodsService {

	@Autowired
	private GoodsDao GoodsDao;

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

	// 글 갯수
	public int goods_listcount() {
		return GoodsDao.goods_listcount();
	}

	// 글 목록
	public List<Goods> goods_list(int start) {
		return GoodsDao.goods_list(start);
	}

	// 인기글 목록
	public List<Goods> best_list(){
		return GoodsDao.best_list();
	}

}
