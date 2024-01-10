package com.example.demo.controller.gpt;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.model.GptMessage;
import com.example.demo.model.GptRole;
import com.example.demo.service.GptService;


@RestController
@RequestMapping("gpt_write")
public class GptController {
	
	private final GptService gptService;
	
	public GptController(GptService gptService) {
        this.gptService = gptService;
    }
	
	@PostMapping("/prompt")
	public String selectPrompt(@RequestBody GptRole gptrole, GptMessage gptMessage) {
 //   public ResponseEntity<Map<String, Object>> selectPrompt(@RequestBody GptRole gptrole, GptMessage gptMessage) {
		
		System.out.println("GptRole로 받은 객체" + gptrole.getGoods_name()+gptrole.getGoods_price()+gptrole.getGoods_content());
		
        Map<String, Object> result = gptService.prompt(gptrole, gptMessage);
        
        System.out.println("컨트롤러에서 result 출력: "+result.get("content")); // 내용만 출력
        
        String goods_content = (String)result.get("content");
 //       goods_content = goods_content.replace("\n","<br>");
        return goods_content;
//        return new ResponseEntity<>(result, HttpStatus.OK);
    }
	
}