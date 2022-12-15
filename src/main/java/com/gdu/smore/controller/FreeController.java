package com.gdu.smore.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.smore.service.FreeService;

@Controller
public class FreeController {

	@Autowired
	private FreeService freeService;
	
	
	@GetMapping("/free/list")
	public String freelist(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		freeService.getFreeList(model);
		return "free/list";
	}
	
	@GetMapping("/free/write")
	public String write() {
		return "free/write";
	}
	
	@ResponseBody
	@PostMapping(value="/free/uploadImage", produces="application/json")
	public Map<String, Object> uploadImage(MultipartHttpServletRequest mRequest) {
		return freeService.savefImage(mRequest);
	}
	
	@PostMapping("/free/save")
	public void saveFree(HttpServletRequest request, HttpServletResponse response) {
		freeService.saveFree(request, response);
	}
	
	
	
}
