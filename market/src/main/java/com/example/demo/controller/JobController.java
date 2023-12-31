package com.example.demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.Job;
import com.example.demo.model.Member;
import com.example.demo.model.PagingPgm;
import com.example.demo.service.GoodsService;
import com.example.demo.service.JobService;

@Controller
public class JobController {

	@Autowired
	JobService jobService;
	@Autowired
	GoodsService goodsService;
	
	// 알바 메인 페이지 이동
	@RequestMapping("job_main")
	public String job_main(String page, Model model, HttpSession session) {
		PagingPgm pp = jobService.paging(page);
		List<Job> job_list = jobService.get_job_list(pp);
		System.out.println("list : " + job_list);
		
		model.addAttribute("page", pp);
		model.addAttribute("list", job_list);
		
		return "job/job_main";
	}
	
	// 글 작성 페이지 이동
	@RequestMapping("job_insert_form")
	public String job_insert_form() {
		
		return "job/job_insert";
	}
	
	// 알바게시판 글 등록
	@RequestMapping(value = "job_insert", method = RequestMethod.POST)
	public String job_insert(@RequestParam(name = "images") MultipartFile[] mf, Job job, Member member, HttpServletRequest request,
			HttpSession session, Model model) throws Exception {
		
		for(MultipartFile MultipartFile : mf) {
			System.out.println("컨트롤러 받은 이미지: " + MultipartFile);
		}

		// 첨부파일 갯수가 3개 넘어갈 때
		if(mf.length > 3) {
			model.addAttribute("result", 1);
			return "goods/uploadResult";
		}
		
		// 이미지 업로드
		String upload_result = goodsService.image_upload(mf, request);
		
		// 첨부파일 사이즈가 클 때
		if(upload_result.equals("FileSizeOver")) {
			model.addAttribute("result", 2);
			return "goods/uploadResult";
			
			// 파일 확장자가 다를 때
		}else if(upload_result.equals("FileNotMatch")) {
			model.addAttribute("result", 3);
			return "goods/uploadResult";
		}else {
			job.setJob_image(upload_result);
		}
		
		// 세션에 저장된 member_no을 job 객체 member_no에 저장
		job.setMember_no((int)session.getAttribute("member_no"));
		System.out.println("session에 저장된 member_no :" + job.getMember_no());
		int result = jobService.job_insert(job);
		model.addAttribute("result", result);
		return "job/job_insert_result";
	}
}


















