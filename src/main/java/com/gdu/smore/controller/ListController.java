package com.gdu.smore.controller;

import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.gdu.smore.service.ListService;

@RestController
public class ListController {
	
	@Autowired
	private ListService listService;

	@GetMapping(value="/user/mypage/studylist/page{page}", produces = "application/json")
	public Map<String, Object> getStudyList(@PathVariable(value="page", required = false) Optional<String> opt){
		int page = Integer.parseInt(opt.orElse("1"));
		return listService.getStudyList(page);
	}
	
	@GetMapping(value="/user/mypage/zzimlist/page{page}", produces = "application/json")
	public Map<String, Object> getZzimList(@PathVariable(value="page", required = false) Optional<String> opt){
		int page = Integer.parseInt(opt.orElse("1"));
		return listService.getZzimList(page);
	}
	
	
	
	
}

