package com.gdu.smore.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ListController {

	@GetMapping("/user/studylist")
	public String requiredLogin_studyList() {
		return "/user/studylist";
	}
	
	@GetMapping("/user/zzimlist")
	public String requiredLogin_zzimList() {
		return "/user/zzimlist";
	}
	
	
}

