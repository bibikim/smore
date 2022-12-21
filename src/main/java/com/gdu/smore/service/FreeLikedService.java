package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface FreeLikedService {
	
	public Map<String, Object> getLikeCheck(HttpServletRequest request);
	public Map<String, Object> getLikeCount(int freeNo);
	public Map<String, Object> mark(HttpServletRequest request);
}
