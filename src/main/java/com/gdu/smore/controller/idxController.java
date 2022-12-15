package com.gdu.smore.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class idxController {
	
    @GetMapping("/")
    public String index() {
      return "index";
    }

	@GetMapping("/admin/page")
	public String adminPage() {
		return "admin/page";
	}
	
	@GetMapping("/userInfo/detail")
	public String detail(@RequestParam(value="userNo", required=false, defaultValue="0") int userNo, Model model) {
		
	}
}
