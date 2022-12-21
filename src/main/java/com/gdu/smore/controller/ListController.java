package com.gdu.smore.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ListController {

	@GetMapping("/user/studylist")
	public String studyList() {
		return "/user/studylist";
	}
	
	@GetMapping("/user/zzimlist")
	public String zzimList() {
		return "/user/zzimlist";
	}
	
	
}

