package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.AllBoardDTO;
import com.gdu.smore.domain.code.CodeBoardDTO;
import com.gdu.smore.domain.free.FreeBoardDTO;
import com.gdu.smore.domain.qna.QnaBoardDTO;
import com.gdu.smore.domain.redbell.GrpRedbellDTO;
import com.gdu.smore.domain.study.StudyGroupDTO;
import com.gdu.smore.domain.user.AllUserDTO;
import com.gdu.smore.domain.user.RetireUserDTO;
import com.gdu.smore.domain.user.SleepUserDTO;
import com.gdu.smore.domain.user.UserDTO;

@Mapper
public interface AdminMapper {
	
	// 유저 리스트
	public List<UserDTO> selectAllUserList(Map<String, Object> map);
	public List<UserDTO> selectUserListByMap(Map<String, Object> map);
	public List<SleepUserDTO> selectSleepUserListByMap(Map<String, Object> map);
	
	// 유저 검색
	public List<AllUserDTO> selectUsersByQuery(Map<String, Object> map);
	
	// 모든 유저 검색 카운트
	public int selectAllUserCountByQuery(Map<String, Object> map);
	
	// 게시판검색
	public List<AllBoardDTO> selectFreeBoardByQuery(Map<String, Object> map);
	public List<AllBoardDTO> selectCodeBoardByQuery(Map<String, Object> map);
	public List<AllBoardDTO> selectStudyBoardByQuery(Map<String, Object> map);
	public List<AllBoardDTO> selectQnaBoardByQuery(Map<String, Object> map);
	
	// 게시판 검색 카운트
	public int selectFreeBoardByCountQuery(Map<String, Object> map);
	public int selectCodeBoardByCountQuery(Map<String, Object> map);
	public int selectStudyBoardByCountQuery(Map<String, Object> map);
	public int selectQnaBoardByCountQuery(Map<String, Object> map);
	
	// 게시판 리스트
	public List<FreeBoardDTO> selectFreeListByMap(Map<String, Object> map);
	public List<StudyGroupDTO> selectStudyListByMap(Map<String, Object> map);
	public List<CodeBoardDTO> selectCodeListByMap(Map<String, Object> map);
	public List<QnaBoardDTO> selectQnaListByMap(Map<String, Object> map);
	
	// 유저 카운트
	public int selectUserCount();
	public int selectSleepUserCount();
	public int selectReportUserCount();
			
	// 게시판 카운트
	public int selectFreeBoardCount();
	public int selectSGroupBoardCount();
	public int selectCodeBoardCount();
	public int selectQnaBoardCount(); 
	
	// 일반유저 다중 탈퇴
	public int deleteUserList(List<String> userNoList);
	// 휴면유저 다중 탈퇴
	public int deleteSleepUserList(List<String> userNoList);
	public int updateAccessInfo(String id);
	
	
	/* public int deleteAccessLog(String id); */
	public int insertRetireUser(RetireUserDTO retireUser);
	
	// 자유게시판 다중 삭제
	public int deleteStudyBoardList(List<String> studNoList);
	public int deleteFreeBoardList(List<String> freeNoList);
	public int deleteCodeBoardList(List<String> codeNoList);
	public int deleteQnaBoardList(List<String> qnaNoList);
	
	
	public UserDTO selectUserByNo(int userNo);
	public SleepUserDTO selectSleepUserByNo(int userNo);
	
	public List<GrpRedbellDTO> selectReportUserList(Map<String, Object> map);
}