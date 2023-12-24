package com.example.demo.service;

import lombok.Data;

@Data
public class Paging {
	private int total;
	private int list_per_page;
	private int link_per_page;
	
	private int page_current;
	private int page_start;
	private int page_end;
	private int page_total;
	
	public Paging(int total, int list_per_page, int page_current) {
		this.total = total;
		this.list_per_page = list_per_page;
		this.page_current = page_current;
		
		page_total = (int)Math.ceil((double)total/list_per_page);
		page_start = page_current - (page_current - 1) % link_per_page;
		page_end = page_start + link_per_page - 1;
		
		if(page_end > page_total) {
			page_end = page_total;
		}
	}
	
	@Override
	public String toString() {
		return "Paging[total="+total+
						",list_per_page="+list_per_page+
						",page_current="+page_current+
						",page_start="+page_start+
						",page_end="+page_end+
						",page_total="+page_total+"]";
	}
}
