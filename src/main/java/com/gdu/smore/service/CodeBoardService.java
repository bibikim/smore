package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.smore.domain.code.CodeBoardDTO;

public interface CodeBoardService {
	
	public void getCodeBoardList(Model model);
	public void saveCodeBoard(HttpServletRequest request, HttpServletResponse response);
	public Map<String, Object> savecImage(MultipartHttpServletRequest mRequest);
	public int increseCodeBoardHit(int coNo);
	public CodeBoardDTO getCodeBoardByNo(int coNo);
	public void modifyCodeBoard(HttpServletRequest request, HttpServletResponse response);
	public void removeCodeBoard(HttpServletRequest request, HttpServletResponse response);
	
	
	
}
