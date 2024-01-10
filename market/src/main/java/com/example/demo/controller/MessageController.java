package com.example.demo.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.Member;
import com.example.demo.model.Message;
import com.example.demo.service.MessageService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MessageController {

	@Autowired
	private MessageService messageService;

	// 메세지 목록
	@RequestMapping(value = "/message_list")
	public String message_list(HttpServletRequest request, HttpSession session,
			 int member_no) {

		// 채팅방이 없을 시에 채팅방 생성하기.
		String nick = (String) session.getAttribute("member_nickname");
		String recvNickname = messageService.selectMemberNickname(member_no);

		Message createRoom = new Message();
		createRoom.setMessage_recv_nick(recvNickname);
		createRoom.setMessage_send_nick(nick);

		messageService.createRoom(createRoom);

		// 메시지 목록 불러오기
		Message to = new Message();
		to.setNick(nick);

		// 메세지 리스트
		ArrayList<Message> list = messageService.messageList(to);
		request.setAttribute("list", list);
		// 리졸버를 통해 message/message_list.jsp를 매핑하여 돌려준다.
		return "message/message_list";
	}

	// 메세지 목록
	@RequestMapping(value = "/message_ajax_list")
	public String message_ajax_list(HttpServletRequest request, HttpSession session) {

		String nick = (String) session.getAttribute("member_nickname");

		Message to = new Message();
		to.setNick(nick);

		// 메세지 리스트
		ArrayList<Message> list = messageService.messageList(to);
		request.setAttribute("list", list);

		// 리졸버를 통해 message/message_ajax_list.jsp를 매핑하여 돌려준다.
		System.out.println("/message_ajax_list의 list 값:" + list);
		
		// 내비바에 안읽은 메시지 갯수 띄우기	
		int unread_msg = 0;
		for(Message mto : list) {
			int unread = mto.getUnread();
			unread_msg += unread;
		}
		session.setAttribute("unread_msg", unread_msg);
		
		return "message/message_ajax_list";
	}

	@RequestMapping(value = "/message_content_list")
	public String message_content_list(HttpServletRequest request, HttpSession session, String other_nick) {

		int room = Integer.parseInt(request.getParameter("room"));

		Message to = new Message();
		to.setMessage_read_chk(0);
		to.setMessage_room(room);
		to.setNick((String) session.getAttribute("member_nickname"));
		to.setMessage_recv_nick(other_nick);
		// 메세지 내용을 가져온다.
		// 읽음 표시 : 읽었을 경우 message_read_chk = 1,
		// 안읽었을 경우 message_read_chk = 0.
		ArrayList<Message> clist = messageService.roomContentList(to);
		String myNick = to.getNick();

		request.setAttribute("clist", clist);
		request.setAttribute("myNick", myNick);

		return "message/message_content_list";
	}

	@RequestMapping(value = "/message_content_remove")
	public String message_content_remove(HttpSession session, String message_no) {
		
		int messageNum =  Integer.parseInt(message_no);
		messageService.messageContentRemove(messageNum);
		return "message/message_content_list";
	}

	// 메세지 리스트에서 메세지 보내기
	@ResponseBody
	@RequestMapping(value = "/message_send_inlist")
	public int message_send_inlist(@RequestParam int room, @RequestParam String other_nick,
			@RequestParam String content, HttpSession session) {
		Message to = new Message();
		to.setMessage_room(room);
		to.setMessage_send_nick((String) session.getAttribute("member_nickname"));
		to.setMessage_recv_nick(other_nick);
		to.setMessage_content(content);

		int flag = messageService.messageSendInlist(to);

		return flag;
	}

}