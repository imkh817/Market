package com.example.demo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.Job;
import com.example.demo.model.PagingPgm;
import com.example.demo.service.JobService;

@Controller
public class JobController {

	@Autowired
	JobService jobService;
	
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
}