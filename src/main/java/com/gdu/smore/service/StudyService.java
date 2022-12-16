package com.gdu.smore.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.gdu.smore.domain.study.StudyGroupDTO;

public interface StudyService {
	public void getStudyList(HttpServletRequest request, Model model);
	public void saveStudy(HttpServletRequest request, HttpServletResponse response);
	public StudyGroupDTO getStudyByNo(int studNo);
	public int increseStudyHit(int studNo);

	public void modifyStudy(HttpServletRequest request, HttpServletResponse response);
	public void removeStudy(HttpServletRequest request, HttpServletResponse response);


}