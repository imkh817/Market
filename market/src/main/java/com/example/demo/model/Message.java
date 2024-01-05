package com.example.demo.model;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("message")
public class Message {
	private String message_no; 
	private int message_room;
	private String message_send_nick;
	private String message_recv_nick;
	private String message_send_time;
	private String message_read_time;
	private String message_content;
	private int message_read_chk;
	
	// 현재 사용자의 메세지 상대 nick을 담는다.
	private String other_nick;
	
	// 현재 사용자의 메세지 상대 profile을 담는다.
	private String profile;
	
	// 현재 사용자 nick
	private String nick;
	
	// 안읽은 메세지 갯수 
	private int unread;
}