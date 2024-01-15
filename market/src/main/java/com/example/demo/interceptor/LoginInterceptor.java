package com.example.demo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;


@Component
public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		
	    Object member_no = session.getAttribute("member_no");
		
		System.out.println("preHandler 동작 확인");
		if(member_no == null) {
			response.sendRedirect("login_form");
			return false;
		}
		
		return true;
	}

	
}
