package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.free.FreeBoardDTO;
import com.gdu.smore.domain.free.FreeImageDTO;

@Mapper
public interface FreeMapper {

	public int selectListCount();
	public List<FreeBoardDTO> selectFreeListByMap(Map<String, Object> map);
	public int insertFree(FreeBoardDTO free);
	public int insertImage(FreeImageDTO fimage);
	public int updateHit(int fNo);
	
	// 상세
	public FreeBoardDTO selectFreeByNo(int fNo);
	public List<FreeImageDTO> selectFreeImageListInFree(int fNo);
	public List<FreeImageDTO> selectAllFreeImageList();
}
