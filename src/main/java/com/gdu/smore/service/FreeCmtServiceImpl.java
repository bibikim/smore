package com.gdu.smore.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.gdu.smore.domain.free.FreeCommentDTO;
import com.gdu.smore.domain.user.UserDTO;
import com.gdu.smore.mapper.FreeCmtMapper;
import com.gdu.smore.util.PageUtil;


@Service
public class FreeCmtServiceImpl implements FreeCmtService {

	@Autowired
	private FreeCmtMapper cmtMapper;
	
	@Autowired
	private PageUtil pageUtil;
	
	
	@Override
	public Map<String, Object> getCmtCnt(int freeNo) {   // 반환용 map
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("commentCnt",  cmtMapper.selectCommentCnt(freeNo));  // 키, 값 
		
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
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("cmtList", cmtMapper.selectCommentList(map));
		result.put("pageUtil", pageUtil);  // pageUtil은 왜 Map에 넣는걸까?
		
		return result;
	}
	
	@Transactional
	@Override
	public Map<String, Object> saveComment(FreeCommentDTO comment) {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		 
		 int groupNo = Integer.parseInt(request.getParameter("groupNo"));
		 comment.setGroupNo(groupNo);
		 comment.setNickname(loginUser.getNickname());
		 // 원댓 group_no
		 
		 
		 FreeCommentDTO cmt2 = FreeCommentDTO.builder() 
		//		 .cmtNo(cmtNo)
				 .groupNo(groupNo)
				 .build();
		 
		 cmtMapper.updateGroupNo(cmt2);
		
		 
		
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
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		recomment.setNickname(loginUser.getNickname());
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isSaveRe", cmtMapper.insertRecomment(recomment) == 1);
		return result;
	}
	
	
}
