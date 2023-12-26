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
	private String member_name;
	private String member_nickname;
	private String member_state; // -> n: y
	private Date member_regdate;
	private String member_image;
	private String member_jumin1;
	private String member_jumin2;
	private String member_phone_num;

	// auth
	private String member_auth_check;
	private String member_auth_add;
}
