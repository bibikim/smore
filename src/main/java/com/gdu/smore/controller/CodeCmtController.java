package com.gdu.smore.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.smore.domain.code.CodeCommentDTO;
import com.gdu.smore.service.CodeCmtService;

@Controller
public class CodeCmtController {

	@Autowired
	private CodeCmtService cmtService;

	@ResponseBody
	@GetMapping(value = "/code/comment/getcnt", produces = "application/json")
	public Map<String, Object> getCnt(@RequestParam("coNo") int coNo) {
		return cmtService.getCmtCnt(coNo);
	}

	@ResponseBody
	@GetMapping(value = "/code/comment/list", produces = "application/json")
	public Map<String, Object> cmtList(HttpServletRequest request) {
		return cmtService.getCmtList(request);
	}

	@ResponseBody
	@PostMapping(value = "/code/comment/add", produces = "application/json")
	public Map<String, Object> saveCmt(CodeCommentDTO comment) {
		return cmtService.saveComment(comment);
	}

	// 댓글 수정
	 @ResponseBody
	 @PostMapping(value="/code/comment/edit", produces="application/json") 
	 public Map<String, Object> editCmt(CodeCommentDTO comment) { 
		 return cmtService.editComment(comment); 
	}
	 
	 
	@ResponseBody
	@PostMapping(value = "/code/comment/remove", produces = "application/json")
	public Map<String, Object> removeCmt(@RequestParam("cmtNo") int cmtNo) {
		return cmtService.removeComment(cmtNo);
	}

	@ResponseBody
	@PostMapping(value = "/code/comment/reply/save", produces = "application/json")
	public Map<String, Object> saveRecmt(CodeCommentDTO recomment) {
		return cmtService.saveRecomment(recomment);
	}

}
