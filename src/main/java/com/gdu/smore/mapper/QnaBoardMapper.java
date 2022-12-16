package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import com.gdu.smore.domain.qna.QnaBoardDTO;

public interface QnaBoardMapper {
	
	public int selectQnaBoardListCount();
	public int insertQnaBoard(QnaBoardDTO qnaboard);
	public int updateHit(int qNo);
	public QnaBoardDTO selectQnaBoardByNo(int qNo);
	public int updateQnaBoard(QnaBoardDTO qnaboard);
	public int deleteQnaBoard(int qNo);
	public List<QnaBoardDTO> selectQnaBoardListByMap(Map<String, Object> map);
}
