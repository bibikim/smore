package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface AdminService {
	// 유저 리스트
	public Map<String, Object> getUserList(int page);
	public Map<String, Object> getSleepUserList(int page);
	public Map<String, Object> getreportUserList(int page);
	
	// 검색
	public Map<String, Object> findUsers(HttpServletRequest request);
	
	// 게시판 리스트
	public Map<String, Object> getFreeBoardList(int page);
	public Map<String, Object> getStudyList(int page);
	public Map<String, Object> getCodeList(int page);
	public Map<String, Object> getQnaList(int page);
	
	// 일반유저 삭제
	public Map<String, Object> removeUserList(String userNoList);
	
	// 휴면유저에서 일반유저 전환
	public Map<String, Object> toCommonUserList(String userNoList);
	
}