package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.gdu.smore.domain.study.StudyGroupDTO;

public interface StudyService {
	// 스터디 모집
	public void getStudyList(HttpServletRequest request, Model model);
	public void saveStudy(HttpServletRequest request, HttpServletResponse response);
	public StudyGroupDTO getStudyByNo(int studNo);
	public int increseStudyHit(int studNo);

	public void modifyStudy(HttpServletRequest request, HttpServletResponse response);
	public void removeStudy(HttpServletRequest request, HttpServletResponse response);
	
	public Map<String, Object> getStudyScroll(HttpServletRequest request, Model model);
	
	// 댓글
	public Map<String, Object> getCommentCount(int studNo);
	public Map<String, Object> addComment(HttpServletRequest request);
	public Map<String, Object> getCommentList(HttpServletRequest request);

	public Map<String, Object> getZCheck(HttpServletRequest request);
	public Map<String, Object> getZCount(int studNo);
	public Map<String, Object> mark(HttpServletRequest request);
}