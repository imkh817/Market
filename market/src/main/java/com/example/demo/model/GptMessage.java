package com.example.demo.model;

import java.util.List;
import java.util.Map;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

// 요청 및 응답 값에 대한 객체
// 프롬프트 요청 DTO

// @NoArgsConstructor는 매개변수 없는 기본생성자를 자동생성하도록함
// @NoArgsConstructor(access = AccessLevel.PROTECTED)는 access로 접근제어 수준 설정 -> 따라서 상속된 클래스에서 사용
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class GptMessage {
	
	// 요청
	private String model;
	private List<Map<String, String>> messages;
	private float temperature;
	
	@Builder
	GptMessage(String model, List<Map<String, String>> messages, float temperature){
		this.model=model;
		this.messages=messages;
		this.temperature=temperature;
	}
}
