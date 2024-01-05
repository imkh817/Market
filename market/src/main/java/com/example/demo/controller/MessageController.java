package com.example.demo.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.MessageDao;
import com.example.demo.model.Message;


/**
 * Handles requests for the application home page.
 */
@Controller
public class MessageController {

	@Autowired
	private MessageDao messageDao;

	// 메세지 목록
	@RequestMapping(value = "/message_list")
	public String message_list(HttpServletRequest request, HttpSession session) {
		// System.out.println("현대 사용자 nick : " + session.getAttribute("nick"));
		String nick = (String) session.getAttribute("member_nickname");
		System.out.println("Controller /message_list: " + nick);
		
		Message to = new Message();
		to.setNick(nick);

		// 메세지 리스트
		ArrayList<Message> list = messageDao.messageList(to);

		request.setAttribute("list", list);

		return "message/message_list";
	}

	// 메세지 목록
	@RequestMapping(value = "/message_ajax_list")
	public String message_ajax_list(HttpServletRequest request, HttpSession session) {
		// System.out.println("현대 사용자 nick : " + session.getAttribute("nick"));

		String nick = (String) session.getAttribute("member_nickname");

		Message to = new Message();
		to.setNick(nick);

		// 메세지 리스트
		ArrayList<Message> list = messageDao.messageList(to);
		request.setAttribute("list", list);

		return "message/message_ajax_list";
	}

	@RequestMapping(value = "/message_content_list")
	public String message_content_list(HttpServletRequest request, HttpSession session) {
		int room = Integer.parseInt(request.getParameter("message_room"));
		Message to = new Message();
		to.setMessage_room(room);
		to.setNick((String) session.getAttribute("member_nickname"));

		// 메세지 내용을 가져온다.
		ArrayList<Message> clist = messageDao.roomContentList(to);

		request.setAttribute("clist", clist);

		return "message/message_content_list";
	}

	// 메세지 리스트에서 메세지 보내기
	@ResponseBody
	@RequestMapping(value = "/message_send_inlist")
	public int message_send_inlist(@RequestParam int room, @RequestParam String other_nick,
			@RequestParam String content, HttpSession session) {
		System.out.println("/message_send_inlist");
		Message to = new Message();
		to.setMessage_room(room);
		to.setMessage_send_nick((String) session.getAttribute("member_nickname"));
		to.setMessage_recv_nick(other_nick);
		to.setMessage_content(content);

		int flag = messageDao.messageSendInlist(to);

		return flag;
	}

}