package com.example.demo.model;

import lombok.Data;
import lombok.Getter;

@Data
@Getter
public class Item {
	 	private String title;
	    private String link;
	    private String image;
	    private String lprice;

	    public Item(String title, String link, String image, String lprice) {
	        this.title = title;
	        this.link = link;
	        this.image = image;
	        this.lprice = lprice;
	    }
}
