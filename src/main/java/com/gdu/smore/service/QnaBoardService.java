package com.gdu.smore.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.gdu.smore.domain.qna.QnaBoardDTO;
import com.gdu.smore.domain.qna.QnaCommentDTO;

public interface QnaBoardService {
	

	public void getQnaBoardList(Model model);
	public int getQnaBoardPw(HttpServletRequest request, HttpServletResponse response);
	public void saveQnaBoard(HttpServletRequest request, HttpServletResponse response);
	public void saveQnaComment(HttpServletRequest request, HttpServletResponse response);
	public int increseQnaBoardHit(int qaNo);
	public QnaBoardDTO getQnaBoardByNo(int qaNo);
	public QnaCommentDTO getQnaCmtByNo(int cmtNo);
	public void modifyQnaBoard(HttpServletRequest request, HttpServletResponse response);
	public void removeQnaBoard(HttpServletRequest request, HttpServletResponse response);
	public void removeQnaComment(HttpServletRequest request, HttpServletResponse response);
}
