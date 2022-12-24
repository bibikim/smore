package com.gdu.smore.controller.chat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.smore.domain.chat.ChatRoomDTO;
import com.gdu.smore.service.ChatRoomService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/chat")
@Log4j2
public class RoomController {
	
	@Autowired
    private  ChatRoomService chatRoomService;

    //채팅방 목록 조회
	@ResponseBody
    @GetMapping(value = "/rooms")
    public List<ChatRoomDTO> rooms(){

        log.info("# All Chat Rooms");
        //ModelAndView mv = new ModelAndView("chat/rooms");

        //mv.addObject("list", chatRoomService.findAllRooms());

        return chatRoomService.findAllRooms();
    }

    //채팅방 개설
    @ResponseBody
    @PostMapping(value = "/room")
    public ChatRoomDTO create(RedirectAttributes rttr){

    	String name = "1번방";
        log.info("# Create Chat Room , name: " + name);
        
        rttr.addFlashAttribute("room", chatRoomService.createChatRoomDTO(name));
        
        return  chatRoomService.createChatRoomDTO(name);
    }

    //채팅방 조회
    @GetMapping("/room")
    public void getRoom(String roomId, Model model){

        log.info("# get Chat Room, roomID : " + roomId);

        model.addAttribute("room", chatRoomService.findRoomById(roomId));
    }
}