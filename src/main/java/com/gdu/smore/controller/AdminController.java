package com.gdu.smore.controller;


import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.gdu.smore.service.AdminService;

@RestController
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	@GetMapping(value="/users/page{page}", produces = "application/json")
	public Map<String, Object> getUserList(@PathVariable(value="page", required = false) Optional<String> opt){
		int page = Integer.parseInt(opt.orElse("1"));
		return adminService.getUserList(page);
	}
	
	@DeleteMapping(value="/users/{userNoList}", produces = "application/json")
	public Map<String, Object> deleteUser(@PathVariable String userNoList){
		return adminService.removeUserList(userNoList);
	}
	
	@DeleteMapping(value="/common/{userNoList}", produces = "application/json")
	public Map<String, Object> transCommon(@PathVariable String userNoList){
		return adminService.toCommonUserList(userNoList);
	}
	
	@DeleteMapping(value="/frees/{boardNoList}", produces = "application/json")
	public Map<String, Object> deleteFree(@PathVariable String boardNoList){
		return adminService.removeFreeList(boardNoList);
	}
	
	@GetMapping(value="/reportUsers/page{page}", produces = "application/json")
	public Map<String, Object> getReportUserList(@PathVariable(value="page", required = false) Optional<String> opt){
		int page = Integer.parseInt(opt.orElse("1"));
		return adminService.getreportUserList(page);
	}
	
	@GetMapping(value="/sleepUsers/page{page}", produces = "application/json")
	public Map<String, Object> getSleepUserList(@PathVariable(value="page", required = false) Optional<String> opt){
		int page = Integer.parseInt(opt.orElse("1"));
		return adminService.getSleepUserList(page);
	}

	
	@GetMapping(value="/freeBoardList/page{page}", produces = "application/json")
	public Map<String, Object> getFreeBoardList(@PathVariable(value="page", required = false) Optional<String> opt){
		int page = Integer.parseInt(opt.orElse("1"));
		return adminService.getFreeBoardList(page);
	}
	
	@GetMapping(value="/studyList/page{page}", produces = "application/json")
	public Map<String, Object> getStudyList(@PathVariable(value="page", required = false) Optional<String> opt){
		int page = Integer.parseInt(opt.orElse("1"));
		return adminService.getStudyList(page);
	}
	
	@GetMapping(value="/codeList/page{page}", produces = "application/json")
	public Map<String, Object> getCodeList(@PathVariable(value="page", required = false) Optional<String> opt){
		int page = Integer.parseInt(opt.orElse("1"));
		return adminService.getCodeList(page);
	}
	
	@GetMapping(value="/qnaList/page{page}", produces = "application/json")
	public Map<String, Object> getQnaList(@PathVariable(value="page", required = false) Optional<String> opt){
		int page = Integer.parseInt(opt.orElse("1"));
		return adminService.getCodeList(page);
	}
	
	@GetMapping(value="/users/search", produces = "application/json")
	public Map<String, Object> search(HttpServletRequest request) {
		return adminService.findUsers(request);
	}


	
	
	
	
}
