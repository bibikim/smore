package com.gdu.smore.service;

import java.util.Map;

public interface ListService {

	public Map<String, Object> getStudyList(int page);
	public Map<String, Object> getZzimList(int page);
	
	public Map<String, Object> removeStudyList(String studylist);
	public Map<String, Object> removeZzimList(String zzimlist);
	
}