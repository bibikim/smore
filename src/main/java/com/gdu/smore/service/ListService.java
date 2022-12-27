package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface ListService {

	public Map<String, Object> getStudyList(HttpServletRequest request, int page);
	public Map<String, Object> getZzimList(HttpServletRequest request, int page);
	
	public Map<String, Object> removeStudyList(String studylist);
	public Map<String, Object> removeZzimList(String zzimlist);
	
}