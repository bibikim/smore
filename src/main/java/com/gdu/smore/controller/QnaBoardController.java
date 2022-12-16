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
import lombok.extern.log4j.Log4j2;
@Log4j2
@Controller
public class QnaBoardController {
	
	@Autowired
	private QnaBoardService qnaBoardService;
	

	@GetMapping("/qna/view/popup")
	public String popup() {
		return "popup/popup";
	}	
	
	//end
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
	
	
	@PostMapping("/qna/save")
	public void save(HttpServletRequest request, HttpServletResponse response) {
		qnaBoardService.saveQnaBoard(request, response);
	}
	
	// end
	@GetMapping("/qna/increse/hit")
	public String increseHit(@RequestParam(value="qNo", required=false, defaultValue="0") int qNo) {
		log.info("qNo =====>" + qNo);
		int result = qnaBoardService.increseQnaBoardHit(qNo);
		log.info("result =====>" + result);
		if(result > 0) {  // 조회수 증가에 성공하면 상세보기로 이동
			return "redirect:/qna/detail?qNo=" + qNo;
		} else {          // 조회수 증가에 실패하면 목록보기로 이동
			return "redirect:/qna/list";
		}
	}
	
	
	@GetMapping("/qna/detail")
	public String detail(@RequestParam(value="qNo", required=false, defaultValue="0") int qNo, Model model) {
		model.addAttribute("question", qnaBoardService.getQnaBoardByNo(qNo));
		return "qna/detail";
	}
	
	@PostMapping("/qna/edit")
	public String edit(int qNo, Model model) {
		model.addAttribute("qnaboard", qnaBoardService.getQnaBoardByNo(qNo));
		return "qna/edit";
	}
	
	
	@PostMapping("/qna/modify")
	public void modify(HttpServletRequest request, HttpServletResponse response) {
		qnaBoardService.modifyQnaBoard(request, response);
	}
	
	@PostMapping("/qna/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		qnaBoardService.removeQnaBoard(request, response);
	}
}
