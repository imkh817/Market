package com.example.demo.service.compare;

import lombok.Data;

@Data
public class ComparePaging {

	private int total; // 총 데이터 갯수
	private int rowPerPage; // 페이지 당 보여줄 데이터 갯수
	private int pagePerBlk = 10; // 페이지 버튼을 나타낼 갯수
	private int currentPage; // 현재 페이지
	private int startPage; // 화면에 표시될 시작 페이지
	private int endPage; // 화면에 표시될 마지막 페이지
	private int totalPage; // 총 페이지
	private int startRow;
	private int endRow;

	public ComparePaging(int rowPerPage, int currentPage, int startRow, int endRow) {
		this.rowPerPage = rowPerPage;
		this.currentPage = currentPage;
		this.startRow = startRow;
		this.endRow = endRow;
	}
	
	public void setTotal(int total) {
		this.total = total;
		totalPage = (int) Math.ceil((double) total / rowPerPage);
		startPage = currentPage - (currentPage - 1) % pagePerBlk;
		endPage = startPage + pagePerBlk - 1;

		if (endPage > totalPage)
			endPage = totalPage;
	}

}
