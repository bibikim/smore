package com.gdu.smore.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class RedController {
	
	@GetMapping("/red/write")
	public String red() {
		return "red/write";
	}
}

