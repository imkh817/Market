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
import com.example.demo.model.GptRole;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
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
	
	// gpt prompt 요청
	@Override
	public Map<String, Object> prompt(GptRole gptrole, GptMessage gptMessage) {
		
		Map<String, Object> result = new HashMap<>();
		
		// 1. config에서 작성한 header를 가져옴
		HttpHeaders headers = openAIConfig.httpHeaders();
		
		String requestBody = "";
		ObjectMapper om = new ObjectMapper();
		
		String getGoods_price = gptrole.getGoods_price();
		String getGoods_name = gptrole.getGoods_name();
		String getGoods_content = gptrole.getGoods_content();
		
		// 2. 요청시 role 추가
		// messages를 배열로 감싸기 위한 리스트 생성 -> messages요청을 배열로 보내야되기 때문
		List<Map<String, String>> messagesList = new ArrayList<>();

		// system role
		Map<String, String> message1 = new HashMap<>();
		message1.put("role", "system");
		message1.put("content", "중고거래 사이트에서 판매글 작성");
		messagesList.add(message1);

		// assistant role1
		Map<String, String> message2 = new HashMap<>();
		message2.put("role", "assistant");
		message2.put("content", "상품가격은"+getGoods_price);
		messagesList.add(message2);

		// assistant role2
		Map<String, String> message3 = new HashMap<>();
		message3.put("role", "assistant");
		message3.put("content", "상품이름은"+getGoods_name);
		messagesList.add(message3);

		// 유저가 입력한 메세지
		Map<String, String> message4 = new HashMap<>();
		message4.put("role", "user");
		message4.put("content", getGoods_content+"-> 이 판매글 내용을 100자이내로 끊지 말고 수정해줘");
		messagesList.add(message4);
		
		System.out.println("메세지 요청 값:"+messagesList);
		
		// 3. properties의 model을 가져와서 객체에 추가
		gptMessage = GptMessage.builder()
					.model(model)
					.messages(messagesList)
					.temperature(0.8f) // 0~2 중에서 값이 높을수록 무작위 출력
					.build();
		try {
		// 4. josn형식으로 직렬화
			requestBody = om.writeValueAsString(gptMessage);
			// writeValueAsString ->  Jackson 라이브러리에서 제공되는 메서드 (ObjectMapper클래스에 속해있음)
			// Java 객체를 JSON 문자열로 직렬화하는 데 사용
			System.out.println("직렬화 requestBody: "+requestBody);
		}catch (JsonProcessingException e){
			throw new RuntimeException(e);
		}
		
		// 5. 통신을 위한 restTemplate 구성
		HttpEntity requestEntity = new HttpEntity<>(requestBody, headers); // 요청
		ResponseEntity response = openAIConfig.template()
								.exchange(
										url,//properties의 
										HttpMethod.POST,
										requestEntity,
										String.class);// HTTP 응답 타입 지정

		System.out.println("API결과: "+response);
		
		// 6. 받은 응답 역직렬화
		// json -> map
		try {
			String responseBody = (String) response.getBody();
			result = om.readValue(responseBody, new TypeReference<Map<String, Object>>() {
			});
		}catch(JsonProcessingException e) {
			throw new RuntimeException(e);
		}
		
		// 응답중에서 content만 뽑기
//		choices 내용 출력: 
//		[{index=0, message={role=assistant, content=시에라블루 칼라의 아이폰 13 프로 판매합니다. 몇 가지 스크래치는 있지만 기능에는 영향을 주지 않습니다. 사진을 참고해주세요. 가격은 1234원입니다.}, logprobs=null, finish_reason=stop}]
		System.out.println("역직렬화 result: "+result);
		System.out.println("choices 내용 출력: "+result.get("choices"));
		
//		message 배열 내용 출력: 
//		{index=0, message={role=assistant, content=판매하는 상품은 시에라블루 컬러의 아이폰 13 프로입니다. 스크레치가 약간 있을 수 있습니다. 가격은 1234원입니다.}, logprobs=null, finish_reason=stop}
		List<Map<String, Object>> choicesList = (List<Map<String, Object>>) result.get("choices");
		System.out.println("message 배열 내용 출력: "+choicesList.get(0));
		
//		message 내용출력: 
//		{role=assistant, content=시에라 블루 컬러의 아이폰 13 프로 판매합니다. 스크레치가 조금 있습니다. 가격은 1234입니다.}
		System.out.println("message 내용출력: "+choicesList.get(0).get("message"));
		
		Map<String, Object> messageList = (Map<String, Object>) choicesList.get(0).get("message");
		System.out.println("result: "+messageList.get("content")); // 내용만 출력
		
		result = messageList;
		
		return messageList;
	}

}
