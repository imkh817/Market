package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.Category;
import com.example.demo.model.Message;
import com.example.demo.service.CategoryService;
import com.example.demo.service.MessageService;

@Controller
public class HomeController {
	
	@Autowired
	CategoryService CategoryService;
	
	@Autowired
	MessageService messageService;
	
	@RequestMapping("home")
	public String home(HttpServletRequest request, HttpSession session){
			String nick = (String) session.getAttribute("member_nickname");

			Message to = new Message();
			to.setNick(nick);

			// 메세지 리스트
			ArrayList<Message> list = messageService.messageList(to);
			request.setAttribute("list", list);

			// 내비바에 안읽은 메시지 갯수 띄우기	
			int unread_msg = 0;
			for(Message mto : list) {
				int unread = mto.getUnread();
				unread_msg += unread;
			}
			session.setAttribute("unread_msg", unread_msg);
			
		return "home";
	}
	
	@RequestMapping("navbar")
	public String nav_category(Model model) {
		List<Category> cg_list = CategoryService.get_category();
		model.addAttribute("cg_list", cg_list);
		return "include/navbar";
	}
}
