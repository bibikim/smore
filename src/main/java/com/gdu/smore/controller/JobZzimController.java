package com.gdu.smore.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.smore.service.JobZzimService;

@Controller
public class JobZzimController {

	@Autowired
	private JobZzimService zzimService;
	
	@ResponseBody
	@GetMapping(value="/job/scrapCheck", produces="application/json")
	public Map<String, Object> getScrapCheck(HttpServletRequest request) {
		return zzimService.getScrapCheck(request);
	}
	
	@GetMapping(value="/job/scrapCount", produces="application/json")
	public Map<String, Object> getScrapCount(int jobNo) {
		return zzimService.getScrapCount(jobNo);
	}
	
	@ResponseBody
	@GetMapping(value="/job/scrap", produces="application/json")
	public Map<String, Object> scrap(HttpServletRequest request) {
		return zzimService.markScrap(request);
	}
	
}
