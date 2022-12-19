package com.gdu.smore.service;

import java.util.Map;

public interface AdminService {
	// 유저 리스트
	public Map<String, Object> getUserList(int page);
	public Map<String, Object> getSleepUserList(int page);
	// 게시판 리스트
	public Map<String, Object> getFreeBoardList(int page);
	public Map<String, Object> getStudyList(int page);
	
	public Map<String, Object> removeUserList(String userNoList);
	public Map<String, Object> getreportUserList(int page);
}