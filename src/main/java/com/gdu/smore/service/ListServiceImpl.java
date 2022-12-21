package com.gdu.smore.service;

import java.util.HashMap;
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
	public Map<String, Object> getMyList(int page) {

		int totalRecord = listMapper.selectMyListCount();
		pageUtil.setPageUtil(page, totalRecord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("studyList", listMapper.selectMyList(map));
		result.put("zzimList", listMapper.selectZList(map));
		result.put("pageUtil", pageUtil);
		return result;
	}
   
}