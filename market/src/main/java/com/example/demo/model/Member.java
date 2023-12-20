package com.example.demo.model;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("member")
public class Member {
	
	private int member_no;
	private String member_id;
	private String member_pw;
	private String member_nickname;
	private String member_state; // -> n: y
	private Date member_reg_date;
	private String member_image;
}
