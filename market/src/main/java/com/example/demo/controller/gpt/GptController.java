package com.example.demo.controller.gpt;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.model.GptMessage;
import com.example.demo.service.GptService;


@RestController
@RequestMapping("gpt_write")
public class GptController {
	
	private final GptService gptService;
	
	public GptController(GptService gptService) {
        this.gptService = gptService;
    }
	
	@PostMapping("/prompt")
    public ResponseEntity<Map<String, Object>> selectPrompt(@RequestBody GptMessage gptMessage) {
		// json데이터를 객체로 매핑하는게 일반적임
		System.out.println("@RequestBody GptMessage로 받은 객체: "+gptMessage.getMessages());
		System.out.println("prompt 메서드 호출 성공");
		
        Map<String, Object> result = gptService.prompt(gptMessage);
        
        System.out.println("서비스 작업 끗 ~!");
        System.out.println(result);
        
        return new ResponseEntity<>(result, HttpStatus.OK);
    }
	
}

/*
curl https://api.openai.com/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d '{
  "model": "gpt-3.5-turbo",
  "messages": [
    {
      "role": "system",
      "content": "중고거래 사이트에서 작성한 글을 100자 이내로 문장을 끊지말고 수정해줘"
    },
    {
      "role": "assistant",
      "content": "가격은 10000"
    },
    {
      "role": "assistant",
      "content": "상품 이름은 아이폰 13프로"
    },
    {
      "role": "user",
      "content": "아이폰 13 프로 팔아요. 작년에 구매했습니다"
    }
  ],
  "temperature": 0.8,
  "max_tokens": 100,
  "top_p": 1,
  "frequency_penalty": 0,
  "presence_penalty": 0
}'
*/
