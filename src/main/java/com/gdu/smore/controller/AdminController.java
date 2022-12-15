package com.gdu.smore.controller;


import java.util.Map;
import java.util.Optional;

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
	public Map<String, Object>  deleteUser(@PathVariable String userNoList){
		return adminService.removeUserList(userNoList);
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
	
}
