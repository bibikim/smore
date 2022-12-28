package com.gdu.smore.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface JobZzimMapper {

	public int selectUserZzimCnt(Map<String, Object> map);
	public int selectJobZzimCnt(int jobNo);
	public int insertScrap(Map<String, Object> map);
	public int deleteScrap(Map<String, Object> map);
	
	
	
}
