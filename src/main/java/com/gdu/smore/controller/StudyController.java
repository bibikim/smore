package com.gdu.smore.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	/*
	@GetMapping("/study/list_scroll")
	public String getStudyList(HttpServletRequest request, Model model) {
		studyService.getStudyList(request, model);
		return "study/list_scroll";
	}
	*/
	
	@GetMapping("/study/write")
	public String write() {
		return "study/write";
	}
	
	@PostMapping("/study/add")
	public void addStudy(HttpServletRequest request, HttpServletResponse response) {
		studyService.saveStudy(request, response);
	}

	@GetMapping("/blog/increse/hit")
	public String increseHit(@RequestParam(value="SNo", required=false, defaultValue="0") int SNo) {
		int result = studyService.increseStudyHit(SNo);
		if(result > 0) {  // 조회수 증가에 성공하면 상세보기로 이동
			return "redirect:/study/detail?SNo=" + SNo;
		} else {          // 조회수 증가에 실패하면 목록보기로 이동
			return "redirect:/study/list";
		}
	}
	
	@GetMapping("/study/detail")
	public String detail(@RequestParam(value="SNo", required=false, defaultValue="0") int SNo, Model model) {
		model.addAttribute("study", studyService.getStudyByNo(SNo));
		return "study/detail";
	}
	
	@PostMapping("/study/edit")
	public String edit(int SNo, Model model) {
		model.addAttribute("study", studyService.getStudyByNo(SNo));
		return "study/edit";
	}
	
	@PostMapping("/study/modify")
	public void modify(HttpServletRequest request, HttpServletResponse response) {
		studyService.modifyStudy(request, response);
	}
	
	@PostMapping("/study/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		studyService.removeStudy(request, response);
	}

}

