package com.example.demo.model;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("liked")
public class Liked {
	private int liked_no;
	private int member_no;
	private int goods_no;
	private Date liked_regdate;
}
