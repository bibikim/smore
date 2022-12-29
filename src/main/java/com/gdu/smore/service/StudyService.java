package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.gdu.smore.domain.study.StudyCommentDTO;
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
	
	// jsp에서 ajax 처리하기 위해 map으로 반환. map으로 반환하면 jackson이 json형태를 map으로 잘 바꿔주니까!
	public Map<String, Object> getCmtCnt(int studNo);
	public Map<String, Object> saveComment(StudyCommentDTO comment);
	public Map<String, Object> getCmtList(HttpServletRequest request);  // fNo, page 다 받아오기 위해서 request를 받아옴
	public Map<String, Object> removeComment(int cmtNo);
	public Map<String, Object> saveRecomment(StudyCommentDTO recomment);
	
	public Map<String, Object> getLikeCheck(HttpServletRequest request);
	public Map<String, Object> getLikeCount(int studNo);
	public Map<String, Object> mark(HttpServletRequest request);
}