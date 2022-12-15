package com.gdu.smore.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.user.RetireUserDTO;
import com.gdu.smore.domain.user.UserDTO;

@Mapper
public interface UserMapper {
	public UserDTO selectUserByMap(Map<String, Object> map);
	public RetireUserDTO selectRetireUserById(String id);
	public int insertUser(UserDTO user);
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
	
}