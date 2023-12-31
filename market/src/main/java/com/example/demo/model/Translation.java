package com.example.demo.model;

import lombok.Data;

@Data
public class Translation {
	
	private String srcLangType;
	private String tarLangType;
	private String translatedText;
}
