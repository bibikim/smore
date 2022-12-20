package com.gdu.smore.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.user.RetireUserDTO;
import com.gdu.smore.domain.user.SleepUserDTO;
import com.gdu.smore.domain.user.UserDTO;

@Mapper
public interface UserMapper {
	public UserDTO selectUserByMap(Map<String, Object> map);
	public RetireUserDTO selectRetireUserById(String id);
	public int insertUser(UserDTO user);
	
	// 네아로
	public int insertNaverUser(UserDTO user);
	
	public int updateAccessLog(String id);
	public int insertAccessLog(String id);
	
	// 로그인 유지
	public int updateSessionInfo(UserDTO user);
	
	// 마이페이지 수정
	public int updateUserPassword(UserDTO user);
	public int updateUserInfo(UserDTO user);
	
	// 탈퇴
	public int deleteUser(int userNo);
	public int insertRetireUser(RetireUserDTO retireUser);

	// 휴면
	public int insertSleepUser();
	public int deleteUserForSleep();
	public SleepUserDTO selectSleepUserById(String id);
	public int insertRestoreUser(String id);
	public int deleteSleepUser(String id);
	
	// 네이버 로그인
	// public int insertNaverUser(UserDTO user);
	
}