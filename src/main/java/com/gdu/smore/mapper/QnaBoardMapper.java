package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import com.gdu.smore.domain.qna.QnaBoardDTO;

public interface QnaBoardMapper {
	
	public int selectQnaBoardListCount();
	public int insertQnaBoard(QnaBoardDTO qnaboard);
	public int updateHit(int qaNo);
	public QnaBoardDTO selectQnaBoardByNo(int qaNo);
	public int updateQnaBoard(QnaBoardDTO qnaboard);
	public int deleteQnaBoard(int qaNo);
	public List<QnaBoardDTO> selectQnaBoardListByMap(Map<String, Object> map);
}
