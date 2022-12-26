package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface CodeLikedService {
	
	public Map<String, Object> getLikeCheck(HttpServletRequest request);
	public Map<String, Object> getLikeCount(int coNo);
	public Map<String, Object> mark(HttpServletRequest request);
}
