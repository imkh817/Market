package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Job;

@Mapper
public interface JobDao {

	int getTotal();

	List<Job> get_job_list(Job job);

	int job_insert(Job job);

	List<Map<String, Object>> get_job(int job_no);

	Job get_all_job(int job_no);

	int add_readcount(int job_no);

	int job_update(Job job);

	int job_delete(int job_no);

	List<Job> get_job_place(String job_place);


}
