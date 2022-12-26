package com.gdu.smore.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.HTTP;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdu.smore.service.JobsService;

@Controller
public class JobsController {

	@Autowired
	private JobsService jobService;
	
	@GetMapping("/job/list")
	public String jobsList(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		jobService.getJobsList(request, model);
		return "jobs/list";
	}
	
	@GetMapping("/job/write")
	public String write() {
		return "jobs/write";
	}
	
	@PostMapping("/job/save")
	public void saveJob(HttpServletRequest request, HttpServletResponse response) {
		jobService.saveJobs(request, response);
	}
	
	@GetMapping("/job/increase/hit")
	public String increaseHit(@RequestParam(value="jobNo", required=false, defaultValue="0") int jobNo) {
		
		int result = jobService.increaseHit(jobNo);
		if(result > 0) {
			return "redirect:/job/detail?jobNo=" + jobNo;
		} else {
			return "redirect:/job/list";
		}
	}

	@GetMapping("/job/detail")
	public String detailJob(@RequestParam(value="jobNo", required=false, defaultValue="0") int jobNo, Model model) {
		model.addAttribute("job", jobService.getJobsByNo(jobNo));
		return "jobs/detail";
	}
	
	@PostMapping("/job/edit")
	public String editJob(int jobNo, Model model) {
		model.addAttribute("job", jobService.getJobsByNo(jobNo));
		return "jobs/edit";
	}
		
	
	@PostMapping("/job/modify")
	public void modifyJob(HttpServletRequest request, HttpServletResponse response) {
		jobService.editJobs(request, response);
	}

}