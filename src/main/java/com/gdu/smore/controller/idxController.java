package com.gdu.smore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.gdu.smore.service.AdminService;

@Controller
public class idxController {
	
	@Autowired
	private AdminService adminService;
	
	
    @GetMapping("/")
    public String index() {
      return "index";
    }

	@GetMapping("/admin/page")
	public String adminPage() {
		return "admin/page";
	}
	

	
}
