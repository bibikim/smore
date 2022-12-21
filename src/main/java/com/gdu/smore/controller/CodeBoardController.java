package com.gdu.smore.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdu.smore.domain.code.CodeBoardDTO;
import com.gdu.smore.service.CodeBoardService;

import lombok.extern.log4j.Log4j2;
@Log4j2
@Controller
public class CodeBoardController {
	
	@Autowired
	private CodeBoardService codeBoardService;
	

	@GetMapping("/code/view/popup")
	public String popup() {
		return "popup/popup";
	}	
	
	//end
	@GetMapping("/code/list")
	public String list(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);  // model에 request를 저장하기
		codeBoardService.getCodeBoardList(model);          // model만 넘기지만 이미 model에는 request가 들어 있음
		return "code/list";
	}
	
	
	@GetMapping("/code/write")
	public String write(Model model) {
		model.addAttribute("chkBtn", "reg");
		return "code/write";
	}
	
	@PostMapping("/code/save")
	public void save(HttpServletRequest request, HttpServletResponse response) {
		codeBoardService.saveCodeBoard(request, response);
	}
	
	// end
	@GetMapping("/code/increse/hit")
	public String increseHit(@RequestParam(value="coNo", required=false, defaultValue="0") int coNo) {
		log.info("coNo =====>" + coNo);
		int result = codeBoardService.increseCodeBoardHit(coNo);
		log.info("result =====>" + result);
		if(result > 0) {  // 조회수 증가에 성공하면 상세보기로 이동
			return "redirect:/code/detail?coNo=" + coNo;
		} else {          // 조회수 증가에 실패하면 목록보기로 이동
			return "redirect:/code/list";
		}
	}
	
	
	@GetMapping("/code/detail")
	public String detail(@RequestParam(value="coNo", required=false, defaultValue="0") int coNo, Model model) {
		CodeBoardDTO cb = codeBoardService.getCodeBoardByNo(coNo);
		model.addAttribute("code", cb);
		return "code/detail";
	}
	
	@PostMapping("/code/edit")
	public String edit(@RequestParam(value="coNo", required=false, defaultValue="0") int coNo, Model model) {
		model.addAttribute("code", codeBoardService.getCodeBoardByNo(coNo));
		model.addAttribute("chkBtn", "mod");
		return "code/write";
	}
	
	@PostMapping("/code/modify")
	public void modify(HttpServletRequest request, HttpServletResponse response) {
		codeBoardService.modifyCodeBoard(request, response);
	}
	
	@PostMapping("/code/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		codeBoardService.removeCodeBoard(request, response);
	}
}
