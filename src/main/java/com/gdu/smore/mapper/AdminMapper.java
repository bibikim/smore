package com.gdu.smore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smore.domain.redbell.GrpRedbellDTO;
import com.gdu.smore.domain.user.RetireUserDTO;
import com.gdu.smore.domain.user.UserDTO;

@Mapper
public interface AdminMapper {
	
	public List<UserDTO> selectUserListByMap(Map<String, Object> map);
	public int selectUserCount();
	public int selectReportUserCount();
	public int deleteUserList(List<String> userNoList);
	public int deleteAccessLog(String id);
	public int insertRetireUser(RetireUserDTO retireUser);
	public UserDTO selectUserByNo(int userNo);
	public List<GrpRedbellDTO> selectReportUserList(Map<String, Object> map);
}