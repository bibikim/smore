package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.redbell.GrpRedbellDTO;
import com.gdu.smore.domain.study.StudyGroupDTO;

@Mapper
public interface RedMapper {
	// public int selectAllRedCnt();
	// public List<StudyGroupDTO> selectAllRedList(Map<String, Object> map); 

	public int insertRed(GrpRedbellDTO grpred);
	// public GrpRedbellDTO selectRedByNo(int redNo);

}