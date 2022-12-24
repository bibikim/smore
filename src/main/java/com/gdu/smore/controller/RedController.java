package com.gdu.smore.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.gdu.smore.service.RedService;


@Controller
public class RedController {
	
	@Autowired
	private RedService redService;
	
	@GetMapping("/red/write")
	public String red() {
		return "red/write";
	}
	
	@PostMapping("/red/sendred")
	public void addStudy(HttpServletRequest request, HttpServletResponse response) {
		redService.saveRed(request, response);
	}	
}

