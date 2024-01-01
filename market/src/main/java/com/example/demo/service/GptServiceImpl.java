package com.example.demo.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.example.demo.configuration.OpenAIConfig;
import com.example.demo.model.GptMessage;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

// gptService 구현체
@Service
public class GptServiceImpl implements GptService{
	
	private final OpenAIConfig openAIConfig;
	
	public GptServiceImpl(OpenAIConfig openAIConfig) {
		this.openAIConfig = openAIConfig;
	}

	@Value("${openai.model}")
	private String model;
	
	@Value("${openai.api.url}")
	private String url;
	
	// gpt prompt
	@Override
	public Map<String, Object> prompt(GptMessage gptMessage) {
		System.out.println("gpt서비스 프롬포트 실행");
		
		Map<String, Object> result = new HashMap<>();
		
		// 1. header를 가져옴
		HttpHeaders headers = openAIConfig.httpHeaders();
		
		String requestBody = "";
		ObjectMapper om = new ObjectMapper();
		
		// role 추가
		// messages를 배열로 감싸기 위한 리스트 생성
		List<Map<String, String>> messagesList = new ArrayList<>();

		// system role
		Map<String, String> message1 = new HashMap<>();
		message1.put("role", "system");
		message1.put("content", "중고거래 사이트에서 작성한 글을 100자 이내로 문장을 끊지말고 수정해줘");
		messagesList.add(message1);

		// 메시지 2
		Map<String, String> message2 = new HashMap<>();
		message2.put("role", "assistant");
		message2.put("content", "가격은 10000");
		messagesList.add(message2);

		// 메시지 3
		Map<String, String> message3 = new HashMap<>();
		message3.put("role", "assistant");
		message3.put("content", "상품 이름은 아이폰 13프로");
		messagesList.add(message3);

		// 메시지 4
		Map<String, String> message4 = new HashMap<>();
		message4.put("role", "user");
		message4.put("content", "아이폰 13 프로 팔아요. 작년에 구매했습니다");
		messagesList.add(message4);
		
		System.out.println("메세지 요청 값:"+messagesList);
		
		// 2. properties의 model을 가져와서 객체에 추가
		gptMessage = GptMessage.builder()
					.model(model)
					.messages(messagesList)
					.temperature(0.8f)
					.build();
		try {
		// 3. Object -> Stirng 직렬화
			requestBody = om.writeValueAsString(gptMessage);
			// writeValueAsString ->  Jackson 라이브러리에서 제공되는 메서드 (ObjectMapper클래스에 속해있음)
			// Java 객체를 JSON 문자열로 직렬화하는 데 사용
			System.out.println("직렬화 requestBody: "+requestBody);
			
		}catch (JsonProcessingException e){
			throw new RuntimeException(e);
		}
		
		// 4. 통신을 위한 restTemplate 구성
		HttpEntity requestEntity = new HttpEntity<>(requestBody, headers); // 요청
		ResponseEntity response = openAIConfig.template()
								.exchange(
										url,
										HttpMethod.POST,
										requestEntity,
										String.class);// api응답받는 결과 (gpt니까 string)

		System.out.println("APi결과: "+response);
		return result;
	}

}
