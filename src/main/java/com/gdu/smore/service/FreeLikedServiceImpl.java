package com.gdu.smore.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdu.smore.mapper.FreeLikedMapper;

@Service
public class FreeLikedServiceImpl implements FreeLikedService{

	@Autowired
	private FreeLikedMapper likeMapper;
	
	@Override
	public Map<String, Object> getLikeCheck(HttpServletRequest request) {
		int freeNo = Integer.parseInt(request.getParameter("freeNo"));
		String nickname = request.getParameter("nickname");
		Map<String, Object> map = new HashMap<>();
		map.put("freeNo", freeNo);
		map.put("nickname", nickname);
		Map<String, Object> result = new HashMap<>();
		result.put("count", likeMapper.selectUserLikeCount(map));
		return result;
	}
	
	@Override
	public Map<String, Object> getLikeCount(int freeNo) {
		Map<String, Object> result = new HashMap<>();
		result.put("count", likeMapper.selectFreeLikeCount(freeNo));
		return result;
	}
	
	@Override
	public Map<String, Object> mark(HttpServletRequest request) {
		int freeNo = Integer.parseInt(request.getParameter("freeNo"));
		String nickname = request.getParameter("nickname");
		Map<String, Object> map = new HashMap<>();
		map.put("freeNo", freeNo);
		map.put("nickname", nickname);
		Map<String, Object> result = new HashMap<>();
		if(likeMapper.selectUserLikeCount(map) == 0) {
			result.put("isSuccess", likeMapper.insertLike(map) == 1);
		} else {
			result.put("isSuccess", likeMapper.deleteLike(map) == 1);
		}
		
		return result;

	}
	
}
