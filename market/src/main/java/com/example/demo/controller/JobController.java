package com.example.demo.controller;

import java.util.List;
import java.util.Map;

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
		// goods 불러오면 확장자 뒤에 ,가 붙기 때문에 substring 써서 잘라주기
		String tmp_upload = goodsService.image_upload(mf, request);
		String upload_result = tmp_upload.substring(0, tmp_upload.length()-1);
		
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
	
	// 수정 폼 이동
	@RequestMapping("job_update_form")
	public String job_update_form(int job_no, Model model) {
		System.out.println("job_no: " + job_no);
		Job job = jobService.get_all_job(job_no);
		model.addAttribute("job_no", job_no);
		model.addAttribute("job", job);
		return "job/job_update_form";
	}
	
	// 알바게시판 수정
	@RequestMapping(value = "job_update", method = RequestMethod.POST)
	public String job_update(@RequestParam(name = "images") MultipartFile[] mf, int job_no, Job job, Member member, HttpServletRequest request,
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
		// goods 불러오면 확장자 뒤에 ,가 붙기 때문에 substring 써서 잘라주기
		String tmp_upload = goodsService.image_upload(mf, request);
		String upload_result = tmp_upload.substring(0, tmp_upload.length()-1);
		
		// 첨부파일 사이즈가 클 때
		if(upload_result.equals("FileSizeOver")) {
			model.addAttribute("result", 2);
			return "goods/uploadResult";
			
			// 파일 확장자가 다를 때
		}else if(upload_result.equals("FileNotMatch")) {
			model.addAttribute("result", 3);
			return "goods/uploadResult";
		}
		
		// 세션에 저장된 member_no을 job 객체 member_no에 저장
		job.setMember_no((int)session.getAttribute("member_no"));
		System.out.println("session에 저장된 member_no :" + job.getMember_no());
		
		Job original_job = jobService.get_all_job(job_no);
		// 첨부파일 수정 시
		if(upload_result.length() > 0) {
			job.setJob_image(upload_result);
			System.out.println("첨부파일 수정시 이미지 값: " + upload_result);
		// 첨부파일 미수정 시
		}else {
			job.setJob_image(original_job.getJob_image());
			System.out.println("미수정시 db에서 가져온 이미지 값: " + job.getJob_image());
		}
		
		int result = jobService.job_update(job);
		System.out.println("result: " + result);
		model.addAttribute("result", result);
		return "job/job_update_result";
	}
	
	// 알바 상세페이지 이동
	@RequestMapping("job_detail")
	public String job_detail(int job_no, Model model, HttpSession session) {
		List<Map<String, Object>> list = jobService.get_job(job_no);
		Job job = jobService.get_all_job(job_no);
		jobService.add_readcount(job_no);
		
		// 주변 공고 추천하기
		List<Job> job_place = jobService.get_job_place(job.getJob_place());
		System.out.println("job_place : "+ job_place);
		
		model.addAttribute("job_place", job_place);
		model.addAttribute("list", list);
		model.addAttribute("member_no", session.getAttribute("member_no"));
		return "job/job_detail";
	}
	
	// 알바 글 삭제
	@RequestMapping("job_delete")
	public String job_delete(int job_no, Model model) {
		int result = jobService.job_delete(job_no);
		model.addAttribute("result", result);
		
		return "job/job_delete";
	}
}


















