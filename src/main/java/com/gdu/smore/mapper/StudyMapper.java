package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.study.StudyGroupDTO;

@Mapper
public interface StudyMapper {
	public int selectAllBoardCnt();
	public List<StudyGroupDTO> selectAllList(Map<String, Object> map); 
	public int insertStudy(StudyGroupDTO study);
	public int updateHit(int SNo);
	public StudyGroupDTO selectStudyByNo(int SNo);
	public int updateStudy(StudyGroupDTO study);

	public int deleteStudy(int SNo);

}