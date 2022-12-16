package com.gdu.smore.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.gdu.smore.domain.code.CodeBoardDTO;

public interface CodeBoardService {
	
	public void getCodeBoardList(Model model);
	public void saveCodeBoard(HttpServletRequest request, HttpServletResponse response);
	public int increseCodeBoardHit(int cNo);
	public CodeBoardDTO getCodeBoardByNo(int cNo);
	public void modifyCodeBoard(HttpServletRequest request, HttpServletResponse response);
	public void removeCodeBoard(HttpServletRequest request, HttpServletResponse response);
}
