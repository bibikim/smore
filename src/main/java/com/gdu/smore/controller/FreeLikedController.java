package com.gdu.smore.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.gdu.smore.service.FreeLikedService;

@RestController
public class FreeLikedController {

	@Autowired
	private FreeLikedService likeService;
	
	@ResponseBody
	@GetMapping(value="/free/likeCheck", produces="application/json")
	public Map<String, Object> getLikeCheck(HttpServletRequest request) {
		return likeService.getLikeCheck(request);
	}
	
	
	@GetMapping(value="/free/likeCnt", produces="application/json")
	public Map<String, Object> getLikeCnt(int freeNo) {
		return likeService.getLikeCount(freeNo);
	}
	
	@ResponseBody
	@GetMapping(value="/free/mark", produces="application/json")
	public Map<String, Object> mark(HttpServletRequest request) {
		return likeService.mark(request);
	}
	
}
