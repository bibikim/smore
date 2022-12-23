package com.gdu.smore.service;

import java.util.Map;

import org.springframework.ui.Model;

public interface ListService {

	public Map<String, Object> getStudyList(int page, Model model);
	public Map<String, Object> getZzimList(int page, Model model);
	
	public Map<String, Object> removeStudyList(String studylist);
	public Map<String, Object> removeZzimList(String zzimlist);
	
}