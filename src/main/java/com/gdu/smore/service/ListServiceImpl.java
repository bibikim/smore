package com.gdu.smore.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdu.smore.mapper.ListMapper;
import com.gdu.smore.util.PageUtil;


@Service
public class ListServiceImpl implements ListService {

	@Autowired
	private ListMapper listMapper;
	
	@Autowired
	private PageUtil pageUtil;
	
	@Override
	public Map<String, Object> getStudyList(int page) {
		int totalRecord = listMapper.selectStudyListCount();
		pageUtil.setPageUtil(page, totalRecord);
		
		Map<String, Object> map = new HashMap<>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
	    Map<String, Object> result = new HashMap<String, Object>();
	    result.put("studylist", listMapper.selectStudyListByMap(map));
		result.put("PageUtil", pageUtil);
		
		return result;
	}
	
	@Override
	public Map<String, Object> getZzimList(int page) {
		int totalRecord = listMapper.selectZzimListCount();
		pageUtil.setPageUtil(page, totalRecord);
		
		Map<String, Object> map = new HashMap<>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
	    Map<String, Object> result = new HashMap<String, Object>();
	    result.put("studylist", listMapper.selectZzimListByMap(map));
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