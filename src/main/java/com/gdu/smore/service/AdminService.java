package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface AdminService {
	// 유저 리스트
	public Map<String, Object> getAllUserList(int page);
	public Map<String, Object> getCommonUserList(int page);
	public Map<String, Object> getSleepUserList(int page);
	public Map<String, Object> getreportUserList(int page);
	
	// 유저 검색
	public Map<String, Object> findUsers(HttpServletRequest request, int page);
	
	// 게시판 검색
	public Map<String, Object> findFreeBoard(HttpServletRequest request, int page);
	
	// 게시판 리스트
	public Map<String, Object> getFreeBoardList(int page);
	public Map<String, Object> getStudyList(int page);
	public Map<String, Object> getCodeList(int page);
	public Map<String, Object> getQnaList(int page);
	
	// 일반유저 삭제
	public Map<String, Object> removeUserList(String userNoList);
	
	// 휴면유저에서 일반유저 전환
	public Map<String, Object> toCommonUserList(String userNoList);
	
	// 자유게시판 삭제
	public Map<String, Object> removeStudList(String studNoList);
	public Map<String, Object> removeFreeList(String freeNoList);
	public Map<String, Object> removeCodeList(String codeNoList);
	public Map<String, Object> removeQnaList(String qnaNoList);
}