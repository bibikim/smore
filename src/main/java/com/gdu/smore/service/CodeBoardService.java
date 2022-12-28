package com.gdu.smore.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.smore.domain.code.CodeBoardDTO;

public interface CodeBoardService {
	
	public void getCodeBoardList(Model model);
	public void saveCodeBoard(MultipartHttpServletRequest request, HttpServletResponse response);
	public Map<String, Object> savecImage(MultipartHttpServletRequest mRequest);
	public int increseCodeBoardHit(int coNo);
	public CodeBoardDTO getCodeBoardByNo(int coNo);
	public void modifyCodeBoard(HttpServletRequest request, HttpServletResponse response);
	public void removeCodeBoard(HttpServletRequest request, HttpServletResponse response);
	
	public ResponseEntity<Resource> download(String userAgent, int attachNo);
	public ResponseEntity<Resource> downloadAll(String userAgent, int coNo);
	
	public void getUploadByNo(int coNo, Model model);
}
