package com.example.demo.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{

	@Autowired
	private LoginInterceptor loginInterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {

		//WebMvcConfigurer.super.addInterceptors(registry);
		registry.addInterceptor(loginInterceptor).addPathPatterns("/mypage/**", "/sell_form", "/chat", "/message_list", "/auth_location");
	}
	
	
	
}
