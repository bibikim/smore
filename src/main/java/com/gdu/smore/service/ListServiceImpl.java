package com.gdu.smore.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdu.smore.domain.user.UserDTO;
import com.gdu.smore.mapper.ListMapper;
import com.gdu.smore.util.PageUtil;


@Service
public class ListServiceImpl implements ListService {

	@Autowired
	private ListMapper listMapper;
	
	@Autowired
	private PageUtil pageUtil;
	
	@Override
	public Map<String, Object> getStudyList(HttpServletRequest request,int page) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
        HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		String nickname = loginUser.getNickname();
		map.put("nickname", nickname);
		
		int totalRecord = listMapper.selectStudyListCount(map);
		pageUtil.setPageUtil(page, totalRecord);
		
	    Map<String, Object> result = new HashMap<String, Object>();
	    result.put("studylist", listMapper.selectStudyListByMap(map));
		result.put("PageUtil", pageUtil);
		
		return result;
	}
	
	@Override
	public Map<String, Object> getZzimList(HttpServletRequest request, int page) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
        HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		String nickname = loginUser.getNickname();
		map.put("nickname", nickname);
		
		int totalRecord = listMapper.selectZzimListCount(map);
		pageUtil.setPageUtil(page, totalRecord);
		
	    Map<String, Object> result = new HashMap<String, Object>();
	    result.put("zzimlist", listMapper.selectZzimListByMap(map));
		result.put("PageUtil", pageUtil);
		
		return result;
	}
	
}