package com.gdu.smore.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IdxController {
	
    @GetMapping("/")
    public String index() {
      return "index";
    }

	@GetMapping("/admin/page")
	public String requiredLogin_adminPage() {
		return "admin/page";
	}	
}
