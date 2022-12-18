package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import com.gdu.smore.domain.code.CodeBoardDTO;
import com.gdu.smore.domain.code.CodeImageDTO;

public interface CodeBoardMapper {
	
	public int selectCodeBoardListCount();
	public int insertCodeBoard(CodeBoardDTO codeboard);
	public int updateHit(int coNo);
	public CodeBoardDTO selectCodeBoardByNo(int coNo);
	public int updateCodeBoard(CodeBoardDTO codeboard);
	public int deleteCodeBoard(int coNo);
	public int insertImage(CodeImageDTO image);
	public List<CodeBoardDTO> selectCodeBoardListByMap(Map<String, Object> map);
}