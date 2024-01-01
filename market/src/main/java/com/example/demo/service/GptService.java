package com.example.demo.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.demo.model.GptMessage;

// gpt 서비스 인터페이스

@Service
public interface GptService {
	Map<String, Object> prompt(GptMessage gptMessage);
}
