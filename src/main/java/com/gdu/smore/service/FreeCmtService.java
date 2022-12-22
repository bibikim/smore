package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.gdu.smore.domain.free.FreeCommentDTO;

public interface FreeCmtService {

	// jsp에서 ajax 처리하기 위해 map으로 반환. map으로 반환하면 jackson이 json형태를 map으로 잘 바꿔주니까!
	public Map<String, Object> getCmtCnt(int freeNo);
	public Map<String, Object> saveComment(FreeCommentDTO comment); 
	public Map<String, Object> getCmtList(HttpServletRequest request);  // fNo, page 다 받아오기 위해서 request를 받아옴
	public Map<String, Object> removeComment(int cmtNo);
	public Map<String, Object> editComment(FreeCommentDTO comment);
	public Map<String, Object> saveRecomment(FreeCommentDTO recomment);
	
	
}