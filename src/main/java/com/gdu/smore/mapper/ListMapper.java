package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.study.StudyGroupDTO;
import com.gdu.smore.domain.study.StudyZzimDTO;
import com.gdu.smore.domain.user.UserDTO;

@Mapper
public interface ListMapper {

	public int selectStudyListCount(Map<String, Object> map);
	public List<StudyGroupDTO> selectStudyListByMap(Map<String, Object> map);
	public int deleteStudyList(List<String> studylist);
	
	public int selectZzimListCount();
	public List<StudyZzimDTO> selectZzimListByMap(Map<String, Object> map);
	public int deleteZzimList(List<String> zzimlist);
	
}