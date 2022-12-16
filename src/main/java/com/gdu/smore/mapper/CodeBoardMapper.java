package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import com.gdu.smore.domain.code.CodeBoardDTO;

public interface CodeBoardMapper {
	
	public int selectCodeBoardListCount();
	public int insertCodeBoard(CodeBoardDTO codeboard);
	public int updateHit(int cNo);
	public CodeBoardDTO selectCodeBoardByNo(int cNo);
	public int updateCodeBoard(CodeBoardDTO codeboard);
	public int deleteCodeBoard(int cNo);
	public List<CodeBoardDTO> selectCodeBoardListByMap(Map<String, Object> map);
}
