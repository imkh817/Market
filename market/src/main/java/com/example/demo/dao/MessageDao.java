package com.example.demo.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.model.Message;

@Repository
public class MessageDao {

	@Autowired
	private SqlSession sqlSession;

	// 메세지 리스트
	public ArrayList<Message> messageList(Message to) {

		String nick = to.getNick();
		// 메세지 리스트에 나타낼 것들 가져오기 - 가장 최근 메세지, 보낸사람 profile 사진, 보낸사람 nick
		
		ArrayList<Message> list = (ArrayList) sqlSession.selectList("message_list", to);
		System.out.println("to:" +  to);
		System.out.println("list:" +  list);

		for (Message mto : list) {
			mto.setNick(nick);
			// 현재 사용자가 해당 room에서 안읽은 메세지의 갯수를 가져온다.
			int unread = sqlSession.selectOne("count_unread", mto);
			// 현재 사용자가 메세지를 주고받는 상대 profile을 가져온다.
			String profile = sqlSession.selectOne("get_other_profile",mto);
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
			System.out.println("DAO messageList mto : "+mto);
		}

		return list;
	}


	// room 별 메세지 내용을 가져온다.
	public ArrayList<Message> roomContentList(Message to) {
		
		System.out.println("room : " + to.getMessage_room());
		System.out.println("recv_nick : " + to.getMessage_recv_nick());
		System.out.println("nick : " + to.getNick());
		// 메세지 내역을 가져온다
		ArrayList<Message> clist = (ArrayList) sqlSession.selectList("room_content_list", to);

		// 해당 방의 메세지들 중 받는 사람이 현재사용자의 nick인 메세지를 모두 읽음 처리한다
		sqlSession.update("message_read_chk", to);

		return clist;
	}
	
	// 메세지 list에서 메세지를 보낸다.
	public int messageSendInlist(Message to) {
		
		// 메세지리스트에서 보낸건지 프로필에서 보낸건지 구분하기 위함
		if(to.getMessage_room() == 0) {	// room이 0이라면 프로필에서 보낸거다
			int exist_chat = sqlSession.selectOne("exist_chat", to);
			// 프로필에서 보낸것중 메세지 내역이없어서 첫메세지가 될경우를 구분하기 위함
			if(exist_chat == 0) {	// 메세지 내역이 없어서 0이면 message 테이블의 room 최댓값을 구해서 to에 set 한다.
				int max_room = sqlSession.selectOne("max_room", to);
				to.setMessage_room(max_room);
			}else {		// 메세지 내역이 있다면 해당 room 번호를 가져온다.
				int room = Integer.parseInt(sqlSession.selectOne("select_room", to) );
				to.setMessage_room(room);
			}
		}
		
		int flag = sqlSession.insert("messageSendInlist",to);
		return flag;
	}

}