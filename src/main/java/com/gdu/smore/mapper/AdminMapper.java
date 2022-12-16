package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.free.FreeBoardDTO;
import com.gdu.smore.domain.redbell.GrpRedbellDTO;
import com.gdu.smore.domain.study.StudyGroupDTO;
import com.gdu.smore.domain.user.RetireUserDTO;
import com.gdu.smore.domain.user.SleepUserDTO;
import com.gdu.smore.domain.user.UserDTO;

@Mapper
public interface AdminMapper {
	
	// 유저 리스트
	public List<UserDTO> selectUserListByMap(Map<String, Object> map);
	public List<SleepUserDTO> selectSleepUserListByMap(Map<String, Object> map);
	
	// 게시판 리스트
	public List<FreeBoardDTO> selectFreeListByMap(Map<String, Object> map);
	public List<StudyGroupDTO> selectStudyListByMap(Map<String, Object> map);
	
	// 유저 카운트
	public int selectUserCount();
	public int selectSleepUserCount();
	public int selectReportUserCount();
	
	// 게시판 카운트
	public int selectFreeBoardCount();
	public int selectSGroupBoardCount();
	
	public int deleteUserList(List<String> userNoList);
	public int deleteAccessLog(String id);
	public int insertRetireUser(RetireUserDTO retireUser);
	public UserDTO selectUserByNo(int userNo);
	public List<GrpRedbellDTO> selectReportUserList(Map<String, Object> map);
}