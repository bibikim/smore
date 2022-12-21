package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.code.CodeCommentDTO;

@Mapper
public interface CodeCmtMapper {

	public int selectCommentCnt(int coNo);   // 해당 게시글 카운트를 가져와야 하니까 coNo을 파라미터로 받아와야함
	public List<CodeCommentDTO> selectCommentList(Map<String, Object> map);
	public int insertCodecmt(CodeCommentDTO cmt);
	public int deleteComment(int cmtNo);  // 댓글 삭제는 update로
	public int modifyComment(CodeCommentDTO comment);
	public int insertRecomment(CodeCommentDTO recomment);
	
}
