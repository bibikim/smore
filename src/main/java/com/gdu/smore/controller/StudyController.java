package com.gdu.smore.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@GetMapping("/study/list_scroll")
	public String listScrollpage() {
		return "study/list_scroll";
	}
	
	@ResponseBody
	@GetMapping(value="/study/list_scroll", produces="application/json")
	public Map<String, Object> listScroll(HttpServletRequest request, Model model) {
		return studyService.getStudyScroll(request, model);
	}
	
	@GetMapping("/study/write")
	public String write() {
		return "study/write";
	}
	
	@PostMapping("/study/add")
	public void addStudy(HttpServletRequest request, HttpServletResponse response) {
		studyService.saveStudy(request, response);
	}

	@GetMapping("/study/increse/hit")
	public String increseHit(@RequestParam(value="studNo", required=false, defaultValue="0") int studNo) {
		int result = studyService.increseStudyHit(studNo);
		if(result > 0) {  // 조회수 증가에 성공하면 상세보기로 이동
			return "redirect:/study/detail?studNo=" + studNo;
		} else {          // 조회수 증가에 실패하면 목록보기로 이동
			return "redirect:/study/list";
		}
	}
	
	@GetMapping("/study/detail")
	public String detail(@RequestParam(value="studNo", required=false, defaultValue="0") int studNo, Model model) {
		model.addAttribute("study", studyService.getStudyByNo(studNo));
		return "study/detail";
	}
	
	@PostMapping("/study/edit")
	public String edit(int studNo, Model model) {
		model.addAttribute("study", studyService.getStudyByNo(studNo));
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
	
	
	@ResponseBody
	@GetMapping(value="/study/comment/getCount", produces="application/json")
	public Map<String, Object> getCount(@RequestParam("studNo") int studNo) {
		return studyService.getCommentCount(studNo);
	}
	
	@ResponseBody
	@PostMapping(value="/study/comment/add", produces="application/json")
	public Map<String, Object> add(HttpServletRequest request) {
		return studyService.addComment(request);
	}
	
	@ResponseBody
	@GetMapping(value="/study/comment/list", produces="application/json")
	public Map<String, Object> list(HttpServletRequest request) {
		return studyService.getCommentList(request);
	}
	
	@ResponseBody	
	@GetMapping(value="/study/getZCheck", produces="application/json")
	public Map<String, Object> getZCheck(HttpServletRequest request) {
		return studyService.getZCheck(request);
	}
	
	@ResponseBody	
	@GetMapping(value="/study/getZCount", produces="application/json")
	public Map<String, Object> getZCount(int studNo) {
		return studyService.getZCount(studNo);
	}
	
	@ResponseBody	
	@GetMapping(value="/study/mark", produces="application/json")
	public Map<String, Object> mark(HttpServletRequest request) {
		return studyService.mark(request);
	}
	

	@GetMapping("/study/map")
	public String map() {
		return "study/map";
	}

	@GetMapping("/study/location")
	public String location() {
		return "study/location";
	}
	
}

