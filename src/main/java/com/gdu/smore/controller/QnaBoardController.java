package com.gdu.smore.controller;

import java.util.HashMap;
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

import com.gdu.smore.domain.qna.QnaBoardDTO;
import com.gdu.smore.domain.qna.QnaCommentDTO;
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
	public String write(Model model) {
		model.addAttribute("chkBtn", "reg");
		return "qna/write";
	}
	
	@GetMapping("/qna/adm/write")
	public String writeAdm(@RequestParam(value="qaNo", required=false, defaultValue="0") int qaNo,Model model) {
		QnaBoardDTO qb = qnaBoardService.getQnaBoardByNo(qaNo);
		model.addAttribute("chkBtn", "reg");
		model.addAttribute("question", qb);
		return "qna/adm/write";
	}
	
	@GetMapping("/qna/pwPopup")
	public String pwPopup(@RequestParam(value="qaNo", required=false, defaultValue="0") int qaNo, Model model) {
		QnaBoardDTO qb = qnaBoardService.getQnaBoardByNo(qaNo);
		model.addAttribute("question", qb);
		return "qna/pwPop";
	}
	
	@ResponseBody
	@PostMapping("/qna/chkPw")
	public Map<String, Object> chkPw(HttpServletRequest request, HttpServletResponse response) {
		int resultCnt = qnaBoardService.getQnaBoardPw(request, response);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(resultCnt > 0) {
			result.put("resCd", "0000");
			result.put("resMsg", "정상");
		}else {
			result.put("resCd", "9999");
			result.put("resMsg", "실패");
		}
		
		return result;
	}
	
	@PostMapping("/qna/adm/save")
	public void saveAdm(HttpServletRequest request, HttpServletResponse response) {
		qnaBoardService.saveQnaComment(request, response);
	}
	
	@PostMapping("/qna/save")
	public void save(HttpServletRequest request, HttpServletResponse response) {
		qnaBoardService.saveQnaBoard(request, response);
	}
	
	// end
	@GetMapping("/qna/increse/hit")
	public String increseHit(@RequestParam(value="qaNo", required=false, defaultValue="0") int qaNo) {
		log.info("qaNo =====>" + qaNo);
		int result = qnaBoardService.increseQnaBoardHit(qaNo);
		log.info("result =====>" + result);
		if(result > 0) {  // 조회수 증가에 성공하면 상세보기로 이동
			return "redirect:/qna/detail?qaNo=" + qaNo;
		} else {          // 조회수 증가에 실패하면 목록보기로 이동
			return "redirect:/qna/list";
		}
	}
	
	@GetMapping("/qna/detail")
	public String detail(@RequestParam(value="qaNo", required=false, defaultValue="0") int qaNo, @RequestParam(value="cmtNo", required=false, defaultValue="0") int cmtNo, Model model) {
		QnaBoardDTO qb = null;
		QnaCommentDTO qc = null;
		if(cmtNo == 0) {
			qb = qnaBoardService.getQnaBoardByNo(qaNo);
		}else {
			qc = qnaBoardService.getQnaCmtByNo(cmtNo);
		}
		
		model.addAttribute("question", (qb == null) ? qc : qb);
		String returnPage = (qb == null) ? "qna/adm/detail" : "qna/detail";
		return returnPage;
	}
	
	@PostMapping("/qna/adm/edit")
	public String editAdm(@RequestParam(value="qaNo", required=false, defaultValue="0") int qaNo, @RequestParam(value="cmtNo", required=false, defaultValue="0") int cmtNo,Model model) {
		model.addAttribute("question", qnaBoardService.getQnaBoardByNo(qaNo));
		model.addAttribute("comment", qnaBoardService.getQnaCmtByNo(cmtNo));
		model.addAttribute("chkBtn", "mod");
		return "qna/adm/write";
	}
	
	@PostMapping("/qna/edit")
	public String edit(@RequestParam(value="qaNo", required=false, defaultValue="0") int qaNo, Model model) {
		model.addAttribute("question", qnaBoardService.getQnaBoardByNo(qaNo));
		model.addAttribute("chkBtn", "mod");
		return "qna/write";
	}
	
	
	@PostMapping("/qna/modify")
	public void modify(HttpServletRequest request, HttpServletResponse response) {
		qnaBoardService.modifyQnaBoard(request, response);
	}
	
	@PostMapping("/qna/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		qnaBoardService.removeQnaBoard(request, response);
	}
	@PostMapping("/qna/adm/remove")
	public void removeAdm(HttpServletRequest request, HttpServletResponse response) {
		qnaBoardService.removeQnaComment(request, response);
	}
}
