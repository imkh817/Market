package com.example.demo.service;

import java.util.List;

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

}
