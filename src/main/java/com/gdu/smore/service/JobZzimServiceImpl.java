package com.gdu.smore.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdu.smore.mapper.JobZzimMapper;

@Service
public class JobZzimServiceImpl implements JobZzimService{

	@Autowired
	private JobZzimMapper zzimMapper;
	
	@Override
	public Map<String, Object> getScrapCheck(HttpServletRequest request) {
		
		int jobNo = Integer.parseInt(request.getParameter("jobNo"));
		String nickname = request.getParameter("nickname");

		Map<String, Object> map = new HashMap<>();
		map.put("jobNo", jobNo);
		map.put("nickname", nickname);
		Map<String, Object> result = new HashMap<>();
		// dto에 있는 애들이면 반환타입이 dto면 되는데 jobNo와 nickname을 필요러하는 매퍼메소드를 행한 후에
		// 그 값을 또다른 Map인 result에 담아서 return 해야하기 때문에 반환타입이 Map
		result.put("count", zzimMapper.selectUserZzimCnt(map));
		
		return result;
	}
	
	@Override
	public Map<String, Object> getScrapCount(int jobNo) {
		
		Map<String, Object> result = new HashMap<>();
		result.put("count", zzimMapper.selectJobZzimCnt(jobNo));
		return result;
	}
	
	@Override
	public Map<String, Object> markScrap(HttpServletRequest request) {
		int jobNo = Integer.parseInt(request.getParameter("jobNo"));
		String nickname = request.getParameter("nickname");
		
		Map<String, Object> map = new HashMap<>();
		map.put("jobNo", jobNo);
		map.put("nickname", nickname);
		Map<String, Object> result = new HashMap<>();
		if(zzimMapper.selectUserZzimCnt(map) == 0) {
			result.put("isScrap", zzimMapper.insertScrap(map) == 1);
		} else {
			result.put("isScrap", zzimMapper.deleteScrap(map) == 1);
		}
		return result;
	}
}
