package com.example.demo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.JobDao;
import com.example.demo.model.Job;
import com.example.demo.model.PagingPgm;

@Service
public class JobService {

	@Autowired
	JobDao jobDao;
	
	public PagingPgm paging(String page) {
		if(page == null || page.equals("")) {
			page = "1";
		}
		int currentPage = Integer.parseInt(page);
		int rowPerPage = 6;
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = (startRow + rowPerPage) - 1;	
		int total = jobDao.getTotal();
		
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage, startRow, endRow);
		
		return pp;
	}

	public List<Job> get_job_list(PagingPgm pp) {
		Job job = new Job();
		job.setStartRow(pp.getStartRow() - 1);
		job.setEndRow(pp.getEndRow());
		
		return jobDao.get_job_list(job);
	}

	public int job_insert(Job job) {
		return jobDao.job_insert(job);
	}

	public List<Map<String, Object>> get_job(int job_no) {
		return jobDao.get_job(job_no);
	}

	public Job get_all_job(int job_no) {
		return jobDao.get_all_job(job_no);
	}

	public int add_readcount(int job_no) {
		return jobDao.add_readcount(job_no);
	}

	public int job_update(Job job) {
		return jobDao.job_update(job);
	}

	public int job_delete(int job_no) {
		return jobDao.job_delete(job_no);
	}

	public List<Job> get_job_place(String job_place) {
		String[] array_place = job_place.split(" ");
		System.out.println("주소 자른 거 : " + array_place[1]);
		return jobDao.get_job_place(array_place[1]);
	}

}
