package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import com.gdu.smore.domain.code.CodeAttachDTO;
import com.gdu.smore.domain.code.CodeBoardDTO;
import com.gdu.smore.domain.code.CodeImageDTO;

public interface CodeBoardMapper {
	
	public int selectListCount();
	public List<CodeBoardDTO> selectCodeBoardListByMap(Map<String, Object> map);
	public int insertCodeBoard(CodeBoardDTO codeboard);
	public int insertImage(CodeImageDTO cimage);
	
	public CodeBoardDTO selectCodeBoardByNo(int coNo);
	public List<CodeImageDTO> selectCodeImageListInCode(int coNo);
	public List<CodeImageDTO> selectAllCoardImageList();
	public int updateHit(int coNo);
	public int deleteCodeImage(String filesystem);
	public CodeAttachDTO selectAttachByNo(int attachNo);
	public int updateDownloadCnt(int attachNo);
	public List<CodeAttachDTO> selectAttachList(int coNo);
	public int updateCodeBoard(CodeBoardDTO codeboard);
	public int deleteCodeBoard(int coNo);
	public int insertAttach(CodeAttachDTO attach);
}
