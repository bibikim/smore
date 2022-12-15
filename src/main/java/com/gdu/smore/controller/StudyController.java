package com.gdu.smore.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.gdu.smore.service.StudyService;


@Controller
public class StudyController {
	
	@Autowired
	private StudyService studyService;
	
	@GetMapping("/study/list")
	public String getStudyList(HttpServletRequest request, Model model) {
		studyService.getStudyList(request, model);
		return "study/list";
	}
	
	@GetMapping("/study/write")
	public String write() {
		return "study/write";
	}
	
	@PostMapping("/study/add")
	public void addStudy(HttpServletRequest request, HttpServletResponse response) {
		studyService.saveStudy(request, response);
	}
}

