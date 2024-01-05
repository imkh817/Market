package com.example.demo.model;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("goods")
public class Goods {
	private int goods_no;
	private int member_no;
	private int category_no;
	private String goods_name;
	private String goods_content;
	private int goods_price;
	private String goods_place;
	private String goods_readcount;
	private Date goods_regdate;
	private String goods_state; // -> 1 : 판매중 , 2: 예약중 3: 판매완료 4: 삭제
	private String goods_image;

	// mypage paging
	private int start_list;
	private int end_list;
	
	// liked
	private Liked liked;
	
	@Override
    public String toString() {
        return "Goods{" +
                "goods_no=" + goods_no +
                ", member_no=" + member_no +
                ", category_no=" + category_no +
                ", goods_name='" + goods_name + '\'' +
                ", goods_content='" + goods_content + '\'' +
                ", goods_price=" + goods_price +
                ", goods_place='" + goods_place + '\'' +
                ", goods_readcount='" + goods_readcount + '\'' +
                ", goods_regdate=" + goods_regdate +
                ", goods_state='" + goods_state + '\'' +
                ", goods_image='" + goods_image + '\'' +
                '}';
    }
}
