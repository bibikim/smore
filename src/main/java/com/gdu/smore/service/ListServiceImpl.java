package com.gdu.smore.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
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
		map.put("end", pageUtil.getEnd());
		
        HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		String nickname = loginUser.getNickname();
		map.put("nickname", nickname);
		
		int totalRecord = listMapper.selectStudyListCount(map);
		pageUtil.setPageUtil(page, totalRecord);
		
	    Map<String, Object> result = new HashMap<String, Object>();
	    result.put("studylist", listMapper.selectStudyListByMap(map));
	    System.out.println(result);
		result.put("PageUtil", pageUtil);
		return result;
	}
	
	@Override
	public Map<String, Object> getZzimList(HttpServletRequest request, int page) {
		int totalRecord = listMapper.selectZzimListCount();
		pageUtil.setPageUtil(page, totalRecord);
		
        HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		String nickname = loginUser.getNickname();
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		map.put("nickname", nickname);
		
	    Map<String, Object> result = new HashMap<String, Object>();
	    result.put("zzimlist", listMapper.selectZzimListByMap(map));
	    System.out.println(result);
		result.put("PageUtil", pageUtil);
		
		return result;
	}
	
	@Override
	public Map<String, Object> removeStudyList(String studylist) {
		List<String> list = Arrays.asList(studylist.split(","));
		System.out.println(list);
		Map<String, Object> result = new HashMap<>();
		result.put("deleteResult", listMapper.deleteStudyList(list));
		System.out.println("결과: " + result);
		return result;
	}
	
	@Override
	public Map<String, Object> removeZzimList(String zzimlist) {
		List<String> list = Arrays.asList(zzimlist.split(","));
		System.out.println(list);
		Map<String, Object> result = new HashMap<>();
		result.put("deleteResult", listMapper.deleteZzimList(list));
		System.out.println("결과: " + result);
		return result;
	}
   
}