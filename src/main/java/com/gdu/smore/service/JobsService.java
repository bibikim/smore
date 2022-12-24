package com.gdu.smore.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.gdu.smore.domain.jobs.JobsDTO;

public interface JobsService {
	
	// 목록
	public void getJobsList(HttpServletRequest request, Model model);
	
	// 상세
	public JobsDTO getJobsByNo(int jobNo);
	
	// 글 삽입
	public void saveJobs(HttpServletRequest request, HttpServletResponse response);
	
	// 조회수
	public int increaseHit(int jobNo);
	
	// 글 수정
	public void editJobs(HttpServletRequest request, HttpServletResponse response);
	
	// 글 삭제
	public void removeJobs(HttpServletRequest reuqest, HttpServletResponse response);
}
