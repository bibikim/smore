package com.gdu.smore.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.smore.service.CodeBoardService;

@Controller
public class CodeBoardController {
	
	@Autowired
	private CodeBoardService codeBoardService;
	
	
	
	@GetMapping("/code/list")
	public String codeBoardlist(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);  // model에 request를 저장하기
		codeBoardService.getCodeBoardList(model);          // model만 넘기지만 이미 model에는 request가 들어 있음
		return "code/list";
	}
	
	

	@GetMapping("/code/write")
	public String write() {
		return "code/write";
	}
	
	@ResponseBody
	@PostMapping(value="/code/uploadImage", produces="application/json")
	public Map<String, Object> uploadImage(MultipartHttpServletRequest mRequest) {
		// 방금 jsp에서 보낸 file을 서비스로 전달
		return codeBoardService.savecImage(mRequest);
	}
	
	@PostMapping("/code/save")
	public void saveCodeBoard(MultipartHttpServletRequest request, HttpServletResponse response) {
		codeBoardService.saveCodeBoard(request, response);
	}
	
	
	@GetMapping("/code/increase/hit")
	public String increaseHit(@RequestParam(value="coNo", required=false, defaultValue="0") int coNo) {
		int result = codeBoardService.increseCodeBoardHit(coNo);
		if(result > 0) {
			return "redirect:/code/detail?coNo=" + coNo;
		} else {
			return "redirect:/code/list";
		}
	}
	
	@GetMapping("/code/detail")

	public String detailCodeBoard(@RequestParam(value="coNo", required=false, defaultValue="0") int coNo, Model model) {
		model.addAttribute("code", codeBoardService.getCodeBoardByNo(coNo));
		codeBoardService.getUploadByNo(coNo, model);
		return "code/detail";
	}
	
	@PostMapping("/code/modify")
	public void modifyCodeBoard(HttpServletRequest request, HttpServletResponse response) {
		codeBoardService.modifyCodeBoard(request, response);
	}
	
	@PostMapping("/code/edit")
	public String editCodeBoard(int coNo, Model model) {
		model.addAttribute("code", codeBoardService.getCodeBoardByNo(coNo));
		return "/code/edit";
	}
	
	
	@PostMapping("/code/remove")
	public void removeCodeBoard(HttpServletRequest request, HttpServletResponse response) {
		codeBoardService.removeCodeBoard(request, response);
	}
	

	@ResponseBody
	@GetMapping("/upload/download")
	public ResponseEntity<Resource> download(@RequestHeader("User-Agent") String userAgent, @RequestParam("attachNo") int attachNo){
		return codeBoardService.download(userAgent, attachNo);
	}
	
	@GetMapping("/upload/downloadAll")
	public ResponseEntity<Resource> downloadAll(@RequestHeader("User-Agent") String userAgent, @RequestParam("coNo") int coNo){
		return codeBoardService.downloadAll(userAgent, coNo);
	}
}
