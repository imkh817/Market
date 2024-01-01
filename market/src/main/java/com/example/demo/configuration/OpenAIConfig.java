package com.example.demo.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.client.RestTemplate;


@Configuration
public class OpenAIConfig {

	@Value("${openai.api.key}")
	private String openaiApiKey;
	
	// RestTemplate을 사용하기 위한 객체
	@Bean
	public RestTemplate template() {
		RestTemplate restTemplate = new RestTemplate();
		return restTemplate;
	}
	
	@Bean
	// curl 요청에서 -H 두 개 
	public HttpHeaders httpHeaders() {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer "+openaiApiKey);
		headers.setContentType(MediaType.APPLICATION_JSON);
		return headers;
	}
}
