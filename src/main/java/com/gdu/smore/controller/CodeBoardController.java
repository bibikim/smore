package com.gdu.smore.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdu.smore.service.CodeBoardService;

import lombok.extern.log4j.Log4j2;

@Controller
public class CodeBoardController {
	
	@Autowired
	private CodeBoardService codeBoardService;
	
	
	@GetMapping("/view/popup")
	public String popup() {
		return "popup/popup";
	}	
	
	@GetMapping("/code/list")
	public String list(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);  // model에 request를 저장하기
		codeBoardService.getCodeBoardList(model);          // model만 넘기지만 이미 model에는 request가 들어 있음
		return "code/list";
	}
	
	@GetMapping("/code/write")
	public String write() {
		return "code/write";
	}
	
	
	@PostMapping("/code/add")
	public void add(HttpServletRequest request, HttpServletResponse response) {
		codeBoardService.saveCodeBoard(request, response);
	}
	
	@GetMapping("/codeboard/increse/hit")
	public String increseHit(@RequestParam(value="cNo", required=false, defaultValue="0") int cNo) {
		int result = codeBoardService.increseCodeBoardHit(cNo);
		if(result > 0) {  // 조회수 증가에 성공하면 상세보기로 이동
			return "redirect:/codeboard/detail?cNo=" + cNo;
		} else {          // 조회수 증가에 실패하면 목록보기로 이동
			return "redirect:/codeboard/list";
		}
	}
	
	@GetMapping("/codeboard/detail")
	public String detail(@RequestParam(value="cNo", required=false, defaultValue="0") int cNo, Model model) {
		model.addAttribute("codeboard", codeBoardService.getCodeBoardByNo(cNo));
		return "codeboard/detail";
	}
	
	@PostMapping("/codeboard/edit")
	public String edit(int cNo, Model model) {
		model.addAttribute("codeboard", codeBoardService.getCodeBoardByNo(cNo));
		return "codeboard/edit";
	}
	
	@PostMapping("/codeboard/modify")
	public void modify(HttpServletRequest request, HttpServletResponse response) {
		codeBoardService.modifyCodeBoard(request, response);
	}
	
	@PostMapping("/codeboard/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		codeBoardService.removeCodeBoard(request, response);
	}
	
	
}
