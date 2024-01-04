package com.example.demo.model;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("job")
public class Job {
	private int job_no;
	private int member_no;
	private String job_title;
	private String job_content;
	private String job_price;
	private String job_place;
	private String job_time1;
	private String job_time2;
	private String job_day;
	private Date job_reg_date;
	private String job_image;
	private int job_readcount;
	
	private int startRow;
	private int endRow;
}
