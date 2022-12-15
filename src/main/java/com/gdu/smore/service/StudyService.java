package com.gdu.smore.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface StudyService {
	public void getStudyList(HttpServletRequest request, Model model);
	public void saveStudy(HttpServletRequest request, HttpServletResponse response);
	/*
	public int increseStudyHit(int sNo);
	*/
}