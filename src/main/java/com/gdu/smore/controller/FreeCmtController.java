package com.gdu.smore.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.smore.domain.free.FreeCommentDTO;
import com.gdu.smore.service.FreeCmtService;

@Controller
public class FreeCmtController {

	@Autowired
	private FreeCmtService cmtService;

	@ResponseBody
	@GetMapping(value = "/free/comment/getcnt", produces = "application/json")
	public Map<String, Object> getCnt(@RequestParam("freeNo") int freeNo) {
		return cmtService.getCmtCnt(freeNo);
	}

	@ResponseBody
	@GetMapping(value = "/free/comment/list", produces = "application/json")
	public Map<String, Object> cmtList(HttpServletRequest request) {
		return cmtService.getCmtList(request);
	}

	@ResponseBody
	@PostMapping(value = "/free/comment/add", produces = "application/json")
	public Map<String, Object> saveCmt(FreeCommentDTO comment) {
		return cmtService.saveComment(comment);
	}

	// 댓글 수정
	 @ResponseBody
	 @PostMapping(value="/free/comment/edit", produces="application/json") 
	 public Map<String, Object> editCmt(FreeCommentDTO comment) { 
		 return cmtService.editComment(comment); 
	}
	 
	 
	@ResponseBody
	@PostMapping(value = "/free/comment/remove", produces = "application/json")
	public Map<String, Object> removeCmt(@RequestParam("cmtNo") int cmtNo) {
		return cmtService.removeComment(cmtNo);
	}

	@ResponseBody
	@PostMapping(value = "/free/comment/reply/save", produces = "application/json")
	public Map<String, Object> saveRecmt(FreeCommentDTO recomment) {
		return cmtService.saveRecomment(recomment);
	}

}
