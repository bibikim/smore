package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.smore.domain.free.FreeBoardDTO;

public interface FreeService {

	// 목록
	public void getFreeList(Model model);
	
	// 글 삽입
	public void saveFree(HttpServletRequest request, HttpServletResponse response);
	
	// 이미지 삽입
	public Map<String, Object> savefImage(MultipartHttpServletRequest mRequest);

	// 조회수
	public int increaseHit(int freeNo);
	
	// 상세
	public FreeBoardDTO getFreeByNo(int freeNo);
	
	// 글 수정
	public void modifyFree(HttpServletRequest request, HttpServletResponse response);
	
	// 글 삭제
	public void removeFree(HttpServletRequest request, HttpServletResponse response);
	
	
}
