package com.example.demo.model;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("goods")
public class Goods {
	private int goods_no;
	private String goods_name;
	private String goods_content;
	private int goods_price;
	private String goods_place;
	private String goods_readcount;
	private Date goods_regdate;
	private int member_no;
	private String goods_state; //-> 1 : 판매중 , 2: 예약중 3: 판매완료 4: 삭제
	private String goods_image1;
	private String goods_image2;
	private String goods_image3;
	
	// paging
	private int start_list;
	private int end_list;
	
	// sort
	private String sort_order;
	
	// search
	private String keyword;
}
