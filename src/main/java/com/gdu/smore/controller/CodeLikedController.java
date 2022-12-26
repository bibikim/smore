package com.gdu.smore.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gdu.smore.service.CodeLikedService;

@RestController
public class CodeLikedController {

	@Autowired
	private CodeLikedService likeService;
	
	
	@GetMapping(value="/code/likeCheck", produces="application/json")
	public Map<String, Object> getLikeCheck(HttpServletRequest request) {
		return likeService.getLikeCheck(request);
	}
	
	
	@GetMapping(value="/code/likeCnt", produces="application/json")
	public Map<String, Object> getLikeCnt(int coNo) {
		return likeService.getLikeCount(coNo);
	}
	
	@GetMapping(value="/code/mark", produces="application/json")
	public Map<String, Object> mark(HttpServletRequest request) {
		return likeService.mark(request);
	}
	
}
