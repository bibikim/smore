package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.study.StudyGroupDTO;
import com.gdu.smore.domain.study.StudyZzimDTO;

@Mapper
public interface ListMapper {

	public int selectMyListCount();
	public List<StudyGroupDTO> selectMyList(Map<String, Object> map);
	public int selectZCount();
	public List<StudyZzimDTO> selectZList(Map<String, Object> map);
	
}