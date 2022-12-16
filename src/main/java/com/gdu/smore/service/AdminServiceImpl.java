package com.gdu.smore.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

import com.gdu.smore.domain.user.RetireUserDTO;
import com.gdu.smore.domain.user.UserDTO;
import com.gdu.smore.mapper.AdminMapper;
import com.gdu.smore.mapper.FreeMapper;
import com.gdu.smore.util.PageUtil;

@PropertySource(value = {"classpath:application.yml"})
@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private PageUtil pageUtil;
	
	@Override
	public Map<String, Object> getUserList(int page) {
		
		int totalRecord = adminMapper.selectUserCount();
		pageUtil.setPageUtil(page, totalRecord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("userList", adminMapper.selectUserListByMap(map));
		result.put("pageUtil", pageUtil);
		return result;
	}
	
	@Override
	public Map<String, Object> removeUserList(String userNoList) {
		List<String> list = Arrays.asList(userNoList.split(","));
		for(int i = 0; i < list.size(); i++) {
			UserDTO userDTO =adminMapper.selectUserByNo(Integer.parseInt(list.get(i)));
			
			RetireUserDTO retireUserDTO = new RetireUserDTO();
			retireUserDTO.setUserNo(userDTO.getUserNo());
			retireUserDTO.setId(userDTO.getId());
			retireUserDTO.setJoinDate(userDTO.getJoinDate());
			adminMapper.insertRetireUser(retireUserDTO);
		}
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("deleteResult", adminMapper.deleteUserList(list));
		return result;
	}

	@Override
	public Map<String, Object> getreportUserList(int page) {
		int totalRecord = adminMapper.selectReportUserCount();
		pageUtil.setPageUtil(page, totalRecord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("reportUserList", adminMapper.selectReportUserList(map));
		System.out.println(result);
		result.put("pageUtil", pageUtil);
		return result;
	}
	
	@Override
	public Map<String, Object> getSleepUserList(int page) {
		
		int totalRecord = adminMapper.selectSleepUserCount();
		pageUtil.setPageUtil(page, totalRecord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("sleepuserList", adminMapper.selectSleepUserListByMap(map));
		result.put("pageUtil", pageUtil);
		return result;
	}
	
	@Override
	public Map<String, Object> getFreeBoardList(int page) {
		
		int totalRecord = adminMapper.selectFreeBoardCount();
		pageUtil.setPageUtil(page, totalRecord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("freeBoardList", adminMapper.selectFreeListByMap(map));
		System.out.println(result);
		result.put("pageUtil", pageUtil);
		return result;
		
	}
	
	@Override
	public Map<String, Object> getStudyList(int page) {
		
		int totalRecord = adminMapper.selectSGroupBoardCount();
		pageUtil.setPageUtil(page, totalRecord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("studyList", adminMapper.selectStudyListByMap(map));
		System.out.println(result);
		result.put("pageUtil", pageUtil);
		return result;
	}
}
