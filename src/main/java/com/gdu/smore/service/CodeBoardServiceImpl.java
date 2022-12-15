package com.gdu.smore.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.smore.domain.code.CodeBoardDTO;
import com.gdu.smore.mapper.CodeBoardMapper;
import com.gdu.smore.util.MyFileUtil;
import com.gdu.smore.util.PageUtil;

@Service
public class CodeBoardServiceImpl implements CodeBoardService {
	
	private CodeBoardMapper codeboardMapper;
	private PageUtil pageUtil;
	private MyFileUtil myFileUtil;
	
	@Autowired
	public void set(CodeBoardMapper codeboardMapper, PageUtil pageUtil, MyFileUtil myFileUtil) {
		this.codeboardMapper = codeboardMapper;
		this.pageUtil = pageUtil;
		this.myFileUtil = myFileUtil;
	}
	
	public void getCodeBoardList(Model model) {
		
		// Model에 저장된 request 꺼내기
		Map<String, Object> modelMap = model.asMap();  // model을 map으로 변신
		HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
		
		// page 파라미터
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		// 전체 블로그 개수
		int totalRecord = codeboardMapper.selectCodeBoardListCount();
		
		// 페이징 처리에 필요한 변수 계산
		pageUtil.setPageUtil(page, totalRecord);
		
		// 조회 조건으로 사용할 Map 만들기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		// 뷰로 전달할 데이터를 model에 저장하기 
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("codeboardList", codeboardMapper.selectCodeBoardListByMap(map));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/codeboard/list"));
		
	}

	@Override
	public void saveCodeBoard(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int increseCodeBoardHit(int cNo) {
		return codeboardMapper.updateHit(cNo);
	}

	@Override
	public CodeBoardDTO getCodeBoardByNo(int cNo) {
		return codeboardMapper.selectCodeBoardByNo(cNo);
	}

	@Override
	public void modifyCodeBoard(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void removeCodeBoard(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}
	
	
	
	
	
	
	
	
}
