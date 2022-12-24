package com.gdu.smore.service;

import java.util.List;

import com.gdu.smore.domain.chat.ChatRoomDTO;

public interface ChatRoomService {
	
	public ChatRoomDTO createChatRoomDTO(String name);
    public ChatRoomDTO findRoomById(String id);
    public List<ChatRoomDTO> findAllRooms();
}