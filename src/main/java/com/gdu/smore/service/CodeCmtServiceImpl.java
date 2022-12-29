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

import com.gdu.smore.domain.code.CodeCommentDTO;
import com.gdu.smore.domain.user.UserDTO;
import com.gdu.smore.mapper.CodeCmtMapper;
import com.gdu.smore.util.PageUtil;


@Service
public class CodeCmtServiceImpl implements CodeCmtService {

	@Autowired
	private CodeCmtMapper cmtMapper;
	
	@Autowired
	private PageUtil pageUtil;
	
	
	@Override
	public Map<String, Object> getCmtCnt(int coNo) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("commentCnt",  cmtMapper.selectCommentCnt(coNo));
		
		return result;
	}
	
	@Override
	public Map<String, Object> getCmtList(HttpServletRequest request) {
		
		int coNo = Integer.parseInt(request.getParameter("coNo"));
		int page = Integer.parseInt(request.getParameter("page"));
		String ip = request.getRemoteAddr();
		
		int cmtCnt = cmtMapper.selectCommentCnt(coNo);
		pageUtil.setPageUtil(page, cmtCnt);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("coNo", coNo);
		map.put("ip", ip);
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("cmtList", cmtMapper.selectCommentList(map));
		result.put("pageUtil", pageUtil); 
		
		return result;
	}
	
	@Transactional
	@Override
	public Map<String, Object> saveComment(CodeCommentDTO comment) {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		 
		 int groupNo = Integer.parseInt(request.getParameter("groupNo"));
		 comment.setGroupNo(groupNo);
		 comment.setNickname(loginUser.getNickname());
		 // 원댓 group_no
		 
		 
		 CodeCommentDTO cmt2 = CodeCommentDTO.builder() 
		//		 .cmtNo(cmtNo)
				 .groupNo(groupNo)
				 .build();
		 
		 cmtMapper.updateGroupNo(cmt2);
		
		 
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isSave", cmtMapper.insertCodecmt(comment) == 1);
					// insert 결과가 1이면 true, 아니면 false 반환
	
		
		return result;
	}
	
	@Override
	public Map<String, Object> editComment(CodeCommentDTO comment) {
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
	public Map<String, Object> saveRecomment(CodeCommentDTO recomment) {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		recomment.setNickname(loginUser.getNickname());
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isSaveRe", cmtMapper.insertRecomment(recomment) == 1);
		return result;
	}
	
	
}
