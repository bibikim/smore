package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.free.FreeCommentDTO;
import com.gdu.smore.domain.study.StudyCommentDTO;
import com.gdu.smore.domain.study.StudyGroupDTO;

@Mapper
public interface StudyMapper {
	public int selectAllBoardCnt();
	public List<StudyGroupDTO> selectAllList(Map<String, Object> map); 
	public int insertStudy(StudyGroupDTO study);
	public int updateHit(int studNo);
	public StudyGroupDTO selectStudyByNo(int studNo);
	public int updateStudy(StudyGroupDTO study);

	public int deleteStudy(int studNo);
	
	public List<StudyGroupDTO> selectStudyScroll(Map<String, Object> map);
	public List<StudyGroupDTO> selectStudyPaging(Map<String, Object> map);

	// 댓글
	
	public int selectCommentCount(int studNo);
	public List<StudyCommentDTO> selectCommentList(Map<String, Object> map);
	public int insertComment(StudyCommentDTO scomment);
	public int deleteComment(int cmtNo);  // 댓글 삭제는 update로
	public int insertRecomment(StudyCommentDTO recomment);
	public int updateGroupNo(StudyCommentDTO recomment);

	public int selectNickZCount(Map<String, Object> map);
	public int selectStudZCount(int studNo);
	public int insertZ(Map<String, Object> map);
	public int deleteZ(Map<String, Object> map);
}