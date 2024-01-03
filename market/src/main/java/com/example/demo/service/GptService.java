package com.example.demo.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.demo.model.GptMessage;
import com.example.demo.model.GptRole;

// gpt 서비스 인터페이스

@Service
public interface GptService {
	
	// gpt prompt 요청
	Map<String, Object> prompt(GptRole gptrole, GptMessage gptMessage);
	
}
