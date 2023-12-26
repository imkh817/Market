package com.example.demo.controller;

import java.io.File;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.Category;
import com.example.demo.model.Goods;
import com.example.demo.service.CategoryService;
import com.example.demo.service.GoodsService;

@Controller
public class GoodsController {
	
	@Autowired 
	private CategoryService CategoryService; 
	
	@Autowired
	private GoodsService GoodsService;

	// 글 목록
	@RequestMapping("list")
	public String list(Model model) {
		List<Goods> goods_list = GoodsService.select_goods_list();
		model.addAttribute("goods_list", goods_list);
		return "goods/goods_list";
	}
	
	// 상품판매 글 등록 폼
	@RequestMapping("sell")
	public String sell(Model model) {
		
		// 카테고리 불러오기
		List<Category> Category = CategoryService.get_category();
		
		
		model.addAttribute("Category",Category);
		return "goods/sell_form";
	}
	
	// 상품 판매 글 등록
	@RequestMapping(value="goods_reg", method = RequestMethod.POST)
	public String goods_reg(@RequestParam(name="images") MultipartFile mf, Goods goods, 
						HttpServletRequest request, HttpSession session, Model model) throws Exception {
		
		String filename = mf.getOriginalFilename(); // 첨부파일명
		int size = (int)mf.getSize(); // 첨부파일의 크기 (단위:Byte)
		
		String path = request.getRealPath("upload");
		System.out.println("mf=" + mf);
		System.out.println("filename=" + filename);
		System.out.println("size=" + size);
		System.out.println("Path=" + path);
		int result=0;
		
		String file[] = new String[2];
		
		String newfilename = "";
		
		if(size > 0){	 	// 첨부파일이 전송된 경우	
			
			// 파일 중복문제 해결
			String extension = filename.substring(filename.lastIndexOf("."), filename.length());
			System.out.println("extension:"+extension);
			
			UUID uuid = UUID.randomUUID();
			
			newfilename = uuid.toString() + extension;
			System.out.println("newfilename:"+newfilename);		
			
			StringTokenizer st = new StringTokenizer(filename, ".");
			file[0] = st.nextToken();		// 파일명
			file[1] = st.nextToken();		// 확장자			
			
			// 첨부파일 크기가 클 경우
			if(size > 1000000){				// 976KB
				result=1;
				model.addAttribute("result", result);
				
				return "goods/uploadResult";
			
			// 확장자가 다를 경우
			}else if(!file[1].equals("jpg")  &&
					 !file[1].equals("jpeg") &&
					 !file[1].equals("gif")  &&
					 !file[1].equals("png") ){
				
				result=2;
				model.addAttribute("result", result);
				
				return "goods/uploadResult";
			}
		}	

			if (size > 0) { 	// 첨부파일이 전송된 경우

				mf.transferTo(new File(path + "/" + newfilename));

			}
		
		goods.setGoods_image(newfilename);
//		goods.setMember_no((int)session.getAttribute("no")); // 세션에 no저장되면 이걸로
		goods.setMember_no(7); // 임의로 넣기
		
		System.out.println(goods.toString());
		
		result = GoodsService.goods_reg(goods);
		
		model.addAttribute("result",result);
		return "goods/reg_result";
	}
}