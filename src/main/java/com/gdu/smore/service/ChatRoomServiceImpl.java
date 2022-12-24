package com.gdu.smore.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;

import com.gdu.smore.domain.chat.ChatRoomDTO;

@Service
public class ChatRoomServiceImpl implements ChatRoomService {

    private Map<String, ChatRoomDTO> chatRoomDTOMap;

    @PostConstruct
    private void init(){
        chatRoomDTOMap = new LinkedHashMap<>();
    }
	
	
	@Override
	public ChatRoomDTO createChatRoomDTO(String name) {
       ChatRoomDTO room = ChatRoomDTO.create(name);
       chatRoomDTOMap.put(room.getRoomId(), room);

       return room;
	}
	
	@Override
	public List<ChatRoomDTO> findAllRooms() {
        List<ChatRoomDTO> result = new ArrayList<>(chatRoomDTOMap.values());
        Collections.reverse(result);
        return result;
	}
	
	@Override
	public ChatRoomDTO findRoomById(String id) {
		return chatRoomDTOMap.get(id);
	}
	
}
