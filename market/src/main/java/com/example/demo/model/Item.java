package com.example.demo.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
public class Item {
	 	private final String title;
	    private final String link;
	    private final String image;
	    private final String lprice;
	    private final String brand;
	    private final String maker;
	    private final String category1;

}