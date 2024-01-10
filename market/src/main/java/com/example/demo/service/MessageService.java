package com.example.demo.service;

import java.util.ArrayList;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MessageDao;
import com.example.demo.model.Message;

@Service
public class MessageService {

	@Autowired
	private MessageDao messageDao;

	// 메세지 리스트
	public ArrayList<Message> messageList(Message to) {

		String nick = to.getNick();

		// 메세지 리스트에 나타낼 것들 가져오기 - 가장 최근 메세지, 보낸사람 profile 사진, 보낸사람 nick
		ArrayList<Message> list = (ArrayList) messageDao.message_list(to);

		for (Message mto : list) {
			mto.setNick(nick);
			// 현재 사용자가 해당 room에서 안읽은 메세지의 갯수를 가져온다.
			int unread = messageDao.count_unread(mto);
			// 현재 사용자가 메세지를 주고받는 상대 profile을 가져온다.
			String profile = messageDao.get_other_profile(mto);
			// 안읽은 메세지 갯수를 mto에 set한다.
			mto.setUnread(unread);
			// 메세지 상대의 프로필사진을 mto에 set한다.
			mto.setProfile(profile);
			// 메세지 상대 nick을 세팅한다. other_nick
			if (nick.equals(mto.getMessage_send_nick())) {
				mto.setOther_nick(mto.getMessage_recv_nick());
			} else {
				mto.setOther_nick(mto.getMessage_send_nick());
			}
		}
		return list;
	}

	// room 별 메세지 내용을 가져온다.
	public ArrayList<Message> roomContentList(Message to) {

		// 메세지 내역을 가져온다
		ArrayList<Message> clist = (ArrayList) messageDao.room_content_list(to);
		// 해당 방의 메세지들 중 받는 사람이 현재사용자의 nick인 메세지를 모두 읽음 처리한다
		messageDao.message_read_chk(to);

		return clist;
	}

	// 메세지 list에서 메세지를 보낸다.
	public int messageSendInlist(Message to) {

		// 메세지리스트에서 보낸건지 프로필에서 보낸건지 구분하기 위함
		if (to.getMessage_room() == 0) { // room이 0이라면 프로필에서 보낸거다
			int exist_chat = messageDao.exist_chat(to);
			// 프로필에서 보낸것중 메세지 내역이없어서 첫메세지가 될경우를 구분하기 위함
			if (exist_chat == 0) { // 메세지 내역이 없어서 0이면 message 테이블의 room 최댓값을 구해서 to에 set 한다.
				int max_room = messageDao.max_room(to);
				to.setMessage_room(max_room);
			} else { // 메세지 내역이 있다면 해당 room 번호를 가져온다.
				int room = Integer.parseInt(messageDao.select_room(to));
				to.setMessage_room(room);
			}
		}

		int flag = messageDao.messageSendInlist(to);
		return flag;
	}

	public String selectMemberNickname(int member_no) {
		String selectNick = messageDao.selectNick(member_no);
		return selectNick;
	}
	
	// 채팅방이 없을 시에 채팅방 생성하기.
	public void createRoom(Message createRoom) {
		// exist_chat : 메세지 내역이 있는지 검사하는 쿼리문
		int exist_chat = messageDao.exist_chat(createRoom);
		// 메세지 내역이 없는 경우
		if (exist_chat == 0) {
			int max_room = messageDao.max_room(createRoom);
			// 룸 번호의 최댓 값을 구해와서 +1 을 한 뒤에 DTO에 저장
			max_room = max_room + 1;
			createRoom.setMessage_room(max_room);
			// 이렇게 되면 보낸 이와 받는 이의 닉네임, 그리고 생성할 방의 번호를 지정해서 DAO에 넘길 수 있음.
			messageDao.createRoom(createRoom);
		} 
	}

	public void messageContentRemove(int messageNum) {
		messageDao.messageContentRemove(messageNum);
	}
}