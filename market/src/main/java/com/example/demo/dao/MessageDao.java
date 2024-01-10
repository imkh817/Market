package com.example.demo.dao;


import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Message;

@Mapper
public interface MessageDao {

	ArrayList message_list(Message to);

	int count_unread(Message mto);

	String get_other_profile(Message mto);

	ArrayList room_content_list(Message to);

	void message_read_chk(Message to);

	int exist_chat(Message to);

	int max_room(Message to);

	String select_room(Message to);

	int messageSendInlist(Message to);

	String selectNick(int member_no);

	void createRoom(Message createRoom);

	void messageContentRemove(int messageNum);

	
		

}