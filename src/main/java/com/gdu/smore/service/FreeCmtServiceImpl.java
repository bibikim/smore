package com.gdu.smore.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdu.smore.domain.free.FreeCommentDTO;
import com.gdu.smore.mapper.FreeCmtMapper;
import com.gdu.smore.util.PageUtil;


@Service
public class FreeCmtServiceImpl implements FreeCmtService {

	@Autowired
	private FreeCmtMapper cmtMapper;
	
	@Autowired
	private PageUtil pageUtil;
	
	
	@Override
	public Map<String, Object> getCmtCnt(int freeNo) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("commentCnt",  cmtMapper.selectCommentCnt(freeNo));
		
		return result;
	}
	
	@Override
	public Map<String, Object> getCmtList(HttpServletRequest request) {
		
		int freeNo = Integer.parseInt(request.getParameter("freeNo"));
		int page = Integer.parseInt(request.getParameter("page"));
		String ip = request.getRemoteAddr();
		
		int cmtCnt = cmtMapper.selectCommentCnt(freeNo);
		pageUtil.setPageUtil(page, cmtCnt);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("freeNo", freeNo);
		map.put("ip", ip);
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("cmtList", cmtMapper.selectCommentList(map));
		result.put("pageUtil", pageUtil);  // pageUtil은 왜 Map에 넣는걸까?
		
		return result;
	}
	
	
	@Override
	public Map<String, Object> saveComment(FreeCommentDTO comment) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isSave", cmtMapper.insertFreecmt(comment) == 1);
					// insert 결과가 1이면 true, 아니면 false 반환
		return result;
	}
	
	@Override
	public Map<String, Object> editComment(FreeCommentDTO comment) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isEdit", cmtMapper.modifyComment(comment) == 1);
		return result;
	}
	
	@Override
	public Map<String, Object> removeComment(int cmtNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isRemove", cmtMapper.deleteComment(cmtNo) == 1);
		return result;
	}
	
	@Override
	public Map<String, Object> saveRecomment(FreeCommentDTO recomment) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isSave", cmtMapper.insertRecomment(recomment) == 1);
		return result;
	}
	
}
