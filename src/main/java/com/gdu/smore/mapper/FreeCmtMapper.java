package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.free.FreeCommentDTO;

@Mapper
public interface FreeCmtMapper {

	public int selectCommentCnt(int freeNo);   // 해당 게시글 카운트를 가져와야 하니까 fno을 파라미터로 받아와야함
	public List<FreeCommentDTO> selectCommentList(Map<String, Object> map);
	public int insertFreecmt(FreeCommentDTO fcmt);
	public int deleteComment(int cmtNo);  // 댓글 삭제는 update로
	public int modifyComment(FreeCommentDTO comment);
	public int insertRecomment(FreeCommentDTO recomment);
	
	
	public int updateGroupNo(FreeCommentDTO recomment);
}
