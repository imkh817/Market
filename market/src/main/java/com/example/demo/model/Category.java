package com.example.demo.model;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("category")
public class Category {
	private int category_no;
	private String category_name;
}
