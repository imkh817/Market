package com.example.demo.service.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// 이전 페이지 URL 저장을 위한 Interceptor
public class RefererInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 로그인 폼으로 이동하는 경우에만 referer를 세션에 저장
		if (request.getRequestURI().equals("/market/login_form")) {
			String referer = request.getHeader("referer");
			request.getSession().setAttribute("referer", referer);
		}

		return true;
	}
}
