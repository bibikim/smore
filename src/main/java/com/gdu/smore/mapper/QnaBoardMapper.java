package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import com.gdu.smore.domain.qna.QnaBoardDTO;
import com.gdu.smore.domain.qna.QnaCommentDTO;

public interface QnaBoardMapper {
	
	public int selectQnaBoardListCount();
	public int insertQnaBoard(QnaBoardDTO qnaboard);
	public int insertQnaComment(QnaCommentDTO qnacomment);
	public int selectQnaBoardPwCount(QnaBoardDTO qnaboard);
	public int updateHit(int qaNo);
	public QnaBoardDTO selectQnaBoardByNo(int qaNo);
	public QnaCommentDTO selectQnaCmtByNo(int cmtNo);
	public int updateQnaBoard(QnaBoardDTO qnaboard);
	public int updateAnswer(QnaBoardDTO qnaboard);
	public int deleteQnaBoard(int qaNo);
	public int deleteQnaComment(int cmtNo);
	public List<QnaBoardDTO> selectQnaBoardListByMap(Map<String, Object> map);
}
