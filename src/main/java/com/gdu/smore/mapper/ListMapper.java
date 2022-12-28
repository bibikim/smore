package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.study.StudyGroupDTO;
import com.gdu.smore.domain.study.StudyZzimDTO;

@Mapper
public interface ListMapper {

	public int selectStudyListCount(Map<String, Object> map);
	public List<StudyGroupDTO> selectStudyListByMap(Map<String, Object> map);
	public int deleteStudyList(List<String> studylist);
	
	public int selectZzimListCount(Map<String, Object> map);
	public List<StudyZzimDTO> selectZzimListByMap(Map<String, Object> map);
	public int deleteZzimList(List<String> zzimlist);
	
}