package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Job;

@Mapper
public interface JobDao {

	int getTotal();

	List<Job> get_job_list(Job job);

	int job_insert(Job job);

}
