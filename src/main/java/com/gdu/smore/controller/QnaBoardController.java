package com.gdu.smore.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdu.smore.service.QnaBoardService;

@Controller
public class QnaBoardController {
	
	@Autowired
	private QnaBoardService qnaBoardService;
	

	@GetMapping("/qna/view/popup")
	public String popup() {
		return "popup/popup";
	}	
	
	@GetMapping("/qna/list")
	public String list(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);  // model에 request를 저장하기
		qnaBoardService.getQnaBoardList(model);          // model만 넘기지만 이미 model에는 request가 들어 있음
		return "qna/list";
	}
	
	@GetMapping("/qna/write")
	public String write() {
		return "qna/write";
	}
	
	
	@PostMapping("/qna/add")
	public void add(HttpServletRequest request, HttpServletResponse response) {
		qnaBoardService.saveQnaBoard(request, response);
	}
	
	@GetMapping("/qnaboard/increse/hit")
	public String increseHit(@RequestParam(value="qNo", required=false, defaultValue="0") int qNo) {
		int result = qnaBoardService.increseQnaBoardHit(qNo);
		if(result > 0) {  // 조회수 증가에 성공하면 상세보기로 이동
			return "redirect:/qnaboard/detail?qNo=" + qNo;
		} else {          // 조회수 증가에 실패하면 목록보기로 이동
			return "redirect:/qnaboard/list";
		}
	}
	
	@GetMapping("/qnaboard/detail")
	public String detail(@RequestParam(value="qNo", required=false, defaultValue="0") int qNo, Model model) {
		model.addAttribute("codeboard", qnaBoardService.getQnaBoardByNo(qNo));
		return "qnaboard/detail";
	}
	
	@PostMapping("/qnaboard/edit")
	public String edit(int qNo, Model model) {
		model.addAttribute("qnaboard", qnaBoardService.getQnaBoardByNo(qNo));
		return "qnaboard/edit";
	}
	
	@PostMapping("/qnaboard/modify")
	public void modify(HttpServletRequest request, HttpServletResponse response) {
		qnaBoardService.modifyQnaBoard(request, response);
	}
	
	@PostMapping("/qnaboard/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		qnaBoardService.removeQnaBoard(request, response);
	}
}
